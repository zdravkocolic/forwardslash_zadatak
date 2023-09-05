import 'package:zadatak/base/data_source/air_quality_data_source.dart';

import '../models/air_quality_dto.dart';

class AirQualityRepository {
  AirQualityRepository(this._dataSource);

  final AirQualityDataSource _dataSource;

  Future<AirQualityDTO> getAirQuality(
    double latitude,
    double longitude,
  ) =>
      _dataSource.getAirQuality(latitude, longitude);

  Future<AirQualityDTO> getAirQualityFiltered(double latitude, double longitude,
          String? startDate, String? endDate) =>
      _dataSource.getAirQualityFiltered(
          latitude, longitude, startDate, endDate);
}
