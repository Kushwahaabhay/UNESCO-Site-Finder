import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/unesco_site.dart';

// Service class to load UNESCO sites data from JSON file
class DataService {
  // List to store all UNESCO sites
  static List<UnescoSite> _sites = [];
  
  // Getter to access sites from anywhere in the app
  static List<UnescoSite> get sites => _sites;
  
  // Load UNESCO sites data from JSON file
  // Call this method when app starts
  static Future<List<UnescoSite>> loadUnescoSites() async {
    try {
      // Read JSON file from assets folder
      final String jsonString = await rootBundle.loadString('assets/data/unesco_sites.json');
      
      // Parse JSON string to List
      final List<dynamic> jsonData = json.decode(jsonString);
      
      // Convert each JSON object to UnescoSite object
      _sites = jsonData.map((json) => UnescoSite.fromJson(json)).toList();
      
      print('✅ Successfully loaded ${_sites.length} UNESCO sites');
      return _sites;
    } catch (e) {
      print('❌ Error loading UNESCO sites: $e');
      return [];
    }
  }
  
  // Get a specific site by ID
  static UnescoSite? getSiteById(int id) {
    try {
      return _sites.firstWhere((site) => site.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Get sites by state
  static List<UnescoSite> getSitesByState(String state) {
    return _sites.where((site) => site.state == state).toList();
  }
  
  // Get all unique states
  static List<String> getAllStates() {
    final states = _sites.map((site) => site.state).toSet().toList();
    states.sort();
    return states;
  }
}
