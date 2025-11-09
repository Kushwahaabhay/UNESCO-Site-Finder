# 🚀 Quick Setup Guide

## Step 1: Clone & Install

```bash
git clone https://github.com/yourusername/nearest-unesco-site.git
cd nearest-unesco-site
flutter pub get
```

## Step 2: Configure API Keys

### Option A: Quick Setup (All-in-One)

1. **Copy the example API keys file:**
   ```bash
   # Windows PowerShell
   Copy-Item lib\config\api_keys_example.dart lib\config\api_keys.dart
   
   # Linux/Mac
   cp lib/config/api_keys_example.dart lib/config/api_keys.dart
   ```

2. **Edit `lib/config/api_keys.dart` and add your keys:**
   ```dart
   class ApiKeys {
     static const String googleMapsApiKey = 'YOUR_ACTUAL_KEY';
     static const String geminiApiKey = 'YOUR_ACTUAL_KEY'; // Optional
     static const String perplexityApiKey = 'YOUR_ACTUAL_KEY'; // Optional
   }
   ```

3. **Copy Android local properties:**
   ```bash
   # Windows PowerShell
   Copy-Item android\local.properties.example android\local.properties
   
   # Linux/Mac
   cp android/local.properties.example android/local.properties
   ```

4. **Edit `android/local.properties` and add:**
   ```properties
   sdk.dir=YOUR_ANDROID_SDK_PATH
   flutter.sdk=YOUR_FLUTTER_SDK_PATH
   GOOGLE_MAPS_API_KEY=YOUR_ACTUAL_KEY
   ```

### Option B: Manual Setup

Create `lib/config/api_keys.dart`:
```dart
class ApiKeys {
  static const String googleMapsApiKey = 'YOUR_KEY_HERE';
  static const String geminiApiKey = 'YOUR_KEY_HERE';
  static const String perplexityApiKey = 'YOUR_KEY_HERE';
}
```

## Step 3: Get API Keys

### Google Maps API (Required)
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create new project
3. Enable "Maps SDK for Android"
4. Go to Credentials → Create API Key
5. Restrict key to Android apps (optional but recommended)
6. Copy your key

### Gemini AI API (Optional - for chatbot)
1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Click "Create API Key"
3. Copy your key

### Perplexity API (Optional - alternative chatbot)
1. Visit [Perplexity](https://www.perplexity.ai/)
2. Go to Settings → API
3. Generate API key
4. Copy your key

## Step 4: Run the App

```bash
# Connect your Android phone via USB
# Enable USB Debugging in Developer Options

# Check device is connected
flutter devices

# Run the app
flutter run
```

## 🎯 Quick Test

After launching, test these features:
- ✅ Home screen loads
- ✅ "View All Sites" shows 42 sites
- ✅ Search works
- ✅ Tap a site to see details
- ✅ "Find Nearest Site" (requires location permission)
- ✅ Maps display correctly
- ✅ AI Chat works (if API key added)

## 🐛 Troubleshooting

### "Error: api_keys.dart not found"
→ You forgot to copy `api_keys_example.dart` to `api_keys.dart`

### "Maps not showing"
→ Check your Google Maps API key is correct and "Maps SDK for Android" is enabled

### "Build failed"
```bash
flutter clean
flutter pub get
flutter run
```

### "No devices found"
→ Enable USB Debugging on your Android phone and reconnect

## 💡 Pro Tips

- The chatbot is **optional** - the app works without it
- You can leave Gemini/Perplexity keys empty if you don't want the chatbot
- Google Maps key is **required** for maps to work
- First build takes 5-10 minutes, subsequent builds are faster

## 📱 Minimum Requirements

- Flutter 3.0.0+
- Android 5.0 (API 21)+
- Internet connection for maps
- Location permission for "Find Nearest" feature

---

**Need help?** Open an issue on GitHub!
