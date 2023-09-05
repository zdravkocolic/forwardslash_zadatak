import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../models/air_quality_dto.dart';

part 'air_quality_data_source.g.dart';

@RestApi()
abstract class AirQualityDataSource {
  factory AirQualityDataSource(Dio dio, {String baseUrl}) =
      _AirQualityDataSource;

  @GET(
      '/v1/air-quality?latitude={latitude}&longitude={longitude}&hourly=pm10,pm2_5,nitrogen_dioxide&timeformat=unixtime')
  Future<AirQualityDTO> getAirQuality(
    @Path() double latitude,
    @Path() double longitude,
  );

  @GET(
      '/v1/air-quality?latitude={latitude}&longitude={longitude}&hourly=pm10,pm2_5,nitrogen_dioxide&start_date={startDate}&end_date={endDate}&timeformat=unixtime')
  Future<AirQualityDTO> getAirQualityFiltered(
    @Path() double latitude,
    @Path() double longitude,
    @Path() String? startDate,
    @Path() String? endDate,
  );
}
