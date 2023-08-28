# Nominatim Flutter Plugin

The Nominatim Flutter Plugin provides a convenient way to interact with the Nominatim service, enabling reverse geocoding and place searching in your Flutter applications.

## Usage

To use the Nominatim Flutter Plugin, follow these steps:

1. **Installation**: Add the package to your `pubspec.yaml` file and run `flutter pub get` to install it.

    ```yaml
    dependencies:
      nominatim_flutter: ^1.0.0 # Replace with the latest version
    ```

2. **Import Classes**: Import the necessary classes in your Dart code.

    ```dart
    import 'package:nominatim_flutter/nominatim_flutter.dart';
    ```

3. **Create an Instance**: Create an instance of the `NominatimFlutter` class to access the plugin's features.

    ```dart
    void main() {
      runApp(MyApp());
    }
    
    // ...
    ```

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
    );
    for (var result in searchResult) {
      print(result);
    }
    ```

6. **Contributions**: Contributions are welcome! If you encounter any issues or have suggestions for improvements, please feel free to submit a pull request or create an issue on the GitHub repository.

7. **License**: This project is licensed under the GPL-3.0 License. Refer to the [LICENSE](LICENSE) file for details.

Remember to replace the version number (`^1.0.0`) with the actual version of your Nominatim Flutter Plugin. Customize the usage examples and other sections according to your project's needs.