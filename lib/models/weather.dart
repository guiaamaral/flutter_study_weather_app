class WeatherData {
  String? city;
  String? condition;
  String? description;
  String? icon;
  String? temperature;
  String? feelsLike;
  String? minTemperature;
  String? maxTemperature;

  WeatherData({
    this.city,
    this.condition,
    this.description,
    this.icon,
    this.temperature,
    this.feelsLike,
    this.minTemperature,
    this.maxTemperature,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temperature: (json['main']['temp']).toStringAsFixed(1),
      feelsLike: (json['main']['feels_like']).toStringAsFixed(1),
      minTemperature: (json['main']['temp_min']).toStringAsFixed(1),
      maxTemperature: (json['main']['temp_max']).toStringAsFixed(1),
    );
  }
}
