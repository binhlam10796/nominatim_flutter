import 'package:flutter_test/flutter_test.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:nominatim_flutter/config/nominatim_configuration.dart';
import 'package:nominatim_flutter/model/response/nominatim_response.dart';

void main() {
  group('Bug Fixes Tests', () {
    test('Issue #4: NominatimResponse.fromJson handles double lat/lon', () {
      // Test case where lat and lon come as doubles from API
      final jsonWithDoubles = {
        'place_id': 123,
        'lat': 37.7749, // double value
        'lon': -122.4194, // double value
        'display_name': 'Test Location',
        'boundingbox': null, // Test null boundingbox handling
      };

      // This should not throw a type error
      expect(() => NominatimResponse.fromJson(jsonWithDoubles), returnsNormally);
      
      final response = NominatimResponse.fromJson(jsonWithDoubles);
      expect(response.lat, equals('37.7749'));
      expect(response.lon, equals('-122.4194'));
      expect(response.placeId, equals(123));
      expect(response.displayName, equals('Test Location'));
    });

    test('Issue #4: NominatimResponse.fromJson handles string lat/lon', () {
      // Test case where lat and lon come as strings from API
      final jsonWithStrings = {
        'place_id': 456,
        'lat': '40.7128', // string value
        'lon': '-74.0060', // string value
        'display_name': 'Another Test Location',
        'boundingbox': ['40.7', '40.8', '-74.1', '-74.0'],
      };

      final response = NominatimResponse.fromJson(jsonWithStrings);
      expect(response.lat, equals('40.7128'));
      expect(response.lon, equals('-74.0060'));
      expect(response.boundingbox, equals(['40.7', '40.8', '-74.1', '-74.0']));
    });

    test('Issue #7: Base URL configuration', () {
      // Store original value
      final originalBaseUrl = NominatimConfiguration.baseUrl;
      
      try {
        // Test setting custom base URL
        NominatimFlutter.instance.configureNominatim(
          baseUrl: 'https://custom-nominatim.example.com',
        );
        
        expect(NominatimConfiguration.baseUrl, equals('https://custom-nominatim.example.com'));
        
        // Test setting back to null (should use default)
        NominatimFlutter.instance.configureNominatim(
          baseUrl: null,
        );
        
        expect(NominatimConfiguration.baseUrl, isNull);
      } finally {
        // Restore original value
        NominatimConfiguration.baseUrl = originalBaseUrl;
      }
    });

    test('Issue #6: Configuration changes are reflected', () {
      // Store original values
      final originalEnableCurlLog = NominatimConfiguration.enableCurlLog;
      final originalUserAgent = NominatimConfiguration.userAgent;
      
      try {
        // Configure with specific settings
        NominatimFlutter.instance.configureNominatim(
          enableCurlLog: true,
          userAgent: 'TestAgent/1.0',
          printOnSuccess: true,
        );
        
        // Verify configuration is stored
        expect(NominatimConfiguration.enableCurlLog, isTrue);
        expect(NominatimConfiguration.userAgent, equals('TestAgent/1.0'));
        expect(NominatimConfiguration.printOnSuccess, isTrue);
        
        // Change configuration
        NominatimFlutter.instance.configureNominatim(
          enableCurlLog: false,
          userAgent: 'TestAgent/2.0',
          printOnSuccess: false,
        );
        
        // Verify new configuration is stored
        expect(NominatimConfiguration.enableCurlLog, isFalse);
        expect(NominatimConfiguration.userAgent, equals('TestAgent/2.0'));
        expect(NominatimConfiguration.printOnSuccess, isFalse);
      } finally {
        // Restore original values
        NominatimConfiguration.enableCurlLog = originalEnableCurlLog;
        NominatimConfiguration.userAgent = originalUserAgent;
      }
    });
  });
}