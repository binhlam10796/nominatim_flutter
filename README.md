<p align="center">
  <img src="https://raw.githubusercontent.com/binhlam10796/nominatim_flutter/refs/heads/main/logo.png" alt="Nominatim Flutter Plugin Logo" width="300" height="300">
</p>

# **Nominatim Flutter Plugin with Isolate Loading & Hive Caching**

The Nominatim Flutter Plugin offers seamless interaction with the Nominatim service, allowing for reverse geocoding and place searching in your Flutter applications. Notably, it supports asynchronous data loading via a dedicated isolate and provides efficient caching using Hive, enhanced with DioCache customization.

## Note on Sovereignty
The Hoàng Sa (Paracel Islands) and Trường Sa (Spratly Islands) are unequivocally part of Vietnam. The Nominatim Flutter Plugin ensures that any information contradicting this fact is overridden to reflect the historical and territorial integrity of Vietnam. This feature embodies the developer's commitment to accuracy and national pride.
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/320px-Flag_of_Vietnam.svg.png" alt="Vietnam Flag" width="100">
</p>

## Features
- **Reverse Geocoding & Place Searching**: Directly integrate with Nominatim.
- **Check Server Status**: Verify the operational status of the Nominatim server.
- **Lookup**: Retrieve detailed information about specific places using unique identifiers (OSM IDs).
- **Custom Server Support**: Connect to your own Nominatim instance instead of the default OpenStreetMap server.
- **Asynchronous Isolate Loading**: Load data in a separate thread, ensuring your UI remains smooth.
- **Hive Caching**: Speed up data retrieval with efficient caching.
- **Nominatim Configuration**: Take control of caching behavior and other settings by configuring Nominatim preferences.
- **Curl Logging**: Enhance debugging and monitoring by logging HTTP requests and responses made via cURL.

## Usage

To use the Nominatim Flutter Plugin, follow these steps:

1. **Installation**: Add the package to your `pubspec.yaml` file and run `flutter pub get` to install it.

    ```yaml
    dependencies:
      nominatim_flutter: ^0.0.7 # Replace with the latest version
    ```

2. **Import Classes**: Import the necessary classes in your Dart code.

    ```dart
    import 'package:nominatim_flutter/nominatim_flutter.dart';
    ```

3. **Configuration (Optional)**: Before you start making requests, you can optionally set up caching preferences and other settings.
    
    ```dart
    // Configure Nominatim settings (recommended approach)
    NominatimFlutter.instance.configureNominatim(
      useCacheInterceptor: true,
      maxStale: Duration(days: 7),
      baseUrl: 'https://your-nominatim-server.com', // Optional: use custom Nominatim server
      userAgent: 'YourApp/1.0',
      enableCurlLog: true, // Enable cURL logging for debugging
      printOnSuccess: true, // Log successful requests
      convertFormData: true,
    );
    
    // Or use the legacy cache configuration (deprecated)
    NominatimFlutter.instance.configureDioCache(
      useCacheInterceptor: true, 
      maxStale: Duration(days: 7),
    );
    ```
    This step allows you to determine whether the cache interceptor is used, set the maximum staleness of the cache, configure a custom Nominatim server URL, and enable debug logging.

4. **Reverse Geocoding**: Retrieve address information from latitude and longitude coordinates.

    ```dart
    final reverseRequest = ReverseRequest(
      lat: 10.7950,
      lon: 106.7218,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final reverseResult = await NominatimFlutter.instance.reverse(
      reverseRequest: reverseRequest,
      language: 'en-US,en;q=0.5', // Specify the desired language(s) here
    );
    print(reverseResult);
    ```

5. **Search for Places**: Search for places based on query and location.

    ```dart
    final searchRequest = SearchRequest(
      query: 'Landmark 81',
      limit: 3,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final searchResult = await NominatimFlutter.instance.search(
      searchRequest: searchRequest,
      language: 'en-US,en;q=0.5', // Specify the desired language(s) here
    );
    for (var result in searchResult) {
      print(result);
    }
    ```

6. **Check Server Status**: Verify the status of the Nominatim server to ensure it is operational.

    ```dart
    final statusResult = await NominatimFlutter.instance.status();
    if (statusResult.status == Status.ok) {
      print('Nominatim server is operational.');
    } else {
      print('Nominatim server is down.');
    }
    ```

7. **Lookup**: Retrieve detailed information about a specific place using its unique identifier (OSM ID).

    ```dart
    final lookupRequest = LookupRequest(
      osmIds: 'R146656,W104393803,N240109189', // Replace with actual OSM IDs
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final lookupResult = await NominatimFlutter.instance.lookup(
      lookupRequest: lookupRequest,
      language: 'en-US,en;q=0.5', // Specify the desired language(s) here
    );
    for (var result in lookupResult) {
      print(result);
    }
    ```

8. **Contributions**: Contributions are welcome! If you encounter any issues or have suggestions for improvements, please feel free to submit a pull request or create an issue on the GitHub repository.

9. **License**: This project is licensed under the GPL-3.0 License. Refer to the [LICENSE](LICENSE) file for details.

Remember to replace the version number (`^0.0.7`) with the actual version of your Nominatim Flutter Plugin. Customize the usage examples and other sections according to your project's needs.
