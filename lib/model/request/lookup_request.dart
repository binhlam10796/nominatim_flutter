/// A model class representing a request to the Nominatim Lookup API.
///
/// This class is used to encapsulate the parameters required for making
/// a lookup request, which involves querying the Nominatim database for
/// specific OSM objects by their IDs.
///
/// The [LookupRequest] class includes options to specify whether to
/// include detailed address information, extra tags, name details, and
/// the geometry of the object in the response.
///
/// Example usage:
/// ```dart
/// LookupRequest request = LookupRequest(
///   osmIds: 'N123,W456,R789',
///   addressDetails: true,
///   extraTags: true,
///   nameDetails: true,
///   polygonGeojson: true,
/// );
/// ```
///
/// Properties:
/// - [osmIds]: A comma-separated list of OSM object IDs to lookup. Each ID should be prefixed with the type of the object (N for node, W for way, R for relation). This is a required parameter.
/// - [addressDetails]: Specifies whether to include detailed address information in the response. Defaults to `false`.
/// - [extraTags]: Specifies whether to include extra tags like Wikipedia link, opening hours, etc. Defaults to `true`.
/// - [nameDetails]: Specifies whether to include a list of alternative names in the results. Defaults to `true`.
/// - [polygonGeojson]: Specifies whether to include the geometry of the object in GeoJSON format. Defaults to `true`.
///
/// Constructor:
/// - [LookupRequest]: Creates a new instance of the [LookupRequest] class with the specified parameters.
class LookupRequest {
  /// A comma-separated list of OSM object IDs to lookup.
  /// Each ID should be prefixed with the type of the object (N for node, W for way, R for relation).
  final String osmIds;

  /// Specifies whether to include detailed address information in the response.
  final bool? addressDetails;

  /// Specifies whether to include extra tags like Wikipedia link, opening hours, etc.
  final bool? extraTags;

  /// Specifies whether to include a list of alternative names in the results.
  final bool? nameDetails;

  /// Specifies whether to include the geometry of the object in GeoJSON format.
  final bool? polygonGeojson;

  /// Constructor for creating a LookupRequest.
  ///
  /// [osmIds] is a required parameter.
  /// Optional parameters include [addressDetails], [extraTags], [nameDetails], and [polygonGeojson].
  LookupRequest({
    required this.osmIds,
    this.addressDetails,
    this.extraTags = true,
    this.nameDetails = true,
    this.polygonGeojson = true,
  });
}
