# Favorites Management App

A simple Flutter application that allows users to manage a list of favorite items using the `Provider` package for state management and `SharedPreferences` for data persistence. This app demonstrates state management, persistent storage, and clean UI design principles in Flutter.

![e adewusi_StateManagement-Cover](https://github.com/user-attachments/assets/4ebfd9a4-cfcb-40ef-aeee-f8eed61fb6f0)

## Features

- Browse through a list of products with details like name, price, and image.
- Add or remove products from a favorites list.
- View and manage favorite items on a dedicated Favorites screen.
- Data persistence using `SharedPreferences` to maintain favorites across app sessions.
- Responsive UI with automatic updates using the `Provider` package.

## Getting Started

### Prerequisites

- Flutter SDK installed ([Installation Guide](https://docs.flutter.dev/get-started/install)).
- Code editor like [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/).
- Basic understanding of Flutter and Dart.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/eadewusic/Flutter-Projects.git
   ```
2. Navigate to the project directory:
   ```bash
   cd favorites_management
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## App Key Components

### 1. State Management
- The `Favorites` class in `favorites.dart` extends `ChangeNotifier` to manage the list of favorite items and notify the UI of changes.

### 2. Data Persistence
- The app uses `SharedPreferences` to store and retrieve the favorites list, ensuring the data persists across app sessions.

### 3. User Interface
- `ProductListScreen` displays a list of products, allowing users to favorite/unfavorite them.
- `FavoritesScreen` displays the list of favorite items and allows users to remove items from the list.

## How The App Works

1. **Product List Screen**:
   - Displays products in a scrollable list.
   - Each product has an add/remove favorite button.
   - Clicking the floating action button navigates to the Favorites screen.

2. **Favorites Screen**:
   - Displays a list of user-selected favorites.
   - Each item has a delete button to remove it from the list.

3. **State Management**:
   - `Provider` automatically updates the UI when the favorites list is modified.

4. **Data Persistence**:
   - Favorites are saved to local storage using `SharedPreferences` and reloaded when the app starts.

## Dependencies

- `provider: ^6.0.5` - For state management.
- `shared_preferences: ^2.0.16` - For data persistence.
- `logger: ^1.0.0` - For debugging and error handling.

Install these dependencies using:
```bash
flutter pub get
```

## Contributing

Contributions are welcome! Feel free to fork the repository and submit a pull request.

1. Fork the project.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your message here"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request.
