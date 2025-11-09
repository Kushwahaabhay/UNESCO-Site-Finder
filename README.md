# Nearest UNESCO Site - Flutter App

<div align="center">
  <h3>🏛️ Discover India's UNESCO World Heritage Sites</h3>
  <p>A beautiful Flutter mobile app to find and explore all 42 UNESCO World Heritage Sites in India</p>
</div>

---

## 📱 Features

- 🎯 **Find Nearest Site** - Uses GPS to locate the closest UNESCO site to your current location
- 🗺️ **Interactive Maps** - Google Maps integration with site markers and directions
- 📋 **Complete List** - Browse all 42 UNESCO World Heritage Sites in India
- 🔍 **Search & Filter** - Search by name and filter by state
- 🔄 **Sort Options** - Sort by name, distance, or state
- 📖 **Detailed Information** - Comprehensive details about each site
- 🤖 **AI Chatbot** - Ask questions about sites using Gemini/Perplexity AI
- 🔗 **External Links** - Quick access to Wikipedia and ASI ticket booking
- ⭐ **Favorites** - Bookmark your favorite sites
- 🌙 **Dark Mode** - Full dark mode support
- 🎨 **Modern UI** - Material Design 3 with beautiful animations

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android SDK (API 21 or higher)
- Google Maps API Key
- (Optional) Gemini/Perplexity API Key for chatbot

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/nearest-unesco-site.git
   cd nearest-unesco-site
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Keys**

   **Method 1: Dart Configuration (Recommended for chatbot)**
   - Copy `lib/config/api_keys_example.dart` to `lib/config/api_keys.dart`
   - Add your API keys to `lib/config/api_keys.dart`:
     ```dart
     class ApiKeys {
       static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
       static const String geminiApiKey = 'YOUR_GEMINI_API_KEY'; // Optional
       static const String perplexityApiKey = 'YOUR_PERPLEXITY_API_KEY'; // Optional
     }
     ```

   **Method 2: Android Local Properties (For Google Maps)**
   - Copy `android/local.properties.example` to `android/local.properties`
   - Add your Google Maps API key:
     ```properties
     GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY
     ```

4. **Get API Keys**

   - **Google Maps API**:
     1. Visit [Google Cloud Console](https://console.cloud.google.com/google/maps-apis)
     2. Create a new project
     3. Enable "Maps SDK for Android"
     4. Create credentials (API Key)
     5. Add your key to the configuration files

   - **Gemini AI API** (Optional - for chatbot):
     1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
     2. Create an API key
     3. Add to `lib/config/api_keys.dart`

   - **Perplexity API** (Optional - alternative chatbot):
     1. Visit [Perplexity Settings](https://www.perplexity.ai/settings/api)
     2. Generate an API key
     3. Add to `lib/config/api_keys.dart`

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry point
├── config/
│   ├── api_keys.dart           # Your API keys (not in git)
│   └── api_keys_example.dart   # API keys template
├── models/
│   └── unesco_site.dart        # UNESCO site data model
├── services/
│   ├── data_service.dart       # JSON data loader
│   ├── location_service.dart   # GPS & distance calculations
│   └── chatbot_service.dart    # AI chatbot integration
└── screens/
    ├── home_screen.dart         # Main landing screen
    ├── nearest_site_screen.dart # Nearest site with map
    ├── sites_list_screen.dart   # All sites list
    ├── site_detail_screen.dart  # Site details page
    └── chat_screen.dart         # AI chatbot interface

assets/
└── data/
    └── unesco_sites.json        # Complete dataset (42 sites)

android/
├── app/
│   └── src/main/
│       ├── AndroidManifest.xml
│       └── kotlin/
│           └── MainActivity.kt
└── local.properties             # API keys (not in git)
```

---

## 🛠️ Technologies Used

- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **Google Maps Flutter** - Map integration
- **Geolocator** - Location services
- **HTTP** - API requests
- **Shared Preferences** - Local storage
- **Material Design 3** - Modern UI

---

## 📊 Dataset

Includes all **42 UNESCO World Heritage Sites** in India:
- 34 Cultural sites
- 7 Natural sites
- 1 Mixed site

Each site includes:
- Geographic coordinates
- State location
- Detailed description
- Image URL
- Wikipedia link
- ASI ticket booking link

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- UNESCO for the World Heritage Sites data
- Archaeological Survey of India (ASI)
- Google Maps Platform
- Google AI (Gemini)
- Perplexity AI
- Flutter and Dart teams

---

## 📧 Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)

Project Link: [https://github.com/yourusername/nearest-unesco-site](https://github.com/yourusername/nearest-unesco-site)

---

## 📸 Screenshots

<div align="center">
  <p><i>Add your app screenshots here</i></p>
</div>

---

## 🐛 Known Issues

- Maps require internet connection
- AI chatbot requires API keys (optional feature)
- First build may take 5-10 minutes

---

## 🔮 Future Enhancements

- [ ] Offline mode with cached maps
- [ ] Photo gallery for each site
- [ ] User reviews and ratings
- [ ] Visit planner and itinerary
- [ ] Augmented Reality features
- [ ] Multi-language support
- [ ] iOS support

---

<div align="center">
  Made with ❤️ using Flutter
</div>
