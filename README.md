# BoardRhitmPlay

🇷🇺 [Русский](#русский) | 🇬🇧 [English](#english)

---

## Русский

Инструмент для принудительного вхождения в поток. Пока ты печатаешь или играешь,
играет музыка, и чем быстрее нажатия, тем она громче. Перестал нажимать, и музыка
затихает и останавливается.

Скрипт написан на AutoHotkey v2 с помощью ИИ (Claude, DeepSeek).

### Как это работает

- Есть шкала громкости от 0 до 100.
- Каждое нажатие клавиши на клавиатуре или кнопки мыши добавляет к ней 5 единиц.
- Каждую секунду шкала падает на 10 единиц. Чтобы держать громкость на одном
  уровне, нужно нажимать минимум две клавиши в секунду.
- Когда шкала доходит до нуля, музыка останавливается. Следующее нажатие запускает
  тот же трек с начала.
- Следующий трек включается только когда предыдущий доиграл до конца.

Нажатия не записываются и не сохраняются, скрипт только считает их количество.
Исходный код открыт: его можно прочитать в файле `BoardRhitmPlay.ahk`.

### Требования

Windows 10/11 (звук идёт через Windows Media Player).

### Установка

1. Скачай архив с репозиторием (Code → Download ZIP) и распакуй.
2. Положи свои `.mp3` файлы в папку рядом с `BoardRhitmPlay.exe` (см. «Музыка» ниже).
3. Запусти `BoardRhitmPlay.exe`.

Антивирус может отреагировать на `.exe`, скомпилированный из AutoHotkey. Это
обычное дело для таких программ. Если не хочешь запускать `.exe`, установи
AutoHotkey v2 (https://www.autohotkey.com/v2/) и запусти `.ahk` файл напрямую.

### Музыка

Треки в репозиторий не включены из-за авторских прав. Положи свои `.mp3` файлы
в папку рядом со скриптом. Название может быть любым, формат только `.mp3`. Треки
играют по алфавиту, поэтому для нужного порядка назови их `01_...mp3`, `02_...mp3`
и так далее. Если в папке нет ни одного `.mp3`, скрипт покажет сообщение об ошибке.

### Как остановить

Найди значок в трее (панель уведомлений), кликни по нему правой кнопкой и выбери
Exit. Пока скрипт запущен, `.exe` файл нельзя удалить или заменить.

### Настройки

Открой `BoardRhitmPlay.ahk` в любом текстовом редакторе. В начале файла:

- `BoostPerPress` — сколько единиц добавляет одно нажатие
- `StartVolume` — с какой громкости начинается музыка после тишины
- `FadeOutSec` — за сколько секунд шкала падает со 100 до 0

Чтобы применить изменения, останови скрипт (см. выше) и либо запусти `.ahk` напрямую,
либо пересобери `.exe` через Ahk2Exe (входит в установку AutoHotkey).

---

## English

A tool for forcing yourself into a flow state. Music plays while you type or play
games, and the faster you press keys, the louder it gets. Stop pressing, and the
music fades out and stops.

The script is written in AutoHotkey v2 with the help of AI (Claude, DeepSeek).

### How it works

- There is a volume meter from 0 to 100.
- Every keyboard key or mouse button press adds 5 points to it.
- Every second the meter drops by 10 points. To keep the volume steady, you need
  to press at least two keys per second.
- When the meter reaches zero, the music stops. The next key press restarts the
  same track from the beginning.
- The next track starts only after the current one has finished playing.

Key presses are not recorded or saved, the script only counts them. The source code
is open: you can read it in `BoardRhitmPlay.ahk`.

### Requirements

Windows 10/11 (audio is played through Windows Media Player).

### Installation

1. Download the repository (Code → Download ZIP) and unzip it.
2. Put your own `.mp3` files in the folder next to `BoardRhitmPlay.exe` (see "Music" below).
3. Run `BoardRhitmPlay.exe`.

Antivirus software may flag an `.exe` compiled from AutoHotkey. This is common for
such programs. If you prefer not to run the `.exe`, install AutoHotkey v2
(https://www.autohotkey.com/v2/) and run the `.ahk` file directly.

### Music

Tracks are not included in the repository because of copyright. Put your own `.mp3`
files in the folder next to the script. File names can be anything, but the format
must be `.mp3`. Tracks play in alphabetical order, so to control the order, name
them `01_...mp3`, `02_...mp3`, and so on. If there are no `.mp3` files in the
folder, the script shows an error message.

### How to stop

Find the icon in the system tray (notification area), right-click it and choose
Exit. While the script is running, you cannot delete or replace the `.exe` file.

### Settings

Open `BoardRhitmPlay.ahk` in any text editor. At the top of the file:

- `BoostPerPress` — how many points one key press adds
- `StartVolume` — the volume the music starts at after silence
- `FadeOutSec` — how many seconds it takes for the meter to fall from 100 to 0

To apply changes, stop the script (see above) and either run the `.ahk` file
directly or rebuild the `.exe` with Ahk2Exe (included with AutoHotkey).