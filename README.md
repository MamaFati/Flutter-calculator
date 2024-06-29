# Calculator App

This is a simple calculator application built using Flutter. It supports basic arithmetic operations and percentage calculations.

## Features

- Basic arithmetic operations: addition, subtraction, multiplication, and division.
- Percentage conversion.
- Clear and delete functionality.

# Project Structure

The project consists of the following main files:

1. `main.dart`: The entry point of the application.
2. `calculator_screen.dart`: The main screen of the calculator, containing the UI and logic.
3. `button_values.dart`: Defines the button values and their labels.

# Installation
To run this project locally, follow these steps:

1. Clone the repository:
```
git clone https://github.com/MamaFati/calculator.git
cd calculator

```
2. Install dependencies:
```
flutter pub get

```
3. Run the app
```
flutter run
```
## Usage
The calculator app has a simple and intuitive interface. The display shows the current input and result. The buttons are laid out in a grid, with different colors for different types of operations:

    Numeric buttons (0-9): Black background.
    Operator buttons (+, -, ×, ÷, =): Orange background.
    Special buttons (C, D, %): Blue-grey background.

### Functionality
Addition (+): Adds two numbers.
Subtraction (-): Subtracts the second number from the first.
Multiplication (×): Multiplies two numbers.
Division (÷): Divides the first number by the second.
Percentage (%): Converts the current number to a percentage.
Clear (C): Clears all inputs.
Delete (D): Deletes the last entered digit or operator.
Equal (=): Calculates the result based on the current input.