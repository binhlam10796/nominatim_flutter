# Bug Fixes in nominatim_flutter

This document describes the recent bug fixes and enhancements made to the nominatim_flutter package.

## Issues Fixed

### Issue #4: Type Conversion Error

**Problem**: The app was crashing with `_TypeError (type 'double' is not a subtype of type 'String?')` when parsing API responses.

**Root Cause**: The Nominatim API sometimes returns latitude and longitude as `double` values, but the `NominatimResponse.fromJson()` method expected them to be `String` values.

**Solution**: Modified the JSON parsing to handle both string and double types:
```dart
// Before
lat = json['lat'];
lon = json['lon'];

// After  
lat = json['lat']?.toString();
lon = json['lon']?.toString();
```

Also fixed null handling for the `boundingbox` field:
```dart
// Before
boundingbox = json['boundingbox'].cast<String>();

// After
boundingbox = json['boundingbox']?.cast<String>();
```

### Issue #6: Configuration Not Being Applied

**Problem**: Users reported that configuration changes made via `configureNominatim()` were not taking effect, particularly for debug logging settings.

**Root Cause**: The Dio HTTP client instance was created once and cached, so configuration changes made after the first API call were ignored.

**Solution**: 
1. Modified `DioFactory` to detect configuration changes and recreate the Dio instance when needed
2. Updated `APIProvider` to get a fresh Dio instance on each request
3. Added configuration change detection using a snapshot comparison system

**Code Changes**:
- `DioFactory` now tracks configuration state and recreates instances when changes are detected
- `APIProvider` no longer caches the Dio instance but gets it fresh each time

### Issue #7: Custom Server Support

**Problem**: The base URL was hardcoded to `https://nominatim.openstreetmap.org`, preventing users from using their own Nominatim instances.

**Solution**: Added configurable base URL support:

1. Added `baseUrl` parameter to `NominatimConfiguration`:
```dart
static String? baseUrl = 'https://nominatim.openstreetmap.org';
```

2. Updated `configureNominatim()` method to accept custom base URL:
```dart
NominatimFlutter.instance.configureNominatim(
  baseUrl: 'https://your-custom-nominatim-server.com',
  // ... other options
);
```

3. Modified service client to use configurable URL:
```dart
String get endpoints => NominatimConfiguration.baseUrl ?? "https://nominatim.openstreetmap.org";
```

## Usage Examples

### Using Custom Nominatim Server
```dart
void main() {
  // Configure to use your own Nominatim server
  NominatimFlutter.instance.configureNominatim(
    baseUrl: 'https://your-nominatim-server.com',
    userAgent: 'YourApp/1.0',
    enableCurlLog: true, // This will now work correctly
  );
  
  runApp(MyApp());
}
```

### Debug Logging (Now Works Correctly)
```dart
// Enable debug logging - changes take effect immediately
NominatimFlutter.instance.configureNominatim(
  enableCurlLog: true,
  printOnSuccess: true,
);

// Make API call - will show debug logs
final response = await NominatimFlutter.instance.reverse(
  reverseRequest: ReverseRequest(lat: 37.7749, lon: -122.4194),
);
```

### Handling Mixed Data Types (No More Type Errors)
```dart
// This will work whether the API returns lat/lon as strings or doubles
final response = await NominatimFlutter.instance.search(
  searchRequest: SearchRequest(query: 'San Francisco'),
);

// lat and lon are always strings now, regardless of API response format
print('Latitude: ${response.first.lat}');
print('Longitude: ${response.first.lon}');
```

## Testing

A comprehensive test suite has been added in `test/fixes_test.dart` that validates:

1. **Type conversion handling**: Tests that `fromJson` correctly handles both string and double lat/lon values
2. **Configuration persistence**: Verifies that configuration changes are properly stored and applied
3. **Custom base URL**: Tests that custom server URLs can be set and retrieved correctly

## Backward Compatibility

All changes are fully backward compatible. Existing code will continue to work without modifications, while new features are opt-in through the enhanced `configureNominatim()` method.

## Migration from Deprecated Methods

The old `configureDioCache()` method is deprecated but still functional. It's recommended to migrate to the new `configureNominatim()` method:

```dart
// Old (deprecated)
NominatimFlutter.instance.configureDioCache(
  useCacheInterceptor: true,
  maxStale: Duration(days: 7),
);

// New (recommended)
NominatimFlutter.instance.configureNominatim(
  useCacheInterceptor: true,
  maxStale: Duration(days: 7),
  baseUrl: 'https://your-server.com', // New feature
  enableCurlLog: true, // Now works correctly
  userAgent: 'YourApp/1.0',
);
```