import 'package:zadatak/base/repositories/air_quality_repository.dart';

import '../models/air_quality_dto.dart';

class AirQualityService {
  AirQualityService(this._airQualityRepo);

  final AirQualityRepository _airQualityRepo;

  Future<AirQualityDTO> getAirQuality(
    double latitude,
    double longitude,
  ) async =>
      await _airQualityRepo.getAirQuality(latitude, longitude);

  Future<AirQualityDTO> getAirQualityFiltered(double latitude, double longitude,
          String? startDate, String? endDate) async =>
      await _airQualityRepo.getAirQualityFiltered(
          latitude, longitude, startDate, endDate);
}
