/// Represents the response status from the server.
class StatusResponse {
  /// The status of the response.
  /// Represents the status response from the Nominatim API.
  ///
  /// This response provides information about the current status of the Nominatim service,
  /// including details such as the number of available database connections, the current load,
  /// and the uptime of the service.
  ///
  /// For more information, visit: https://nominatim.org/release-docs/develop/api/Status/
  final Status status;

  /// The message associated with the response.
  final String message;

  /// The date and time when the data was last updated.
  final DateTime? dataUpdated;

  /// The version of the software.
  final String? softwareVersion;

  /// The version of the database.
  final String? databaseVersion;

  StatusResponse({
    required this.status,
    required this.message,
    this.dataUpdated,
    this.softwareVersion,
    this.databaseVersion,
  });

  /// Creates a `StatusResponse` from a JSON object.
  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    return StatusResponse(
      status: Status.values.firstWhere((e) => e.code == json['status']),
      message: json['message'],
      dataUpdated: json.containsKey('data_updated')
          ? DateTime.parse(json['data_updated'])
          : null,
      softwareVersion: json['software_version'],
      databaseVersion: json['database_version'],
    );
  }

  /// Converts the `StatusResponse` to a string representation.
  @override
  String toString() {
    return 'StatusResponse: {\n'
        '  status: ${status.code},\n'
        '  message: $message,\n'
        '  dataUpdated: ${dataUpdated?.toIso8601String()},\n'
        '  softwareVersion: $softwareVersion,\n'
        '  databaseVersion: $databaseVersion\n'
        '}';
  }
}

/// Enum representing the possible status codes.
enum Status {
  ok(0),
  databaseConnectionFailed(700);

  final int code;

  const Status(this.code);
}
