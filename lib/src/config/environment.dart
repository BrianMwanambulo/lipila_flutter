/// Lipila API environment configuration
enum Environment {
  /// Sandbox environment for testing
  sandbox('https://api.lipila.dev'),

  /// Production environment for live transactions
  production('https://api.lipila.io');

  const Environment(this.baseUrl);

  /// Base URL for the environment
  final String baseUrl;
}
