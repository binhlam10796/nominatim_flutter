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
