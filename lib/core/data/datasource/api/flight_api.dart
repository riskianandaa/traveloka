import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:traveloka/core/data/model/all_flight.dart';

import '../../model/api_response.dart';
part '../../../../gen/core/data/datasource/api/flight_api.g.dart';

@RestApi()
@Injectable()
abstract class FLightApi {
  @factoryMethod // diperlukan anotasi factoryMethod jika objek dibuat menggunakan factory
  factory FLightApi(Dio dio) = _FLightApi;

  // sisanya sama persis seperti retrofit di android
  @GET('')
  Future<ApiResponse<List<AllFlight>>> getFlights();
}