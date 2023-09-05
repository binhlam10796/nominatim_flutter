import 'package:nominatim_flutter/config/dio_cache_configuration.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:test/test.dart';

void main() {
  group('Dio Cache Configuration', () {
    test('configureDioCache should set cache configurations', () async {
      // Setup
      const useCacheInterceptor = false;
      const maxStale = Duration(seconds: 100);

      // Act
      NominatimFlutter.instance.configureDioCache(
        useCacheInterceptor: useCacheInterceptor,
        maxStale: maxStale,
      );

      // Check
      expect(DioCacheConfiguration.useCacheInterceptor, useCacheInterceptor);
      expect(DioCacheConfiguration.maxStale, maxStale);

      // Clean up
      NominatimFlutter.instance.configureDioCache(
        useCacheInterceptor: false,
      );
    });
  });
}
