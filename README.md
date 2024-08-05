# Starling Bank Round-Up Savings iOS Application
Starling Bank Round UP - iOS Tech Test by Donald King (donaldthedeveloper@gmail.com)

![Simulator Screen Recording - iPhone 15 Pro - 2024-08-05 at 13 05 40](https://github.com/user-attachments/assets/01fa0b46-1599-46af-81b7-3ee7d2c673ce)

## Overview

This iOS application is designed to help customers round up their weekly transactions to the nearest pound and transfer the accumulated amount into a savings goal. The application is written in Swift, using UIKit, and follows a modular architecture with Swift Packages (Local). The project is built with scalability in mind, allowing for easy distribution across teams and future feature expansion.

## Features

- **Transaction Round-Up:** Automatically calculates the round-up amount for all transactions in a given week.
- **Savings Goal Transfer:** Transfers the calculated round-up amount into a specified savings goal.
- **Modular Architecture:** The application is divided into multiple feature modules using Swift Packages.
- **Dependency Injection:** Utilizes a dependency container architecture for better testability and maintainability.
- **Unit Testing:** Core features of the application are covered with unit tests.

## Project Structure

The application is organized into the following Swift Packages, each representing a feature module:

- **SBAccount:** Handles account-related functionalities.
- **SBAccountInterface:** Defines interfaces for account-related operations.
- **SBDependencyContainer:** Manages dependency injection across the application.
- **SBSavingsGoal:** Manages savings goal functionalities.
- **SBSavingsGoalInterface:** Defines interfaces for savings goal-related operations.
- **SBTransaction:** Manages transaction-related functionalities.
- **SBTransactionInterface:** Defines interfaces for transaction-related operations.
- **SBWebClient:** Handles network communication with the backend API.
- **SBWebClientInterface:** Defines interfaces for web client operations.
- **SBNetwork:** Provides networking utilities and handles HTTP requests and responses.
- **SBFoundation:** Includes foundational utilities, extensions, and helpers commonly used across the application.
- **SBCommonModels:** Defines common data models that are shared across different modules of the application.

### Package Descriptions

- **SBAccount & SBAccountInterface:**
  - **SBAccount:** Implements the core logic for managing user accounts.
  - **SBAccountInterface:** Defines protocols and interfaces that `SBAccount` conforms to, ensuring loose coupling and easy mock implementations for testing.

- **SBDependencyContainer:**
  - Manages the application's dependencies, allowing for flexible dependency injection and improving testability by decoupling components.

- **SBSavingsGoal & SBSavingsGoalInterface:**
  - **SBSavingsGoal:** Implements functionality for creating and managing savings goals.
  - **SBSavingsGoalInterface:** Defines the interfaces that `SBSavingsGoal` adheres to, ensuring consistency and modularity.

- **SBTransaction & SBTransactionInterface:**
  - **SBTransaction:** Manages the logic for fetching and processing user transactions.
  - **SBTransactionInterface:** Provides the interfaces for transaction-related operations, facilitating integration and testing.

- **SBWebClient & SBWebClientInterface:**
  - **SBWebClient:** Handles all HTTP network communication with the backend, making API requests and processing responses.
  - **SBWebClientInterface:** Defines the protocols that `SBWebClient` implements, enabling mocking and testing of network interactions.

- **SBNetwork:**
  - A utility package that provides networking capabilities, including making HTTP requests, handling responses, and managing API endpoints.

- **SBFoundation:**
  - Contains foundational utilities, extensions, and helpers that are used across various modules. This includes common date formatting, string manipulation, and other shared utilities.

- **SBCommonModels:**
  - Defines shared data models that are used across multiple modules, such as `Account`, `Transaction`, and `SavingsGoal`. These models are designed to be reusable and consistent throughout the application.

## Architecture

The application follows a Dependency Container architecture, which promotes loose coupling between components and improves testability. Each feature is encapsulated in a Swift Package, allowing teams to work independently on different parts of the application.

### Key Architectural Concepts

- **App Architecture:** The app features uses MVVM-C architecure pattern.
- **Dependency Injection:** The application uses dependency injection to manage the creation and lifecycle of dependencies. This is handled by the `SBDependencyContainer` package.
- **Feature Modules:** Each feature of the application is encapsulated in a Swift Package. Interfaces are defined in separate packages (e.g., `SBAccountInterface`), which are implemented by the corresponding feature packages (e.g., `SBAccount`).
- **Unit Testing:** The application includes unit tests for core features, ensuring that the business logic is reliable and maintainable.

## Setup Instructions

### Prerequisites

- Your own Starling Bank Development Access Token. This must be a fresh access token because token refresh was not implemented in this iteration.
- Xcode, Obviously!
- iOS 15+

### Clone the Repository

```bash
git clone https://github.com/donaldking/starling-roundup.git
cd starling-roundup
```

### Running the app

- Open the `StarlingBank.xcodeproj`
- Open `StarlingBank/AppDependencyConfig.swift` file

<img width="395" alt="Screenshot 2024-08-05 at 13 58 00" src="https://github.com/user-attachments/assets/d73a6562-6070-4b10-b0b4-e3b2d13d1bdb">

- Set your token to the constant. **THIS MUST BE AN UNEXPIRED STARLING BANK DEVELOPER ACCESS TOKEN**
  ```swift
  private let token = ""
  ```
- Select any iOS Simulator from iOS 15 and above
- Run the app... enjoy.


