import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

/// A custom Dio interceptor that logs HTTP requests in cURL format.
/// This is useful for debugging and replicating API requests in a terminal.
class CurlInterceptor extends Interceptor {
  /// Whether to log cURL commands for successful responses.
  final bool? printOnSuccess;

  /// Whether to convert FormData into a JSON-like structure for logging.
  final bool convertFormData;

  /// Constructor for the CurlInterceptor.
  ///
  /// [printOnSuccess] determines if successful responses should log cURL commands.
  /// [convertFormData] determines if FormData should be converted to JSON-like structures.
  CurlInterceptor({this.printOnSuccess, this.convertFormData = true});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log the cURL representation of the request when an error occurs.
    _logCurlRepresentation(err.requestOptions, isError: true);

    // Pass the error to the next handler in the chain.
    handler.next(err);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // Log the cURL representation of the request if printOnSuccess is true.
    if (printOnSuccess == true) {
      _logCurlRepresentation(response.requestOptions, isError: false);
    }

    // Pass the response to the next handler in the chain.
    handler.next(response);
  }

  /// Logs the cURL representation of the given [requestOptions].
  ///
  /// [isError] indicates whether the log is for an error or a successful request.
  void _logCurlRepresentation(RequestOptions requestOptions,
      {required bool isError}) {
    try {
      final logPrefix = isError ? '❌ ERROR CURL:' : '✅ SUCCESS CURL:';
      log('$logPrefix\n${_cURLRepresentation(requestOptions)}');
    } catch (err) {
      log('⚠️ Unable to create a cURL representation of the requestOptions: $err');
    }
  }

  /// Generates a cURL command representation of the given [options].
  ///
  /// This method converts the request options into a cURL command string
  /// that can be executed in a terminal for debugging purposes.
  String _cURLRepresentation(RequestOptions options) {
    final List<String> components = ['curl -i'];

    // Add the HTTP method.
    components.add('-X ${options.method}');

    // Add headers, excluding cookies for security reasons.
    options.headers.forEach((key, value) {
      if (key != 'Cookie') {
        components.add('-H "$key: $value"');
      }
    });

    // Add the request body if it exists.
    if (options.data != null) {
      if (options.data is FormData && convertFormData) {
        // Convert FormData to a JSON-like structure for better readability.
        options.data = Map.fromEntries(options.data.fields);
      }

      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    // Add the request URL.
    components.add('"${options.uri.toString()}"');

    // Join all components into a single cURL command.
    return components.join(' \\\n\t');
  }
}
