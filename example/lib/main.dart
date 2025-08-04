// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

void main() {
  // Configure Nominatim with enhanced settings
  NominatimFlutter.instance.configureNominatim(
    userAgent: 'NominatimFlutterExample/1.0',
    enableCurlLog: true,
    printOnSuccess: true,
    convertFormData: true,
    // baseUrl: 'https://your-custom-nominatim-server.com', // Uncomment to use custom server
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nominatim Flutter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Create a ReverseRequest with the desired latitude and longitude
                final reverseRequest =
                    ReverseRequest(lat: 37.7749, lon: -122.4194);

                // Perform reverse geocoding
                final response = await NominatimFlutter.instance.reverse(
                    reverseRequest: reverseRequest, language: 'en-US,en;q=0.5');

                // Display the address information in a dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Reverse Geocoding Result'),
                      content: Text(response.toString()),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Perform Reverse Geocoding'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Create a SearchRequest with the desired search query
                final searchRequest =
                    SearchRequest(query: 'San Francisco', limit: 5);

                // Perform a search
                final response = await NominatimFlutter.instance.search(
                    searchRequest: searchRequest, language: 'en-US,en;q=0.5');

                // Display the search results in a dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Search Result'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: response.map((result) {
                          return Text(result.toString());
                        }).toList(),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Perform Search'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Create a DetailsRequest with a place ID
                final detailsRequest = DetailsRequest(
                  placeId: 240109189,
                  addressDetails: true,
                  hierarchy: true,
                  groupHierarchy: true,
                  polygonGeojson: true,
                );

                // Perform a details request
                final response = await NominatimFlutter.instance.details(
                    detailsRequest: detailsRequest, language: 'en-US,en;q=0.5');

                // Display the details result in a dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Details Result'),
                      content: SingleChildScrollView(
                        child: Text(response.toString()),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Get Place Details'),
            ),
          ],
        ),
      ),
    );
  }
}
