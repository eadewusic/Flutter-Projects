# ExploreX: A Country Explorer App 🌍

**ExploreX** is a mobile application built with Flutter that allows users to explore information about countries worldwide. Using the REST Countries API, the app provides detailed data about demographics, geography, and culture. Users can search for countries, view details, and compare metrics across nations.

## Features ✨

1. **Search for Countries**: 
   - Search by country name to view matching results with basic information (name, region, flag).

2. **Country Details**:
   - View comprehensive details about a selected country, including:
     - Flag
     - Name, capital, population
     - Region and subregion
     - Languages and currencies

3. **Compare Countries**:
   - Select two countries to compare side-by-side on key metrics:
     - Population
     - Area
     - Languages
     - Currencies

## API Integration 🌐

### REST Countries API
- **Base URL**: `https://restcountries.com/v3.1/`
- **Endpoints Used**:
  1. `/name/{country}` - Search for a country by name.
  2. `/all` - Retrieve data for all countries.
- **Purpose**: Fetch detailed country data, including demographics, geography, and flags.

## Screens 📱

### 1. Home/Search Screen
- **Functionality**: 
  - Search for a country by name.
  - Display a list of matching countries with flags and basic details.
- **Widgets Used**:
  - `TextField`, `ListView`, `Card`, `Image`.

### 2. Country Details Screen
- **Functionality**:
  - Show detailed information about a selected country.
  - Include a button to add the country to a comparison list.
- **Widgets Used**:
  - `Column`, `Container`, `Text`, `Image`.

### 3. Compare Screen
- **Functionality**:
  - Display two selected countries side-by-side for comparison.
  - Provide a reset button to clear the comparison.
- **Widgets Used**:
  - `Row`, `Card`, `TextButton`.

## State Management 🛠️
- **Provider**:
  - Manages shared state across screens (e.g., selected countries for comparison).
  - Keeps the app responsive and consistent.


## Installation & Setup 🚀

### Prerequisites
1. [Flutter](https://flutter.dev/docs/get-started/install) installed.
2. A device or emulator for testing.

### Steps
1. Clone this repository:
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

1. **Handling API Errors**:
   - **Challenge**: Slow responses or invalid search queries.
   - **Solution**: Added loading indicators and error messages for a smooth user experience.

2. **Managing State Across Screens**:
   - **Challenge**: Keeping data consistent between screens.
   - **Solution**: Used `Provider` for seamless state management.

3. **UI Responsiveness**:
   - **Challenge**: Ensuring a consistent experience on different screen sizes.
   - **Solution**: Used responsive design principles with `MediaQuery`.

## Future Improvements 🚀
- Add user preferences to save favorite countries.
- Implement offline support using local storage.
- Introduce a map view for geographical exploration.


## Credits 🙌

- **API**: [REST Countries API](https://restcountries.com/)
- **Framework**: Flutter
