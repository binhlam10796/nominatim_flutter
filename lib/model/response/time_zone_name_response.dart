/// A response class that represents the time zone name and status code.
///
/// This class provides a convenient way to deserialize the corresponding
/// JSON structure into a Dart object.
class TimeZoneNameResponse {
  final String? tzName;
  final int? statusCode;

  /// Default constructor for [TimeZoneNameResponse].
  ///
  /// Both [tzName] and [statusCode] are optional parameters.
  TimeZoneNameResponse({this.tzName, this.statusCode});

  /// Creates a new instance of [TimeZoneNameResponse] from a JSON map.
  factory TimeZoneNameResponse.fromJson(Map<String, dynamic> json) {
    return TimeZoneNameResponse(
      tzName: json['tz_name'] as String?,
      statusCode: json['status_code'] as int?,
    );
  }
}
