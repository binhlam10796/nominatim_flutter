import '../../model/request/time_zone_name_request.dart';
import '../../network/api_provider.dart';

enum TimeZoneServiceType { timeZoneName, timeZoneDetail }

class TimeZoneServiceClient implements APIRequestRepresentable {
  final TimeZoneServiceType type;
  final TimeZoneNameRequest? timeZoneNameRequest;
  final String? timeZoneName;

  TimeZoneServiceClient({
    required this.type,
    this.timeZoneNameRequest,
    this.timeZoneName,
  });

  @override
  get bodies => null;

  @override
  String get endpoints {
    switch (type) {
      
      case TimeZoneServiceType.timeZoneName:
        return "http://timezonefinder.michelfe.it/api";
      case TimeZoneServiceType.timeZoneDetail:
        return "http://worldtimeapi.org/api/timezone";
    }
  }

  @override
  Map<String, String>? get headers => {"accept": "*/*"};

  @override
  HTTPMethod get methods => HTTPMethod.get;

  @override
  String get paths {
    switch (type) {
      case TimeZoneServiceType.timeZoneName:
        return "/0_${timeZoneNameRequest?.lon}_${timeZoneNameRequest?.lat}";
      case TimeZoneServiceType.timeZoneDetail:
        return "/$timeZoneName";
    }
  }

  @override
  Map<String, String>? get queries => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get urls => endpoints + paths;
}
