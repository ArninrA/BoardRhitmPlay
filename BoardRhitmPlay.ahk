#Requires AutoHotkey v2.0

; ============ НАСТРОЙКИ (можно крутить) ============
BoostPerPress := 5    ; на сколько поднимается шкала (0-100) от одного нажатия
StartVolume   := 20   ; с какой громкости начинается музыка после тишины
FadeOutSec    := 10   ; за сколько секунд шкала падает со 100 до 0

; ============ ПЕРЕМЕННЫЕ ============
Vol            := 0       ; сама шкала громкости, 0-100
IsMusicPlaying := false
HasSeenPlaying := false   ; видели ли мы, что трек реально заиграл
CurrentTrack   := 1
DecayPerTick   := 100 / (FadeOutSec * 10)  ; сколько отнимаем каждые 0.1 сек

; ============ ПЛЕЙЛИСТ: все .mp3 рядом со скриптом, по алфавиту ============
FileList := ""
Loop Files A_ScriptDir "\*.mp3"
    FileList .= A_LoopFileFullPath "`n"

if (FileList = "") {
    MsgBox "Рядом со скриптом не найдено ни одного .mp3 файла."
    ExitApp
}

Playlist := StrSplit(Sort(RTrim(FileList, "`n")), "`n")

; ============ ПЛЕЕР ============
Player := ComObject("WMPlayer.OCX")
Player.settings.autoStart := false
Player.URL := Playlist[CurrentTrack]

; ============ НАЖАТИЕ КЛАВИШИ ============
HandleInput(*) {
    global Vol, IsMusicPlaying, HasSeenPlaying, BoostPerPress, StartVolume, Player

    if (!IsMusicPlaying) {
        Vol := StartVolume
        Player.settings.volume := Round(Vol)
        Player.controls.play()
        IsMusicPlaying := true
        HasSeenPlaying := false
    } else {
        Vol := Min(100, Vol + BoostPerPress)
    }
}

; ============ СЛЕДУЮЩИЙ ТРЕК ============
NextTrack() {
    global CurrentTrack, Playlist, HasSeenPlaying, Player

    CurrentTrack += 1
    if (CurrentTrack > Playlist.Length)
        CurrentTrack := 1

    Player.URL := Playlist[CurrentTrack]
    Player.controls.play()
    HasSeenPlaying := false
}

; ============ ГЛАВНЫЙ ТАЙМЕР (каждые 0.1 сек) ============
MusicTick() {
    global Vol, IsMusicPlaying, HasSeenPlaying, DecayPerTick, Player

    if (!IsMusicPlaying)
        return

    ; 1) шкала понемногу падает
    Vol -= DecayPerTick

    ; 2) дошла до нуля - останавливаем (трек сбросится на начало)
    if (Vol <= 0) {
        Vol := 0
        Player.settings.volume := 0
        Player.controls.stop()
        IsMusicPlaying := false
        return
    }

    ; 3) не доиграл ли трек сам до конца?
    state := Player.playState
    if (state = 3)                                            ; 3 = играет
        HasSeenPlaying := true
    else if (HasSeenPlaying && (state = 1 || state = 8))      ; 1 = стоп, 8 = доиграл
        NextTrack()

    ; 4) громкость плеера = шкала
    Player.settings.volume := Round(Vol)
}

SetTimer MusicTick, 100

; ============ ХОТКЕИ НА КЛАВИШИ ============
AllKeys := []

Loop 26
    AllKeys.Push(Chr(96 + A_Index))    ; a-z
Loop 10
    AllKeys.Push(String(A_Index - 1))  ; 0-9

for k in ["Space", "Enter", "Tab", "Backspace", "Escape", "CapsLock",
          "Up", "Down", "Left", "Right",
          "LShift", "RShift", "LCtrl", "RCtrl", "LAlt", "RAlt",
          "Insert", "Delete", "Home", "End", "PgUp", "PgDn",
          "-", "=", "[", "]", "\", ";", "'", ",", ".", "/", "``"]
    AllKeys.Push(k)

Loop 12
    AllKeys.Push("F" A_Index)

for keyName in AllKeys
    try Hotkey("~" keyName, HandleInput)

; ============ КНОПКИ МЫШИ ============
~LButton::HandleInput()
~RButton::HandleInput()
~MButton::HandleInput()
~XButton1::HandleInput()
~XButton2::HandleInput()