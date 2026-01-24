# FlutterConf Paraguay Web 🇵🇾

The official website for **FlutterConf Paraguay**, built entirely with Flutter Web.

🔗 **Live Demo:** [https://flutterconf-py.web.app/](https://flutterconf-py.web.app/)

This project showcases a responsive, modern, and interactive landing page for the conference, featuring details about speakers, the agenda, sponsors, and the organizing team.

## 🚀 Features

-   **Responsive Design:** Optimized for both desktop and mobile web experiences.
-   **Dynamic Content:** Conference data (speakers, agenda, sponsors) is loaded dynamically from JSON configuration files, making it easy to update for future events (2024, 2025, 2026, etc.).
-   **Localization (i18n):** Full support for **English** and **Spanish**, automatically detecting or allowing users to switch languages.
-   **Smooth Navigation:** Interactive navigation bar with smooth scrolling to specific sections (Speakers, Agenda, Sponsors, Team).
-   **Animations:** Engaging UI with `lottie` animations and `animated_text_kit`.

## 🛠 Tech Stack

-   **Framework:** [Flutter](https://flutter.dev) (Web)
-   **Routing:** [go_router](https://pub.dev/packages/go_router)
-   **State Management:** [provider](https://pub.dev/packages/provider)
-   **Localization:** `flutter_localizations`, `intl`
-   **Responsive UI:** [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
-   **Fonts:** [google_fonts](https://pub.dev/packages/google_fonts)
-   **Assets & Gen:** [flutter_gen](https://pub.dev/packages/flutter_gen) for type-safe assets.

## 🏁 Getting Started

Follow these steps to set up and run the project locally.

### Prerequisites

-   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
-   A web browser (Chrome, Edge, Safari, etc.).

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/flutter_conf_web.git
    cd flutter_conf_web
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the project:**

    ```bash
    flutter run -d chrome
    ```

## 📂 Project Structure

```text
lib/
├── app/
│   ├── config/       # App-wide configuration
│   ├── models/       # Data models (Speaker, Agenda, etc.)
│   ├── notifiers/    # State notifiers (e.g., Language)
│   ├── pages/        # Main pages (LandingPage)
│   ├── sections/     # UI Sections (Agenda, Speakers, Sponsors...)
│   ├── services/     # Logic services (Config loading, URL handling)
│   └── widgets/      # Reusable UI components
├── core/
│   ├── constants/    # Global constants
│   └── themes/       # App theme and colors
├── gen/              # Generated assets (do not edit manually)
├── l10n/             # Localization files (.arb)
└── main.dart         # Entry point
```

## 🌐 Localization

The app supports English (`en`) and Spanish (`es`).
Translation files are located in `lib/l10n/arb/`.

To add new strings:
1.  Add the key-value pair to `app_en.arb` and `app_es.arb`.
2.  Run `flutter pub get` to regenerate the localization classes.

## 🎨 Asset Generation

This project uses `flutter_gen` to generate type-safe paths for assets (images, fonts, animations).

If you add new assets to the `assets/` folder, run:

```bash
flutter pub run build_runner build
```
*(Or simply `flutter pub get` usually triggers the generation depending on setup)*

---

## 👏 Credits & Attributions

<a href="https://www.flaticon.com/free-icons/linkedin" title="linkedin icons">Linkedin icons created by NajmunNahar - Flaticon</a>

<a href="https://www.flaticon.com/free-icons/twitter" title="twitter icons">Twitter icons created by Pixel perfect - Flaticon</a>

<a href="https://www.flaticon.es/iconos-gratis/github" title="github iconos">Github iconos creados por Pixel perfect - Flaticon</a>

<a href="https://www.flaticon.com/free-icons/instagram-logo" title="instagram logo icons">Instagram logo icons created by Freepik - Flaticon</a>

<a href="https://www.flaticon.com/free-icons/youtube" title="youtube icons">Youtube icons created by Freepik - Flaticon</a>

<a href="https://www.flaticon.com/free-icons/facebook" title="facebook icons">Facebook icons created by Freepik - Flaticon</a>