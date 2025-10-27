# Currency Converter App

A simple currency converter application built with Flutter.

## Features

*   Real-time currency conversion using an exchange rate API.
*   Selection of source and target currencies.
*   Displays the converted amount.

## Dependencies

*   http: For making API requests.
*   provider: For state management.
*   shared_preferences: For persistent storage of preferred currencies.

## API Key

This app requires an API key to access the exchange rate data.  You'll need to obtain one from a service like ExchangeRate-API and place it in the `.env` file (see below).

## Setup

1.  Clone the repository.
2.  Run `flutter pub get` to install dependencies.
3.  Create a `.env` file in the root directory and add your API key:

    
    API_KEY=YOUR_API_KEY
    

## Running the app


flutter run

