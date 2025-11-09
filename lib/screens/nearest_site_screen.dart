import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/unesco_site.dart';
import 'site_detail_screen.dart';

// Screen to display the nearest UNESCO site
class NearestSiteScreen extends StatefulWidget {
  final UnescoSite nearestSite;
  final List<UnescoSite> allSites;

  const NearestSiteScreen({
    super.key,
    required this.nearestSite,
    required this.allSites,
  });

  @override
  State<NearestSiteScreen> createState() => _NearestSiteScreenState();
}

class _NearestSiteScreenState extends State<NearestSiteScreen> {
  GoogleMapController? _mapController;

  // Open URL in browser
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest UNESCO Site'),
        actions: [
          IconButton(
            icon: const Icon(Icons.directions),
            onPressed: () {
              // Open Google Maps for directions
              _launchURL(
                'https://www.google.com/maps/dir/?api=1&destination=${widget.nearestSite.latitude},${widget.nearestSite.longitude}',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map view
            SizedBox(
              height: 300,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.nearestSite.latitude,
                    widget.nearestSite.longitude,
                  ),
                  zoom: 12,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(widget.nearestSite.id.toString()),
                    position: LatLng(
                      widget.nearestSite.latitude,
                      widget.nearestSite.longitude,
                    ),
                    infoWindow: InfoWindow(
                      title: widget.nearestSite.name,
                      snippet: widget.nearestSite.formattedDistance,
                    ),
                  ),
                },
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
            ),

            // Site information
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Distance badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.nearestSite.formattedDistance,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Site name
                  Text(
                    widget.nearestSite.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 8),

                  // State
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.nearestSite.state,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.nearestSite.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.image_not_supported, size: 50),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.nearestSite.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 30),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchURL(widget.nearestSite.wikiUrl),
                          icon: const Icon(Icons.article),
                          label: const Text('Wikipedia'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchURL(widget.nearestSite.asiTicketUrl),
                          icon: const Icon(Icons.confirmation_number),
                          label: const Text('Tickets'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // View Details Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SiteDetailScreen(
                              site: widget.nearestSite,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.info),
                      label: const Text('View Full Details & Chat'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Other nearby sites
                  Text(
                    'Other Nearby Sites',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),

                  // List of next 3 nearest sites
                  ...widget.allSites.take(4).skip(1).map((site) => Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              site.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  child: const Icon(Icons.image),
                                );
                              },
                            ),
                          ),
                          title: Text(
                            site.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(site.formattedDistance),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SiteDetailScreen(site: site),
                              ),
                            );
                          },
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
