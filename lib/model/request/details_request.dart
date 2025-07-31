/// A model class representing a request to the Nominatim Details API.
///
/// This class is used to encapsulate the parameters required for making
/// a details request, which involves querying detailed information about
/// a specific place using either a place ID or OSM object identifiers.
///
/// The [DetailsRequest] class includes options to specify whether to
/// include detailed address information, hierarchy information, and
/// geometry in the response.
///
/// Example usage:
/// ```dart
/// DetailsRequest request = DetailsRequest(
///   placeId: 12345,
///   addressDetails: true,
///   hierarchy: true,
///   groupHierarchy: true,
///   polygonGeojson: true,
/// );
/// ```
///
/// Alternatively, using OSM identifiers:
/// ```dart
/// DetailsRequest request = DetailsRequest(
///   osmType: 'N',
///   osmId: 240109189,
///   addressDetails: true,
///   hierarchy: true,
/// );
/// ```
///
/// Properties:
/// - [placeId]: The place ID to get details for. Either this or [osmType] + [osmId] must be provided.
/// - [osmType]: The OSM type (N for node, W for way, R for relation). Used with [osmId].
/// - [osmId]: The OSM ID. Used with [osmType].
/// - [addressDetails]: Specifies whether to include detailed address information in the response. Defaults to `true`.
/// - [hierarchy]: Specifies whether to include hierarchy information in the response. Defaults to `false`.
/// - [groupHierarchy]: Specifies whether to group hierarchy information. Defaults to `false`.
/// - [polygonGeojson]: Specifies whether to include the geometry in GeoJSON format. Defaults to `false`.
///
/// Constructor:
/// - [DetailsRequest]: Creates a new instance of the [DetailsRequest] class with the specified parameters.
class DetailsRequest {
  /// The place ID to get details for.
  final int? placeId;

  /// The OSM type (N for node, W for way, R for relation).
  final String? osmType;

  /// The OSM ID.
  final int? osmId;

  /// Specifies whether to include detailed address information in the response.
  final bool? addressDetails;

  /// Specifies whether to include hierarchy information in the response.
  final bool? hierarchy;

  /// Specifies whether to group hierarchy information.
  final bool? groupHierarchy;

  /// Specifies whether to include the geometry in GeoJSON format.
  final bool? polygonGeojson;

  /// Constructor for creating a DetailsRequest.
  ///
  /// Either [placeId] or both [osmType] and [osmId] must be provided.
  /// Optional parameters include [addressDetails], [hierarchy], [groupHierarchy], and [polygonGeojson].
  DetailsRequest({
    this.placeId,
    this.osmType,
    this.osmId,
    this.addressDetails = true,
    this.hierarchy = false,
    this.groupHierarchy = false,
    this.polygonGeojson = false,
  }) : assert(
          (placeId != null) || (osmType != null && osmId != null),
          'Either placeId or both osmType and osmId must be provided',
        );
}