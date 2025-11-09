# 📖 BEGINNER'S CODE EXPLANATION

This guide explains each part of the code in simple terms for beginners.

---

## 🎯 Understanding Flutter Basics

### What is Flutter?
- Flutter is a framework to build mobile apps
- You write code once, it works on Android & iOS
- Uses Dart programming language

### Key Concepts:

**Widget**: Everything in Flutter is a widget (buttons, text, images, screens)

**State**: Data that can change (like a counter, or list of items)

**async/await**: Used when waiting for something (like loading data, getting location)

---

## 📁 File-by-File Explanation

### 1. `lib/main.dart` - The Starting Point

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Setup Flutter
  await DataService.loadUnescoSites();        // Load JSON data
  runApp(const UnescoSiteFinderApp());        // Start the app
}
```

**What happens:**
1. App starts here
2. Loads all 42 UNESCO sites from JSON file
3. Launches the main app widget

**Theme Setup:**
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.deepOrange,  // Main color
  brightness: Brightness.light,   // Light theme
),
```
- `seedColor`: Main color of your app (change this to customize!)
- Material 3 automatically generates complementary colors

---

### 2. `lib/models/unesco_site.dart` - Data Structure

This defines what a UNESCO site "looks like" in code:

```dart
class UnescoSite {
  final String name;           // "Taj Mahal"
  final String state;          // "Uttar Pradesh"
  final double latitude;       // 27.1751
  final double longitude;      // 78.0421
  final String description;    // Long text about the site
  // ... more fields
}
```

**Key Methods:**

**`fromJson()`**: Converts JSON data to UnescoSite object
```dart
factory UnescoSite.fromJson(Map<String, dynamic> json) {
  return UnescoSite(
    name: json['name'],  // Gets name from JSON
    // ... gets other fields
  );
}
```

**`toJson()`**: Converts UnescoSite object back to JSON
```dart
Map<String, dynamic> toJson() {
  return {
    'name': name,
    'state': state,
    // ... returns all fields
  };
}
```

---

### 3. `lib/services/data_service.dart` - Loading Data

**Purpose**: Reads the JSON file and converts it to UnescoSite objects

```dart
static Future<List<UnescoSite>> loadUnescoSites() async {
  // 1. Read JSON file from assets
  final String jsonString = await rootBundle.loadString('assets/data/unesco_sites.json');
  
  // 2. Parse JSON string to List
  final List<dynamic> jsonData = json.decode(jsonString);
  
  // 3. Convert each JSON object to UnescoSite
  _sites = jsonData.map((json) => UnescoSite.fromJson(json)).toList();
  
  return _sites;
}
```

**How it works:**
1. Reads text from JSON file
2. Converts text to Dart objects
3. Creates a list of 42 UnescoSite objects
4. Stores in `_sites` variable for app-wide access

---

### 4. `lib/services/location_service.dart` - GPS & Distances

#### Getting User Location:

```dart
static Future<Position?> getCurrentLocation() async {
  // 1. Check permissions
  bool hasPermission = await checkLocationPermissions();
  
  // 2. Get GPS coordinates
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  
  return position;  // Returns your location
}
```

#### Calculating Distance:

