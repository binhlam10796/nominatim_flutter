import 'package:nominatim_flutter/model/request/reverse_request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:test/test.dart';

void main() {
  test('Reverse test', () async {
    final reverseRequest = ReverseRequest(
      lat: 10.7950,
      lon: 106.7218,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final reverseResult = await NominatimFlutter.instance.reverse(
      reverseRequest: reverseRequest,
    );
    // Avoid testing against the current data as it could potentially change
    expect(reverseResult.address, isNotNull);
    expect(reverseResult.extraTags, isNotNull);
    expect(reverseResult.nameDetails, isNotNull);
  });
}
