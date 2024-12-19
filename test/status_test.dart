import 'package:flutter_test/flutter_test.dart';
import 'package:nominatim_flutter/model/response/status_response.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

void main() {
  test('Status test', () async {
    final statusResult = await NominatimFlutter.instance.status();
    // Check if the statusResult is not null
    expect(statusResult, isNotNull);
    // Check if the status is OK
    expect(statusResult.status, equals(Status.ok));
  });
}
