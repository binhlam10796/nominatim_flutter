import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:test/test.dart';

void main() {
  test('Details test with place ID', () async {
    final detailsRequest = DetailsRequest(
      placeId: 240109189,
      addressDetails: true,
      hierarchy: true,
      groupHierarchy: true,
      polygonGeojson: true,
    );
    final detailsResult = await NominatimFlutter.instance.details(
      detailsRequest: detailsRequest,
    );
    // Avoid testing against the current data as it could potentially change
    expect(detailsResult, isNotNull);
    expect(detailsResult.placeId, isNotNull);
  });

  test('Details test with OSM identifiers', () async {
    final detailsRequest = DetailsRequest(
      osmType: 'N',
      osmId: 240109189,
      addressDetails: true,
      hierarchy: false,
      groupHierarchy: false,
      polygonGeojson: false,
    );
    final detailsResult = await NominatimFlutter.instance.details(
      detailsRequest: detailsRequest,
    );
    // Avoid testing against the current data as it could potentially change
    expect(detailsResult, isNotNull);
    expect(detailsResult.placeId, isNotNull);
  });
}