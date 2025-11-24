// API Keys Configuration
// This file gets its values from environment variables at build time

class ApiKeys {
  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: 'YOUR_API_KEY_HERE', // Fallback for local development
  );
}
