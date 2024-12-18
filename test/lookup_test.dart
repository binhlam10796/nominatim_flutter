import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:test/test.dart';

void main() {
  test('Lookup test', () async {
    final lookupRequest = LookupRequest(
      osmIds: 'R146656,W104393803,N240109189',
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final lookupResult = await NominatimFlutter.instance.lookup(
      lookupRequest: lookupRequest,
    );
    // Avoid testing against the current data as it could potentially change
    expect(lookupResult, isNotEmpty);
    expect(lookupResult.first.address, isNotNull);
    expect(lookupResult.first.extraTags, isNotNull);
    expect(lookupResult.first.nameDetails, isNotNull);
  });
}
