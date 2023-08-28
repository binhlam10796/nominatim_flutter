import 'dart:async';
import 'package:dio/dio.dart';
import 'dio_factory.dart';

part 'api_request_representable.dart'; // Assuming this file is in the same directory.

/// A class responsible for making API requests using Dio.
class APIProvider {
  APIProvider._();

  final _dio = DioFactory.instance.createDioInstance();

  // Singleton instance of [APIProvider].
  static final _instance = APIProvider._();

  /// Get the singleton instance of [APIProvider].
  static APIProvider get instance => _instance;

  /// Perform an API request based on the provided [APIRequestRepresentable].
  Future<dynamic> request(APIRequestRepresentable request) async {
    final response = await _dio.request(
      request.urls,
      data: request.bodies,
      queryParameters: request.queries,
      options: Options(
        method: request.methods.string,
        headers: request.headers,
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );
    return response.data;
  }
}
