import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapPickerPage extends StatefulWidget {
  final LatLng initialPosition;
  const MapPickerPage({Key? key, required this.initialPosition}) : super(key: key);

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  LatLng? selectedLocation;
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;
  bool _showSearchResults = false;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialPosition;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchLocation(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _showSearchResults = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      // Utilisation de Nominatim (OpenStreetMap) pour la recherche
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=5&addressdetails=1',
        ),
        headers: {
          'User-Agent': 'placeDesArtisans/1.0', // 
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _searchResults = data.map((item) => SearchResult.fromJson(item)).toList();
          _showSearchResults = true;
          _isSearching = false;
        });
      }
    } catch (e) {
      print('Erreur lors de la recherche: $e');
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
    }
  }

  void _selectSearchResult(SearchResult result) {
    setState(() {
      selectedLocation = LatLng(result.lat, result.lon);
      _showSearchResults = false;
      _searchController.clear();
    });

    // Animer la carte vers la nouvelle position
    _mapController.move(LatLng(result.lat, result.lon), 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionnez un emplacement'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un lieu...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults = [];
                            _showSearchResults = false;
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                // Délai pour éviter trop de requêtes
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (_searchController.text == value && value.isNotEmpty) {
                    _searchLocation(value);
                  }
                });
              },
              onSubmitted: _searchLocation,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.initialPosition,
              initialZoom: 15.0,
              onTap: (tapPosition, latlng) {
                setState(() {
                  selectedLocation = latlng;
                  _showSearchResults = false;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
              if (selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLocation!,
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.location_pin,
                        size: 50,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          
          // Résultats de recherche
          if (_showSearchResults && _searchResults.isNotEmpty)
            Positioned(
              top: 8,
              left: 8,
              right: 8,
              child: Card(
                elevation: 4,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final result = _searchResults[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(
                          result.displayName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => _selectSearchResult(result),
                      );
                    },
                  ),
                ),
              ),
            ),

          // Indicateur de chargement
          if (_isSearching)
            const Positioned(
              top: 8,
              right: 8,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: selectedLocation == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pop(selectedLocation);
              },
              label: const Text('Confirmer la position'),
              icon: const Icon(Icons.check),
            ),
    );
  }
}

class SearchResult {
  final double lat;
  final double lon;
  final String displayName;

  SearchResult({
    required this.lat,
    required this.lon,
    required this.displayName,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
      displayName: json['display_name'],
    );
  }
}