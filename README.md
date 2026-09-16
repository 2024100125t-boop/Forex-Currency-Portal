# Forex Currency Portal

A Dart-based command-line application that retrieves and displays foreign exchange rate information using the ExchangeRate API.

## Project Description

The **Forex Currency Portal** is a command-line application developed using Dart. It connects to an online exchange-rate API to retrieve currency information and provides users with a simple interface for viewing exchange rates and performing currency conversions.

The project demonstrates API integration, JSON data processing, object-oriented programming, command-line interaction, error handling, logging, terminal styling, and automated testing.

## Objectives

The project aims to:

1. Retrieve foreign exchange rate information from an online API.
2. Process and convert JSON responses into Dart objects.
3. Provide a command-line interface for currency-related queries.
4. Allow users to retrieve exchange rates between different currencies.
5. Implement currency conversion functionality.
6. Handle network, API, timeout, and invalid input errors.
7. Use terminal colors to improve CLI output.
8. Implement logging for application activities and errors.
9. Organize the application using a Dart workspace with multiple packages.
10. Implement automated tests for project components.

## Features

* Retrieve current foreign exchange rates.
* Query exchange rates using currency codes.
* Perform currency conversions.
* Display currency and exchange-rate information through the CLI.
* Handle API and network errors.
* Handle invalid currency inputs.
* Use terminal colors for improved output.
* Record application events and errors through logging.
* Convert API JSON responses into Dart models.
* Include automated tests.

## Technologies Used

* **Dart**
* **Exchange Rate API**
* **HTTP**
* **JSON**
* **Dart Testing Framework**
* **ANSI Terminal Colors**
* **Git**
* **GitHub**

## Project Structure

```text
Forex_Currency_Portal_Workspace/
│
├── terminal_colors/
│   ├── lib/
│   │   ├── src/
│   │   │   ├── ansi.dart
│   │   │   └── terminal_colors_base.dart
│   │   ├── terminal_colors.dart
│   │   └── ...
│   ├── test/
│   └── pubspec.yaml
│
├── forex_api/
│   ├── lib/
│   │   ├── src/
│   │   │   ├── client.dart
│   │   │   ├── exceptions.dart
│   │   │   ├── models.dart
│   │   │   └── forex_api_base.dart
│   │   ├── forex_api.dart
│   │   └── ...
│   ├── test/
│   ├── example/
│   └── pubspec.yaml
│
├── forex_cli/
│   ├── bin/
│   │   ├── main.dart
│   │   └── forex_cli.dart
│   ├── lib/
│   │   ├── src/
│   │   │   ├── command_base.dart
│   │   │   ├── help_command.dart
│   │   │   ├── logging_config.dart
│   │   │   └── query_command.dart
│   │   └── forex_cli.dart
│   ├── test/
│   └── pubspec.yaml
│
├── pubspec.yaml
├── pubspec.lock
└── .gitignore
```

## Package Description

### terminal_colors

The `terminal_colors` package provides reusable ANSI terminal color constants and styling utilities for improving the command-line interface output.

### forex_api

The `forex_api` package manages communication with the foreign exchange API. It contains the API client, currency data models, and exception handling for exchange-rate requests.

### forex_cli

The `forex_cli` package provides the command-line interface of the application. It handles user commands, currency queries, conversion requests, help commands, logging, error messages, and formatted terminal output.

## Requirements

Before running the project, make sure the following are installed:

* Dart SDK 3.8.1 or later
* Git
* Internet connection

## Installation

Clone the repository:

```bash
git clone https://github.com/rastybillones8-creator/Forex_Currency_Portal_Workspace.git
```

Navigate to the project directory:

```bash
cd Forex_Currency_Portal_Workspace
```

Get the project dependencies:

```bash
dart pub get
```

## How to Run

Navigate to the CLI package:

```bash
cd forex_cli
```

Run the application:

```bash
dart run
```

## Example Usage

The application can be used to query exchange rates and perform currency conversions through the command-line interface.

Example:

```text
forex > query USD PHP
```

Example output:

```text
[INFO] Initiating exchange-rate query: USD to PHP

Base Currency: USD
Target Currency: PHP
Exchange Rate: 57.XX
```

The displayed exchange-rate information is retrieved from the configured foreign exchange API.

## API

This project uses an online foreign exchange API to retrieve currency exchange-rate data.

The API response contains information such as:

* Base currency
* Target currency
* Exchange rates
* Currency codes
* Conversion values

The application processes the JSON response and converts the relevant information into Dart objects before displaying it through the command-line interface.

## Error Handling

The application implements error handling for possible problems such as:

* Network connection failures
* API request failures
* Invalid currency codes
* Invalid API responses
* Timeout errors
* Invalid user input

Exceptions are handled using Dart exception-handling mechanisms.

## Logging

The CLI package includes logging functionality for recording application events, exchange-rate requests, and errors.

Logging helps monitor application activities and identify problems during execution.

## Testing

The project contains automated tests for selected application components. Testing helps verify that the API, data processing, commands, and other important functions work as expected.

## GitHub Repository

The project is organized as a Dart workspace with separate packages for terminal styling, API communication, and command-line functionality.
