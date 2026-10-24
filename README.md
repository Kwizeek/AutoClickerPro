# AutoClickerPro site

Статический сайт AutoClickerPro от Kwizeek для GitHub Pages. Сборка и npm-пакеты не требуются.

## Публикация на GitHub Pages

1. Создай публичный репозиторий, например `AutoClickerPro`.
2. Загрузи в корень репозитория файлы `index.html`, `style.css`, `script.js`, `README.md`, а также папки `assets/` и `downloads/`.
3. Открой **Settings → Pages**.
4. Выбери **Deploy from a branch**, ветку `main` и папку `/ (root)`, нажми **Save**.
5. Сайт появится по адресу `https://ТВОЙ-ЛОГИН.github.io/AutoClickerPro/`.

Ссылка на загрузку установщика относительная, поэтому работает на GitHub Pages и собственном домене.

## Установщик Windows

Файл `downloads/AutoClickerPro-Setup.exe` — самораспаковывающийся 64-разрядный установщик. Он устанавливает приложение в `%LOCALAPPDATA%\Programs\AutoClickerPro`, создаёт ярлыки на рабочем столе и в меню «Пуск» и не требует прав администратора. В конце можно запустить приложение.

В `installer-source/` лежат приложение и скрипты установки. Для пересборки установщика на Windows с установленным 7-Zip запусти `installer-source/build-installer.ps1`. Готовый файл будет сохранён в `downloads/AutoClickerPro-Setup.exe`.
