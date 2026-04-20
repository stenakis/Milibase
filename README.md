![Description](assets/logo_large.svg)

A Windows desktop application for **soldier management**, built during military service at **Ypiresia Faron**. Milibase tracks all essential soldier information throughout their service period — including leaves, transfers between service centers, and status changes.

> ⚠️ **This application is in Greek only** and is tailored for use within the Greek military administrative context.

---

## Features

### 👤 Soldier Profiles
Each soldier has a dedicated record storing all the key information needed during their service:
- Full name, rank, and military ID number
- Personal phone numbers for quick contact lookup
- Service start and end dates
- Current status (e.g. active, on leave, transferred, discharged)

### 🏖 Leave Management
- Log leave periods with start and end dates
- Store the official leave ID numbers (αριθμός άδειας) for reference
- View the full leave history of each soldier at a glance

### 🔄 Service Center Transfers
- Record when a soldier moves from one service center to another
- Keep a history of all transfers during the soldier's service period

### 📋 Status Tracking
- Track status changes throughout a soldier's service
- Quickly see the current status of any soldier without digging through paperwork

### 🔍 Local Data Lookup
Milibase is designed as a fast, offline-first reference tool. All data lives locally on the machine — no internet connection, no accounts, no syncing. Just a reliable place to look up soldier information quickly.

### 🔄 Automatic OTA Updates
The app checks for and applies over-the-air updates automatically, so it always stays up to date without any manual installation steps.

### 🗂 Offline & Private
All data is stored locally in a SQLite database on the host machine. Nothing is sent to any server — keeping sensitive military personnel data private and secure.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev) (Dart) |
| UI Library | [Fluent UI](https://pub.dev/packages/fluent_ui) |
| Database | [Drift](https://drift.simonbinder.eu/) + SQLite (via `sqflite_common_ffi`) |
| State / Streams | [RxDart](https://pub.dev/packages/rxdart) |
| Fonts | [Google Fonts](https://pub.dev/packages/google_fonts) |
| Window Management | [bitsdojo_window](https://pub.dev/packages/bitsdojo_window) |

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `^3.11.0` (beta channel)
- Windows desktop development enabled:
  ```
  flutter config --enable-windows-desktop
  ```

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/stenakis/Milibase.git
   cd Milibase
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate Drift database code:
   ```bash
   dart run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run -d windows
   ```

---

## Project Structure

```
Milibase/
├── assets/          # Images, SVGs, and other static assets
├── lib/             # Dart source code
├── test/            # Unit and widget tests
├── windows/         # Windows platform-specific files
├── pubspec.yaml     # Project dependencies
└── analysis_options.yaml
```

---

## Building for Release

```bash
flutter build windows --release
```

The output will be located in `build/windows/runner/Release/`.

---

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'Add my feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

## License

This project is currently unlicensed. All rights reserved by the author unless otherwise stated.

---

*Built with ❤️ using Flutter*
