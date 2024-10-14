# Finance Digest App

Welcome to the Finance Digest App! This README provides an overview of the application, including implemented screens, improvements that can be added, and instructions for running the app and tests.

## Folder Structure
```
finance_digest/
├── lib/
│   ├── components/        # Reusable UI components
│   ├── constants/         # Application-wide constants (e.g., colors, fonts)
│   ├── features/          # Feature modules (e.g., signup, dashboard)
│   │   ├── signup/        # Signup feature containing UI and logic
│   │   ├── home/          # Home feature containing dashboard and other main screens
│   ├── services/          # Services such as authentication and notifications
│   ├── utils/             # Utility functions and helpers
├── test/                  # Unit and widget tests
├── pubspec.yaml           # Project dependencies
```


## Implemented Screens
1. **Splash Screen**: Displays an introductory splash screen with the app logo to give users a first impression and to perform background tasks.
2. **Legal Name Entry**: Prompts the user to enter their first and last names for account creation.
3. **Notifications Permission**: Asks the user for permission to send notifications, helping them stay updated.
4. **Dashboard**: Shows personalized news items to the user, including their name in the greeting.
5. **Dashboard Error Handling**: Handles errors by displaying a message when there is an issue loading the news.
6. **Unit Testing**: Added two unit test cases to auth service .

## Improvements To Be Added
1. **Skeleton Loading**: Add skeleton loaders during data fetching to improve user experience.
2. **Input Validation**: Add stricter validation for the user name fields, such as character limits and disallowing special characters.
3. **Retry Mechanism**: Provide retry buttons for users when errors occur, especially when there are issues with network requests.
4. **Pull to Refresh**: Add a pull-to-refresh mechanism for the dashboard news list.
5. **Offline Data Persistence**: Cache news items locally to provide users with an offline experience.
6. **Unit and Integration Testing**: Add more thorough tests to ensure stability, particularly around onboarding flow and error handling.

## Running the App
### Requirements
- **Java SDK**: Minimum version required is JDK 17. Make sure that JAVA_HOME is correctly set.
- **Flutter**: Make sure you have Flutter SDK installed.

### Commands
- **Flutter Run**: To run the application, use the following command:
  ```sh
  flutter run --dart-define=API_KEY=ADD_YOUR_API_KEY_HERE
  ```
  This command includes the required API key for accessing the news API.

- **Run Tests**: To run the test suite, use the following command:
  ```sh
  flutter test
  ```
  This runs the unit and widget tests to verify the behavior of the app.

- **Generate Mock Files**: If you are using `mockito` for unit testing, generate the mock files by running:
  ```sh
  dart run build_runner build
  ```
  This command generates the mock classes for your tests.

## Testing and Quality Assurance
### Unit Tests
Unit tests are written to verify different parts of the application. For example:
- Testing navigation logic based on whether the user has signed up.
- Testing user data persistence in `SharedPreferences`.

Run the unit tests using:
```sh
flutter test
```


## Java SDK Setup
Make sure that your Java SDK version is 17 or above, and set the `JAVA_HOME` environment variable accordingly. This is crucial for Android builds.

## Notes
- Always ensure the `API_KEY` is correctly set when running the app using the `--dart-define` flag.
- If issues occur while running the app or tests, verify that dependencies are correctly installed, and the SDK versions are compatible.

We are continuously working to improve the app and welcome contributions or feedback to enhance the onboarding experience and app performance.

## Contributing
We welcome contributions to improve Finance Digest. Feel free to fork the repository and submit pull requests. For major changes, please open an issue first to discuss what you would like to change.

### How to Contribute
1. **Fork the Repository**: Click on the "Fork" button at the top right corner of this repository to create your copy.
2. **Clone the Forked Repository**: Use the following command to clone your forked repository to your local machine:
   ```sh
   git clone https://github.com/your-username/finance_digest.git
   ```
3. **Create a New Branch**: Create a new branch for your feature or bug fix.
   ```sh
   git checkout -b feature/your-feature-name
   ```
4. **Make Changes**: Make your code changes and improvements.
5. **Commit Changes**: Commit your changes with a descriptive commit message.
   ```sh
   git commit -m "Add your feature description here"
   ```
6. **Push Changes**: Push your changes to your forked repository.
   ```sh
   git push origin feature/your-feature-name
   ```
7. **Create a Pull Request**: Go to the original repository and click on "Compare & pull request" to submit your changes for review.

## License
This project is licensed under the MIT License.

## Contact
For any questions or suggestions, please feel free to open an issue or contact the maintainers of this repository.
