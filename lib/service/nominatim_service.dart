import '../model/isolate_helper_mixin.dart';
import '../model/request/request.dart';
import '../model/response/reverse_response.dart';
import 'nominatim_service_client.dart';

// Abstract class defining the methods for interacting with the Nominatim service
abstract class NominatimService {
  Future<List<NominatimResponse>> search(
      {required SearchRequest searchRequest});

  Future<NominatimResponse> reverse({required ReverseRequest reverseRequest});
}

// Implementation of the NominatimService interface
class NominatimServiceImpl with IsolateHelperMixin implements NominatimService {
  @override
  Future<NominatimResponse> reverse(
      {required ReverseRequest reverseRequest}) async {
    return await loadWithIsolate(() async {
      var response = await NominatimServiceClient(
        type: NominatimServiceType.reverse,
        reverseRequest: reverseRequest,
      ).request();
      return NominatimResponse.fromJson(response);
    });
  }

  @override
  Future<List<NominatimResponse>> search(
      {required SearchRequest searchRequest}) async {
    return await loadWithIsolate(() async {
      var response = await NominatimServiceClient(
        type: NominatimServiceType.search,
        searchRequest: searchRequest,
      ).request();

      // Convert response to a list of NominatimResponse objects
      return (response as List<dynamic>)
          .map<NominatimResponse>(
              (i) => NominatimResponse.fromJson(i as Map<String, dynamic>))
          .toList();
    });
  }
}
