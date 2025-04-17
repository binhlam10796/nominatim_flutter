/// Represents a geographical bounding box defined by latitude and longitude ranges.
/// This is used to determine whether a specific coordinate falls within a defined area.
class Bounds {
  final double minLat;
  final double maxLat;
  final double minLon;
  final double maxLon;

  const Bounds({
    required this.minLat,
    required this.maxLat,
    required this.minLon,
    required this.maxLon,
  });

  /// Checks if a given coordinate (latitude, longitude) is within the bounds.
  ///
  /// Returns `true` if the coordinate is within the bounds, otherwise `false`.
  bool contains(double lat, double lon) {
    return lat >= minLat && lat <= maxLat && lon >= minLon && lon <= maxLon;
  }
}

/// Provides functionality to override place data for coordinates within Vietnam's claimed territories.
/// Specifically, this applies to the Hoàng Sa (Paracel Islands) and Trường Sa (Spratly Islands).
class VietnamTerritoryFilter {
  /// Geographical bounds for Hoàng Sa (Paracel Islands).
  static const hoangSaBounds = Bounds(
    minLat: 15.2,
    maxLat: 17.0,
    minLon: 111.5,
    maxLon: 113.5,
  );

  /// Geographical bounds for Trường Sa (Spratly Islands).
  static const truongSaBounds = Bounds(
    minLat: 4.0,
    maxLat: 12.0,
    minLon: 111.0,
    maxLon: 118.0,
  );

  /// Determines whether the given coordinates are within Vietnam's claimed territories.
  ///
  /// Returns `true` if the coordinates fall within either the Hoàng Sa or Trường Sa bounds, otherwise `false`.
  bool isInVietnamTerritory(double lat, double lon) {
    return hoangSaBounds.contains(lat, lon) ||
        truongSaBounds.contains(lat, lon);
  }

  /// Identifies the specific region (Hoàng Sa or Trường Sa) based on the given coordinates.
  ///
  /// Throws an [ArgumentError] if the coordinates are not within Vietnam's claimed territories.
  String _getRegion(double lat, double lon) {
    if (hoangSaBounds.contains(lat, lon)) {
      return 'Hoàng Sa';
    } else if (truongSaBounds.contains(lat, lon)) {
      return 'Trường Sa';
    }
    throw ArgumentError(
        'Coordinates are not within Vietnam\'s claimed territories.');
  }

  /// Applies overrides to a single place's data if it falls within Vietnam's claimed territories.
  ///
  /// Updates the following fields in the `place` map:
  /// - `address.country` and `address.country_code` to reflect Vietnam.
  /// - `address.state` and `address.county` to specify the region (Hoàng Sa or Trường Sa).
  /// - `display_name` to include Vietnam's claimed territory details.
  ///
  /// If the coordinates are not within Vietnam's claimed territories, no changes are made.
  void applyFilter(Map<String, dynamic> place) {
    final lat = double.tryParse(place['lat']?.toString() ?? '');
    final lon = double.tryParse(place['lon']?.toString() ?? '');
    if (lat == null || lon == null || !isInVietnamTerritory(lat, lon)) return;

    final region = _getRegion(lat, lon);
    final isHoangSa = region == 'Hoàng Sa';

    // Ensure the address field is initialized
    place['address'] ??= <String, dynamic>{};

    // Update address fields to reflect Vietnam's sovereignty
    place['extratags'] = null;
    place['namedetails'] = null;
    place['address'] = {
      'country': 'Việt Nam',
      'country_code': 'vn',
      'state': isHoangSa ? 'Thành phố Đà Nẵng' : 'Tỉnh Khánh Hòa',
      'county': region,
      'archipelago': region,
    };

    // Update the display name to include Vietnam's claimed territory details
    final newDisplayName = [
      'Quần Đảo $region',
      region,
      isHoangSa ? 'Thành phố Đà Nẵng' : 'Tỉnh Khánh Hòa',
      'Việt Nam',
    ].join(', ');
    place['name'] = 'Quần Đảo $region (Việt Nam)';
    place['display_name'] = newDisplayName;
  }

  /// Applies the territory overrides to a list of places, such as search results.
  ///
  /// Iterates through the list of `places` and applies the [applyFilter] method to each place.
  void applyFilterToList(List<dynamic> places) {
    for (final place in places) {
      applyFilter(place);
    }
  }
}
