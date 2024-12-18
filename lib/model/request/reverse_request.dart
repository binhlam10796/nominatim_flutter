/// A model class representing a reverse geocoding request.
///
/// This class is used to encapsulate the parameters required for making
/// a reverse geocoding request, which involves converting geographic
/// coordinates (latitude and longitude) into a human-readable address.
///
/// The [ReverseRequest] class includes options to specify whether to
/// include detailed address information, extra tags, and alternative
/// names in the response.
///
/// Example usage:
/// ```dart
/// ReverseRequest request = ReverseRequest(
///   lat: 40.748817,
///   lon: -73.985428,
///   addressDetails: true,
///   extraTags: true,
///   nameDetails: true,
/// );
/// ```
///
/// Properties:
/// - [lat]: The latitude of the location to be reverse geocoded. This is a required parameter.
/// - [lon]: The longitude of the location to be reverse geocoded. This is a required parameter.
/// - [addressDetails]: Specifies whether to include detailed address information in the response. Defaults to `false`.
/// - [extraTags]: Specifies whether to include extra tags like Wikipedia link, opening hours, etc. Defaults to `false`.
/// - [nameDetails]: Specifies whether to include a list of alternative names in the results. Defaults to `false`.
///
/// Constructor:
/// - [ReverseRequest]: Creates a new instance of the [ReverseRequest] class with the specified parameters.
class ReverseRequest {
  /// The latitude of the location to be reverse geocoded.
  final double lat;

  /// The longitude of the location to be reverse geocoded.
  final double lon;

  /// Specifies whether to include detailed address information in the response.
  bool? addressDetails;

  /// Specifies whether to include extra tags like Wikipedia link, opening hours, etc.
  bool? extraTags;

  /// Specifies whether to include a list of alternative names in the results.
  bool? nameDetails;

  ReverseRequest({
    required this.lat,
    required this.lon,
    this.addressDetails = true,
    this.extraTags = true,
    this.nameDetails = true,
  });
}
