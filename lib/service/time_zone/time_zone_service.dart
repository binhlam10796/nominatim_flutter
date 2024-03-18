// Abstract class defining the methods for interacting with the Nominatim service
import 'package:nominatim_flutter/model/request/time_zone_name_request.dart';
import 'package:nominatim_flutter/model/response/time_zone_name_response.dart';

import '../../model/isolate_helper_mixin.dart';
import '../../model/response/time_zone_detail_response.dart';
import 'time_zone_service_client.dart';

abstract class TimeZoneService {
  Future<TimeZoneNameResponse> timeZoneName(
      {required TimeZoneNameRequest timeZoneNameRequest});

  Future<TimeZoneDetailResponse> timeZoneDetail({required String timeZoneName});
}

class TimeZoneServiceImpl with IsolateHelperMixin implements TimeZoneService {
  @override
  Future<TimeZoneNameResponse> timeZoneName(
      {required TimeZoneNameRequest timeZoneNameRequest}) async {
    return await loadWithIsolate(() async {
      var response = await TimeZoneServiceClient(
        type: TimeZoneServiceType.timeZoneName,
        timeZoneNameRequest: timeZoneNameRequest,
      ).request();
      return TimeZoneNameResponse.fromJson(response);
    });
  }

  @override
  Future<TimeZoneDetailResponse> timeZoneDetail(
      {required String timeZoneName}) async {
    return await loadWithIsolate(() async {
      var response = await TimeZoneServiceClient(
        type: TimeZoneServiceType.timeZoneDetail,
        timeZoneName: timeZoneName,
      ).request();
      return TimeZoneDetailResponse.fromJson(response);
    });
  }
}
