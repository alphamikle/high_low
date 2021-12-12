abstract class Config {
  static const String apiToken = String.fromEnvironment('API_TOKEN', defaultValue: '');
}
