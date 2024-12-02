# ExploreX: A Country Explorer App 🌍

**ExploreX** is a mobile application built with Flutter that allows users to explore detailed information about countries around the world. By integrating with the **REST Countries API**, the app provides a comprehensive overview of demographics, geography, and culture for each country. Users can search for countries, view their details, compare countries side-by-side, and keep track of their comparison history for reference.

## Purpose & App Overview 🌟

The **ExploreX** app enables users to:
- Search for and explore key data about any country globally, such as demographics, region, and cultural information.
- Compare countries based on specific metrics such as population, area, languages, and currencies.
- Track their country comparison history with a new **History Screen** to see past country comparisons.

It is designed to provide an interactive, educational tool for anyone interested in world geography and cultural data.

## API Integration 🌐

### REST Countries API
The **REST Countries API** serves as the backbone of the app, providing real-time country data. 

- **Base URL**: `https://restcountries.com/v3.1/`
- **Key Endpoints**:
  1. `/name/{country}` – Search for a country by name to retrieve detailed information.
  2. `/all` – Retrieve data for all countries in the database.

The API provides comprehensive country data, including:
- Demographic data (e.g., population, area)
- Cultural information (e.g., languages, currencies)
- Geographical details (e.g., flags, regions)

## Key Screens & Their Functionalities 📱

### 1. **Home/Search Screen**
   - **Functionality**: 
     - Users can search for a country by name.
     - Displays a list of matching countries with basic information (name, flag, and region).
   - **Widgets Used**:
     - `TextField`, `ListView`, `Card`, `Image`.
   
### 2. **Country Details Screen**
   - **Functionality**:
     - Displays detailed information about a selected country (flag, name, capital, population, languages, currencies, etc.).
     - Includes a button to add the country to the comparison list.
   - **Widgets Used**:
     - `Column`, `Container`, `Text`, `Image`.

### 3. **Compare Screen**
   - **Functionality**:
     - Allows users to compare two countries side-by-side on various key metrics (e.g., population, area, languages, currencies).
     - Includes a reset button to clear the comparison and start fresh.
   - **Widgets Used**:
     - `Row`, `Card`, `TextButton`.

### 4. **History Screen (Bottom Sheet)**
   - **Functionality**:
     - Displays a list of the user's previous country comparisons.
     - Allows users to view and revisit past comparisons easily.
     - The history is shown using a bottom sheet, which provides a smooth and intuitive way to access historical data without interrupting the user’s workflow.
   - **Widgets Used**:
     - `ListView`, `Text`, `Card`, `BottomSheet`.

## Architecture & State Management 🛠️

- **Provider**: The app uses **Provider** for state management, ensuring that user selections (e.g., selected countries for comparison) are consistent across different screens. 
  - The state is shared between the `Home`, `Country Details`, `Compare`, and `History` screens.
  - **Provider** ensures smooth and efficient data flow, keeping the app responsive even with multiple states to manage.

## Installation & Setup 🚀

### Prerequisites
1. [Flutter](https://flutter.dev/docs/get-started/install) installed.
2. A device or emulator for testing.

### Steps to Run the App
1. Clone the repository:
   ```bash
   git clone https://github.com/eadewusic/Flutter-Projects/tree/main/individual_assignment_2
   ```
2. Navigate to the project directory:
   ```bash
   cd individual_assignment_2
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Challenges & Solutions 🤔

### 1. **Managing State Across Screens**
   - **Challenge**: Keeping the selected country and comparison data consistent across multiple screens posed a challenge, especially when transitioning between the `Country Details` and `Compare` screens.
   - **Solution**: Used **Provider** to share state across screens. By managing the selected country and comparison data in a centralized provider, it became easy to maintain consistency and ensure the app's data stayed up-to-date.

### 2. **Handling Bottom Sheet Interaction**
   - **Challenge**: Displaying comparison history via the bottom sheet required careful attention to ensure smooth interactions and that it didn’t obstruct other UI elements.
   - **Solution**: Implemented a clear layout and easy-to-dismiss bottom sheet for a seamless experience. Users can interact with the history without disrupting their current actions.

## Future Improvements 🚀

- **User Preferences**: Add the ability for users to save favorite countries to easily access them later.
- **Offline Support**: Implement local storage to allow users to view previously fetched data when offline.
- **Map View**: Introduce a map view where users can visually explore geographical data and countries.
- **Additional Comparisons**: Expand the comparison feature to include more metrics like GDP, literacy rates, or climate data.

## Credits 🙌

- **API**: [REST Countries API](https://restcountries.com/)
- **Framework**: Flutter
