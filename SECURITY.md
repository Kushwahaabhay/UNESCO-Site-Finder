# 🔒 Security Setup - API Keys Configuration

## ⚠️ IMPORTANT: Never Commit API Keys!

This project uses environment variables to keep your API keys secure and private.

---

## 📋 Quick Setup

### Step 1: Create `.env` File

Copy the example file and add your keys:

```bash
# Windows PowerShell
Copy-Item .env.example .env

# Linux/Mac
cp .env.example .env
```

### Step 2: Add Your API Keys to `.env`

Open `.env` file and add your actual API keys:

```env
# Google Maps API Key (REQUIRED)
GOOGLE_MAPS_API_KEY=your_actual_google_maps_key_here

# Gemini AI API Key (Optional - for chatbot)
GEMINI_API_KEY=your_actual_gemini_key_here

# Perplexity AI API Key (Optional - alternative chatbot)
PERPLEXITY_API_KEY=your_actual_perplexity_key_here
```

### Step 3: Update `lib/config/api_keys.dart`

Copy your keys from `.env` to `lib/config/api_keys.dart`:

```dart
class ApiKeys {
  static const String googleMapsApiKey = 'your_google_maps_key';
  static const String geminiApiKey = 'your_gemini_key';
  static const String perplexityApiKey = 'your_perplexity_key';
}
```

### Step 4: Update `android/local.properties`

Add the Google Maps key for Android:

```properties
GOOGLE_MAPS_API_KEY=your_google_maps_key
```

---

## 🔑 How to Get API Keys

### 1. Google Maps API Key (Required)

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable **"Maps SDK for Android"**
4. Go to **Credentials** → **Create Credentials** → **API Key**
5. Copy your API key
6. **(Recommended)** Restrict the key:
   - Click on the key
   - Under **Application restrictions**: Select **Android apps**
   - Add your package name: `com.example.nearest_unesco_site`
   - Add SHA-1 fingerprint (get with: `keytool -list -v -keystore ~/.android/debug.keystore`)

### 2. Gemini AI API Key (Optional - for AI Chatbot)

1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in with your Google account
3. Click **"Create API Key"**
4. Copy your API key
5. Free tier available with generous limits

### 3. Perplexity API Key (Optional - Alternative Chatbot)

1. Visit [Perplexity AI](https://www.perplexity.ai/)
2. Sign in or create account
3. Go to **Settings** → **API**
4. Generate new API key
5. Copy your API key

---

## 🛡️ Security Best Practices

### ✅ DO:
- Keep `.env` file in `.gitignore` (already configured)
- Keep `lib/config/api_keys.dart` in `.gitignore` (already configured)
- Keep `android/local.properties` in `.gitignore` (already configured)
- Use separate API keys for development and production
- Restrict API keys to specific apps/domains when possible
- Revoke exposed keys immediately

### ❌ DON'T:
- Never commit `.env` file to version control
- Never commit `api_keys.dart` with real keys
- Never share API keys in public forums
- Never hardcode keys in source files
- Never push `local.properties` to GitHub

---

## 📁 Protected Files (In `.gitignore`)

These files contain your actual API keys and are protected:

- ✅ `.env` - Environment variables
- ✅ `lib/config/api_keys.dart` - Dart API keys
- ✅ `android/local.properties` - Android configuration

---

## 🔍 Verify Setup

After adding your keys, verify everything is working:

```bash
# Check that sensitive files are ignored
git check-ignore .env lib/config/api_keys.dart android/local.properties

# Should output all three filenames (meaning they're ignored)
```

---

## 🆘 If Keys Are Exposed

If you accidentally commit API keys:

### 1. **Revoke Immediately**
- Google Maps: Regenerate in Cloud Console
- Gemini: Delete and create new in AI Studio
- Perplexity: Revoke in API settings

### 2. **Remove from Git History**
```bash
# Remove specific file from history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch path/to/file" \
  --prune-empty --tag-name-filter cat -- --all

# Force push to overwrite remote
git push origin --force --all
```

### 3. **Update Keys**
- Get new API keys
- Update `.env` file
- Update `api_keys.dart`
- Update `local.properties`

---

## 📝 For Team Members / Contributors

When cloning this repo:

1. Copy `.env.example` to `.env`
2. Copy `lib/config/api_keys_example.dart` to `lib/config/api_keys.dart`
3. Copy `android/local.properties.example` to `android/local.properties`
4. Add your own API keys
5. Never commit these files!

---

## ✅ Checklist

Before pushing to GitHub:

- [ ] `.env` is in `.gitignore`
- [ ] `api_keys.dart` is in `.gitignore`
- [ ] `local.properties` is in `.gitignore`
- [ ] No API keys in committed files
- [ ] Example files exist (`.env.example`, `api_keys_example.dart`)
- [ ] README explains how to set up API keys

---

## 📞 Need Help?

If you're having issues with API key setup:

1. Check the main [SETUP.md](SETUP.md) file
2. Read the [README.md](README.md) installation section
3. Verify files are properly ignored: `git status`
4. Make sure you copied the example files correctly

---

**🔒 Remember: Security is important! Never share your API keys publicly!**
