import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/unesco_site.dart';
import '../services/data_service.dart';
import '../services/location_service.dart';
import 'site_detail_screen.dart';

// Screen to display all UNESCO sites in a scrollable list
class SitesListScreen extends StatefulWidget {
  const SitesListScreen({super.key});

  @override
  State<SitesListScreen> createState() => _SitesListScreenState();
}

class _SitesListScreenState extends State<SitesListScreen> {
  List<UnescoSite> _sites = [];
  List<UnescoSite> _filteredSites = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String? _selectedState;
  String _sortBy = 'name'; // 'name', 'distance', or 'state'

  @override
  void initState() {
    super.initState();
    _loadSites();
  }

  // Load sites and calculate distances
  Future<void> _loadSites() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get all sites
      List<UnescoSite> sites = List.from(DataService.sites);

      // Try to get user location and calculate distances
      Position? position = await LocationService.getCurrentLocation();
      if (position != null) {
        await LocationService.calculateDistancesForAllSites(sites, position);
      }

      setState(() {
        _sites = sites;
        _filteredSites = sites;
        _isLoading = false;
      });

      _applySorting();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Filter sites based on search query and selected state
  void _filterSites() {
    setState(() {
      _filteredSites = _sites.where((site) {
        // Filter by search query
        bool matchesSearch = site.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            site.state.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            site.description.toLowerCase().contains(_searchQuery.toLowerCase());

        // Filter by selected state
        bool matchesState = _selectedState == null || site.state == _selectedState;

        return matchesSearch && matchesState;
      }).toList();
    });

    _applySorting();
  }

  // Apply sorting to filtered sites
  void _applySorting() {
    setState(() {
      if (_sortBy == 'name') {
        _filteredSites.sort((a, b) => a.name.compareTo(b.name));
      } else if (_sortBy == 'distance') {
        _filteredSites.sort((a, b) =>
            (a.distanceFromUser ?? double.infinity).compareTo(b.distanceFromUser ?? double.infinity));
      } else if (_sortBy == 'state') {
        _filteredSites.sort((a, b) => a.state.compareTo(b.state));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All UNESCO Sites'),
        actions: [
          // Sort button
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
              _applySorting();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'name',
                child: Row(
                  children: [
                    Icon(Icons.sort_by_alpha),
                    SizedBox(width: 8),
                    Text('Sort by Name'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'distance',
                child: Row(
                  children: [
                    Icon(Icons.near_me),
                    SizedBox(width: 8),
                    Text('Sort by Distance'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'state',
                child: Row(
                  children: [
                    Icon(Icons.map),
                    SizedBox(width: 8),
                    Text('Sort by State'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filter section
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            child: Column(
              children: [
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search sites...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                    _filterSites();
                  },
                ),
                const SizedBox(height: 12),

                // State filter dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedState,
                  decoration: InputDecoration(
                    labelText: 'Filter by State',
                    prefixIcon: const Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('All States'),
                    ),
                    ...DataService.getAllStates().map((state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedState = value;
                    });
                    _filterSites();
                  },
                ),
              ],
            ),
          ),

          // Sites count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '${_filteredSites.length} sites',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 8),
                if (_searchQuery.isNotEmpty || _selectedState != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _selectedState = null;
                      });
                      _filterSites();
                    },
                    child: const Text('Clear Filters'),
                  ),
              ],
            ),
          ),

          // Sites list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredSites.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No sites found',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredSites.length,
                        itemBuilder: (context, index) {
                          return _buildSiteCard(_filteredSites[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  // Build site card widget
  Widget _buildSiteCard(UnescoSite site) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SiteDetailScreen(site: site),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                site.imageUrl,
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

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    site.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // State
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        site.state,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      // Distance
                      if (site.distanceFromUser != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                site.formattedDistance,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Description preview
                  Text(
                    site.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
