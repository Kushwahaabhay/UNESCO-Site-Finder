import 'package:geolocator/geolocator.dart';
import 'dart:math';
import '../models/unesco_site.dart';

// Service class to handle location-related operations
class LocationService {
  
  // Check if location services are enabled and permissions are granted
  static Future<bool> checkLocationPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    // Check if location services are enabled on the device
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('❌ Location services are disabled');
      return false;
    }
    
    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('❌ Location permissions are denied');
        return false;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      print('❌ Location permissions are permanently denied');
      return false;
    }
    
    print('✅ Location permissions granted');
    return true;
  }
  
  // Get the user's current location
  static Future<Position?> getCurrentLocation() async {
    try {
      // Check permissions first
      bool hasPermission = await checkLocationPermissions();
      if (!hasPermission) {
        return null;
      }
      
      // Get current position with high accuracy
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      print('✅ Current location: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      print('❌ Error getting location: $e');
      return null;
    }
  }
  
  // Calculate distance between two coordinates using Haversine formula
  // Returns distance in kilometers
  static double calculateDistance(
    double lat1, double lon1, // User's location
    double lat2, double lon2, // Site's location
  ) {
    // Radius of Earth in kilometers
    const double earthRadius = 6371;
    
    // Convert degrees to radians
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    
    // Haversine formula
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    
    return distance;
  }
  
  // Helper method to convert degrees to radians
  static double _toRadians(double degrees) {
    return degrees * pi / 180;
  }
  
  // Calculate distances for all sites and update their distanceFromUser field
  static Future<List<UnescoSite>> calculateDistancesForAllSites(
    List<UnescoSite> sites,
    Position userPosition,
  ) async {
    for (var site in sites) {
      double distance = calculateDistance(
        userPosition.latitude,
        userPosition.longitude,
        site.latitude,
        site.longitude,
      );
      site.distanceFromUser = distance;
    }
    
    // Sort sites by distance (nearest first)
    sites.sort((a, b) => (a.distanceFromUser ?? double.infinity)
        .compareTo(b.distanceFromUser ?? double.infinity));
    
    return sites;
  }
  
  // Find the nearest UNESCO site to user's current location
  static Future<UnescoSite?> findNearestSite(List<UnescoSite> sites) async {
    try {
      // Get user's current location
      Position? position = await getCurrentLocation();
      if (position == null) {
        print('❌ Could not get current location');
        return null;
      }
      
      // Calculate distances for all sites
      await calculateDistancesForAllSites(sites, position);
      
      // Return the first site (nearest one after sorting)
      if (sites.isNotEmpty) {
        print('✅ Nearest site: ${sites.first.name} (${sites.first.formattedDistance})');
        return sites.first;
      }
      
      return null;
    } catch (e) {
      print('❌ Error finding nearest site: $e');
      return null;
    }
  }
}
