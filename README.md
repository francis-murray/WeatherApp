# WeatherApp

<em>Sorbonne Université • L3 DANT 2019/2020 • LU3IN107 - Swift Project</em>

## Contributors:

- Massyl DJEMAI
- Francis MURRAY

## Project description:

The goal of this application is to be able to fetch and display the weather for a selected city using the [OpenWeatherApp API](https://openweathermap.org/api).
The app will display the current weather as well as the weather forecast for the next five days.

## Getting Started:

- Download file `city.list.min.json` from http://bulk.openweathermap.org/sample/ and place it in your `Documents` folder.

  - The file contains an array of City JSON objects that look like this:

    ```json
    [
      {
        "id": 2988506,
        "name": "Paris",
        "state": "",
        "country": "FR",
        "coord": {
          "lon": 2.34864,
          "lat": 48.85339
        }
      },
      {
        "id": 5128581,
        "name": "New York City",
        "state": "NY",
        "country": "US",
        "coord": {
          "lon": -74.005966,
          "lat": 40.714272
        }
      },
      {
        "id": 5368361,
        "name": "Los Angeles",
        "state": "CA",
        "country": "US",
        "coord": {
          "lon": -118.243683,
          "lat": 34.052231
        }
      }
    ]
    ```

## Operations:

- Search a city by its name
  - By matching the user entered name with the corresponding City object name property in the `city.list.min.json` file.

* Search current weather conditions for a city or a list of cities:

  - API: Current weather data (https://openweathermap.org/current)

    - Call current weather data for one location
      - By city ID
        - API Call: api.openweathermap.org/data/2.5/weather?id={cityId}&units={UNITS}&appid={APIKEY}`
        * Example of response when searching for Paris current weather data with the metrics system:
          ```json
          {
            "coord": {
              "lon": 2.35,
              "lat": 48.85
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "base": "stations",
            "main": {
              "temp": 10.09,
              "feels_like": 6.06,
              "temp_min": 10,
              "temp_max": 10.56,
              "pressure": 1003,
              "humidity": 87
            },
            "visibility": 10000,
            "wind": {
              "speed": 5.1,
              "deg": 220
            },
            "clouds": {
              "all": 90
            },
            "dt": 1588291119,
            "sys": {
              "type": 1,
              "id": 6550,
              "country": "FR",
              "sunrise": 1588307370,
              "sunset": 1588359937
            },
            "timezone": 7200,
            "id": 2968815,
            "name": "Paris",
            "cod": 200
          }
          ```

    * Call current weather data for several cities
      - Call for several city IDs
        - API Call: http://api.openweathermap.org/data/2.5/group?id={[cityIds]}&units={UNITS}&appid={APIKEY}

- Search 5 day weather forecast for city:

  - API: Call 5 day / 3 hour forecast data (https://openweathermap.org/forecast5)

    - By city ID

      - API call: api.openweathermap.org/data/2.5/forecast?id={cityId}&units={UNITS}&appid={APIKEY}
