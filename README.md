# Flutter Auth App

A simple Flutter application featuring user authentication and profile management using a local SQLite database. UI designed with Google Stitch.

---

## Features

- **Sign Up** — Register a new account with name, email, and password
- **Sign In** — Login with registered credentials
- **Dashboard** — View profile information pulled from registration data
- **Edit Profile** — Update name and other personal details

---

## Tech Stack

| Layer | Tool |
|---|---|
| Framework | Flutter (Dart) |
| Local Database | SQLite via `sqflite` |
| UI Design | Google Stitch |
| IDE | Android Studio |

---

## Screens

### 1. Sign Up
- Input fields: Full Name, Email, Password, Confirm Password
- Saves user data to local SQLite database on registration

### 2. Sign In
- Input fields: Email, Password
- Validates credentials against the local SQLite database

### 3. Dashboard (Home)
- Displays user's name and email from registration
- Shows basic account info cards
- Edit Profile button to navigate to profile screen

### 4. Edit Profile
- Pre-filled with current user data
- Allows updating Full Name
- Email is read-only
- Saves changes to SQLite database

---

## Project Structure

```
lib/
├── main.dart
│
├── app/
│   └── user_signup_app.dart
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   │
│   ├── theme/
│   │   └── app_theme.dart
│   │
│   ├── routes/
│   │   └── app_routes.dart
│   │
│   ├── database/
│   │   └── db_helper.dart
│   │
│   └── utils/
│       └── validators.dart
│
├── shared/
│   └── widgets/
│       ├── primary_button.dart
│       └── custom_text_field.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── user_model.dart
│   │   │   └── auth_local_data_source.dart
│   │   │
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── sign_in_screen.dart
│   │       │   └── sign_up_screen.dart
│   │       │
│   │       └── widgets/
│   │           └── auth_header.dart
│   │
│   └── dashboard/
│       └── presentation/
│           ├── screens/
│           │   ├── dashboard_screen.dart
│           │   └── edit_profile_screen.dart
│           │
│           └── widgets/
│               └── profile_info_card.dart
│
assets/
└── icons/                                # App icons and images
```

---

## Database Schema

**Table: `users`**

| Column | Type | Description |
|---|---|---|
| id | INTEGER (PK) | Auto-incremented user ID |
| name | TEXT | Full name |
| email | TEXT | Email address (unique) |
| password | TEXT | User password |

---

## Getting Started

### Prerequisites
- Flutter SDK installed
- Android Studio installed
- An Android emulator or physical device

### Installation

1. **Clone or open the project in Android Studio**

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.8.3
```

---

## How It Works

```
User fills Sign Up form
        ↓
Data saved to SQLite (local device storage)
        ↓
User logs in via Sign In screen
        ↓
Credentials checked against SQLite
        ↓
Dashboard loads user data from SQLite
        ↓
User edits profile → SQLite updated
```

---

## Notes

- All data is stored **locally on the device** — no internet connection or backend server required
- This project was built as a fresher-level portfolio submission demonstrating local database integration in Flutter

---

## Author

**EMON HOSSAIN**  
Flutter Developer  
emonh.work@gmail.com · github.com/emonh001