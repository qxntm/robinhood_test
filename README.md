# Task Management App

A Flutter application that demonstrates a task management system with TODO, DOING, and DONE states. Built as a technical assessment project for Purple Ventures co. ltd (Robinhood).

## Features

- View tasks organized by their status (TODO, DOING, DONE)
- Tasks are grouped by create date ascending (Today, Tomorrow, and future dates)
- Swipe-to-delete functionality for tasks
- Infinite scroll pagination for loading more tasks

## Technical Implementation

- **State Management**: Uses Flutter Riverpod for efficient state management
- **API Integration**: Implements REST API calls using Dio
- **Testing**: Includes unit tests and widget tests
- **UI Components**: Custom-built reusable widgets

### Installation

```
git clone https://github.com/qxntm/robinhood_test.git
cd task-management-app
flutter pub get
flutter run
```

### Running Test

```
flutter test
```

### Project Structure

lib/
├── components/ `Reusable UI components`
├── helper/ `Helper functions and utilities`
├── models/ `Data models`
├── notifiers/ `State management notifiers`
├── pages/ `Screen/Page widgets`
├── providers/ `Riverpod providers`
└── main.dart `Application entry point`

