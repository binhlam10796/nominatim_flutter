import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:test/test.dart';

void main() {
  test('Search test', () async {
    final searchRequest = SearchRequest(
      query: 'Quần Đảo Hoàng Sa',
      limit: 1,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final searchResult = await NominatimFlutter.instance.search(
      searchRequest: searchRequest,
    );
    // Avoid testing against the current data as it could potentially change
    expect(searchResult.single.address, isNotNull);
    expect(searchResult.single.extraTags, isNotNull);
    expect(searchResult.single.nameDetails, isNotNull);
  });
}
