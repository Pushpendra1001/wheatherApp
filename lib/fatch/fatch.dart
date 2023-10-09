class GetValues {
  String temp;
  String Humidity;
  String windSpeed;
  String pressure;

  GetValues(
      {required this.temp,
      required this.Humidity,
      required this.pressure,
      required this.windSpeed});

  static GetValues fromApitoApp(Map data) {
    return GetValues(
      temp: data["main"]["temp"],
      Humidity: data["main"]["humidity"],
      pressure: data["main"]["pressure"],
      windSpeed: data["wind"]["speed"],
    );
  }
}
