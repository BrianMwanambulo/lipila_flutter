/// Lipila API environment configuration
enum Environment {
  /// Sandbox environment for testing
  sandbox('https://api.lipila.dev/api/v1'),

  /// Production environment for live transactions
  production('https://api.lipila.io/api/v1');

  const Environment(this.baseUrl);

  /// Base URL for the environment
  final String baseUrl;
}
