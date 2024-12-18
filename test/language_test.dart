import 'package:flutter/foundation.dart';
import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:test/test.dart';

void main() {
  test('Reverse anguage test', () async {
    final reverseRequest = ReverseRequest(
      lat: 10.7950,
      lon: 106.7218,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final reverseResult = await NominatimFlutter.instance.reverse(
      reverseRequest: reverseRequest,
      language: 'vi-VN,vi;q=0.5',
    );
    debugPrint(reverseResult.displayName);
    // The value printed out should match the value you passed to the 'language' parameter.
  });

  test('Search language test', () async {
    final searchRequest = SearchRequest(
      query: 'New York',
      limit: 1,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final searchResult = await NominatimFlutter.instance.search(
      searchRequest: searchRequest,
      language: 'vi-VN,vi;q=0.5',
    );
    debugPrint(searchResult.single.displayName);
    // The value printed out should match the value you passed to the 'language' parameter.
  });
}
