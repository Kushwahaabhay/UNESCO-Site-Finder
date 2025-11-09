// Model class for UNESCO World Heritage Sites
// This represents each site with all its data
class UnescoSite {
  final int id;
  final String name;
  final String state;
  final double latitude;
  final double longitude;
  final String description;
  final String imageUrl;
  final String wikiUrl;
  final String asiTicketUrl;
  
  // This will be calculated based on user's location
  double? distanceFromUser; // in kilometers
  
  // Constructor - creates a new UnescoSite object
  UnescoSite({
    required this.id,
    required this.name,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.imageUrl,
    required this.wikiUrl,
    required this.asiTicketUrl,
    this.distanceFromUser,
  });
  
  // Factory method to create UnescoSite from JSON data
  // This reads data from our JSON file and converts it to a UnescoSite object
  factory UnescoSite.fromJson(Map<String, dynamic> json) {
    return UnescoSite(
      id: json['id'] as int,
      name: json['name'] as String,
      state: json['state'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      wikiUrl: json['wiki_url'] as String,
      asiTicketUrl: json['asi_ticket_url'] as String,
    );
  }
  
  // Convert UnescoSite object back to JSON
  // Useful for saving data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'image_url': imageUrl,
      'wiki_url': wikiUrl,
      'asi_ticket_url': asiTicketUrl,
    };
  }
  
  // Helper method to get formatted distance string
  String get formattedDistance {
    if (distanceFromUser == null) return 'Distance unknown';
    if (distanceFromUser! < 1) {
      return '${(distanceFromUser! * 1000).toStringAsFixed(0)} meters away';
    }
    return '${distanceFromUser!.toStringAsFixed(2)} km away';
  }
}
