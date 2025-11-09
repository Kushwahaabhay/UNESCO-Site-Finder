// ⚠️ SETUP INSTRUCTIONS:
// 1. Copy this file and rename it to 'api_keys.dart'
// 2. Replace the placeholder values below with your actual API keys
// 3. NEVER commit api_keys.dart to version control (it's in .gitignore)

class ApiKeys {
  // Google Maps API Key
  // Get your key from: https://console.cloud.google.com/google/maps-apis
  // Required: Enable "Maps SDK for Android" in Google Cloud Console
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY_HERE';

  // Gemini AI API Key (Optional - for chatbot feature)
  // Get your key from: https://makersuite.google.com/app/apikey
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';

  // Perplexity API Key (Optional - alternative chatbot)
  // Get your key from: https://www.perplexity.ai/settings/api
  static const String perplexityApiKey = 'YOUR_PERPLEXITY_API_KEY_HERE';
}
