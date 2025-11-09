import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/data_service.dart';

// Main entry point of the app
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load UNESCO sites data before starting the app
  await DataService.loadUnescoSites();
  
  // Run the app
  runApp(const UnescoSiteFinderApp());
}

// Root widget of the application
class UnescoSiteFinderApp extends StatelessWidget {
  const UnescoSiteFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title
      title: 'UNESCO Sites India',
      
      // Remove debug banner in top right
      debugShowCheckedModeBanner: false,
      
      // App theme - Modern Material Design
      theme: ThemeData(
        // Color scheme - Using Indian flag colors inspiration
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
        
        // Use Material 3 design
        useMaterial3: true,
        
        // App bar theme
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        
        // Card theme for site cards
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        
        // Elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      
      // Dark theme
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      
      // Theme mode - can be changed to ThemeMode.dark for dark mode
      themeMode: ThemeMode.system,
      
      // Home screen
      home: const HomeScreen(),
    );
  }
}