Uses **Haversine Formula** (math for distance on Earth's curved surface):

```dart
static double calculateDistance(
  double lat1, double lon1,  // Your location
  double lat2, double lon2,  // Site location
) {
  const double earthRadius = 6371;  // Earth's radius in km
  
  // Haversine formula calculations...
  // Returns distance in kilometers
}
```

**Example:**
- Your location: New Delhi (28.6139° N, 77.2090° E)
- Taj Mahal: Agra (27.1751° N, 78.0421° E)
- Distance calculated: ~206 km

---

### 5. `lib/screens/home_screen.dart` - Main Screen

#### Key Components:

**State Management:**
```dart
class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;  // Tracks if we're finding nearest site
  
  // When loading starts:
  setState(() {
    _isLoading = true;  // This rebuilds the UI
  });
}
```

**Finding Nearest Site:**
```dart
Future<void> _findNearestSite() async {
  // 1. Get all sites
  List<UnescoSite> sites = List.from(DataService.sites);
  
  // 2. Find nearest (this calculates distances)
  UnescoSite? nearestSite = await LocationService.findNearestSite(sites);
  
  // 3. Navigate to result screen
  Navigator.push(context, MaterialPageRoute(...));
}
```

**UI Elements:**
```dart
ElevatedButton.icon(
  onPressed: _isLoading ? null : _findNearestSite,  // Disable if loading
  icon: Icon(...),                                    // Button icon
  label: Text('Find Nearest Site'),                  // Button text
)
```

---

### 6. `lib/screens/sites_list_screen.dart` - All Sites List

#### Search & Filter:

```dart
void _filterSites() {
  setState(() {
    _filteredSites = _sites.where((site) {
      // Check if site name contains search query
      bool matchesSearch = site.name.toLowerCase()
          .contains(_searchQuery.toLowerCase());
      
      // Check if site is in selected state
      bool matchesState = _selectedState == null 
          || site.state == _selectedState;
      
      return matchesSearch && matchesState;
    }).toList();
  });
}
```

**How it works:**
1. User types "Taj" in search box
2. `_filterSites()` is called
3. Checks each site: does name contain "Taj"?
4. Creates new list with only matching sites
5. UI rebuilds to show filtered list

#### Sorting:

```dart
if (_sortBy == 'name') {
  _filteredSites.sort((a, b) => a.name.compareTo(b.name));
} else if (_sortBy == 'distance') {
  _filteredSites.sort((a, b) => 
    a.distanceFromUser.compareTo(b.distanceFromUser));
}
```

---

### 7. `lib/screens/site_detail_screen.dart` - Detailed View

#### SliverAppBar (Collapsing Header):

```dart
SliverAppBar(
  expandedHeight: 300,          // Height when expanded
  pinned: true,                 // Stays at top when scrolling
  flexibleSpace: FlexibleSpaceBar(
    title: Text(widget.site.name),
    background: Image.network(...),  // Site image
  ),
)
```

**Effect**: Image shrinks as you scroll down, title stays visible

#### Google Maps Integration:

```dart
GoogleMap(
  initialCameraPosition: CameraPosition(
    target: LatLng(site.latitude, site.longitude),
    zoom: 14,
  ),
  markers: {
    Marker(
      position: LatLng(site.latitude, site.longitude),
      infoWindow: InfoWindow(title: site.name),
    ),
  },
)
```

**What happens:**
1. Shows map centered on site location
2. Places a marker (pin) at site
3. Tapping marker shows site name

#### Favorites System:

```dart
Future<void> _toggleFavorite() async {
  final prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];
  
  if (_isFavorite) {
    favorites.remove(widget.site.id.toString());  // Remove
  } else {
    favorites.add(widget.site.id.toString());     // Add
  }
  
  await prefs.setStringList('favorites', favorites);  // Save
}
```

**How it works:**
1. Loads favorites list from phone storage
2. Adds or removes current site's ID
3. Saves updated list back to storage
4. List persists even when app is closed

---

### 8. `lib/services/chatbot_service.dart` - AI Integration

#### Sending Message to Gemini:

```dart
static Future<String> _sendToGemini(String message, String siteName) async {
  // 1. Create context for AI
  String contextualMessage = 
    'You are a guide for $siteName. User asks: $message';
  
  // 2. Send HTTP request to Gemini API
  final response = await http.post(
    Uri.parse('$geminiEndpoint?key=$geminiApiKey'),
    body: jsonEncode({
      'contents': [{
        'parts': [{'text': contextualMessage}]
      }]
    }),
  );
  
  // 3. Extract AI's response from JSON
  final data = jsonDecode(response.body);
  return data['candidates'][0]['content']['parts'][0]['text'];
}
```

**Example Flow:**
1. User types: "When was Taj Mahal built?"
2. App sends to Gemini API with context
3. Gemini responds: "The Taj Mahal was built between 1631-1653..."
4. App displays response in chat

---

### 9. `lib/screens/chat_screen.dart` - Chat Interface

#### Message Structure:

```dart
class ChatMessage {
  final String text;        // Message content
  final bool isUser;        // true = user, false = AI
  final DateTime timestamp; // When message was sent
}
```

#### Sending & Receiving:

```dart
Future<void> _sendMessage(String text) async {
  // 1. Add user's message to list
  _messages.add(ChatMessage(
    text: text,
    isUser: true,
    timestamp: DateTime.now(),
  ));
  
  // 2. Show loading indicator
  setState(() { _isLoading = true; });
  
  // 3. Get AI response
  String response = await ChatbotService.sendMessage(text, siteName);
  
  // 4. Add AI's response to list
  _messages.add(ChatMessage(
    text: response,
    isUser: false,
    timestamp: DateTime.now(),
  ));
  
  // 5. Hide loading, scroll to bottom
  setState(() { _isLoading = false; });
  _scrollToBottom();
}
```

---

## 🔄 App Flow Diagram

```
App Start
   ↓
main.dart loads JSON data
   ↓
HomeScreen displays
   ↓
User taps "Find Nearest Site"
   ↓
LocationService gets GPS coordinates
   ↓
LocationService calculates distances to all 42 sites
   ↓
Finds site with minimum distance
   ↓
NearestSiteScreen shows result
   ↓
User taps site for details
   ↓
SiteDetailScreen shows full info
   ↓
User taps "AI Chat"
   ↓
ChatScreen opens
   ↓
User sends message
   ↓
ChatbotService sends to Gemini API
   ↓
AI response displayed
```

---

## 🎨 Key Flutter Widgets Used

### Layout Widgets:
- **Scaffold**: Basic page structure (app bar + body)
- **Column**: Stack widgets vertically
- **Row**: Place widgets horizontally
- **ListView**: Scrollable list
- **Card**: Material Design card with shadow
- **Container**: Box to hold other widgets

### Interactive Widgets:
- **ElevatedButton**: Raised button with shadow
- **TextField**: Text input field
- **IconButton**: Button with just an icon
- **GestureDetector**: Detects taps, swipes, etc.

### Display Widgets:
- **Text**: Display text
- **Image.network**: Load image from URL
- **Icon**: Display an icon
- **CircularProgressIndicator**: Loading spinner

---

## 💡 Common Patterns Explained

### 1. setState() - Updating UI
```dart
setState(() {
  _isLoading = true;  // Change variable
});
// UI automatically rebuilds to show loading spinner
```

### 2. async/await - Waiting for Data
```dart
Future<void> loadData() async {
  var data = await fetchFromServer();  // Wait here
  print(data);  // This runs after data arrives
}
```

### 3. Navigator - Changing Screens
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);
```

### 4. Theme Access
```dart
Theme.of(context).colorScheme.primary  // Gets app's main color
Theme.of(context).textTheme.headline1  // Gets text style
```

---

## 🐛 Common Issues & Solutions

### "setState called during build"
**Problem**: Trying to change state while building UI
**Solution**: Use `Future.delayed` or `addPostFrameCallback`

### "Unhandled Exception: setState called after dispose"
**Problem**: Trying to update a screen that's already closed
**Solution**: Check `if (mounted)` before calling `setState()`

### "RenderBox was not laid out"
**Problem**: Widget doesn't know its size
**Solution**: Wrap in `Expanded`, `Flexible`, or give explicit size

---

## 📚 Learning Resources

- **Official Flutter Docs**: https://docs.flutter.dev/
- **Dart Language Tour**: https://dart.dev/guides/language/language-tour
- **Flutter Cookbook**: https://docs.flutter.dev/cookbook
- **Widget Catalog**: https://docs.flutter.dev/development/ui/widgets

---

## 🎯 Next Learning Steps

1. **Modify existing code**: Change colors, text, button sizes
2. **Add simple features**: Share button, more filters
3. **Study each widget**: Look up widgets used in Flutter docs
4. **Build something new**: Use what you learned in a new app
5. **Join communities**: Flutter Discord, Stack Overflow

---

**Remember**: Every expert was once a beginner! Take it step by step, experiment, and don't be afraid to break things - that's how you learn! 🚀
