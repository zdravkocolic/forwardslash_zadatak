import 'package:flutter/material.dart';
import 'package:zadatak/base/service/air_quality_service.dart';

import '../models/air_quality_dto.dart';

class Coordinates with ChangeNotifier {
  Coordinates(this._airQualityService);

  final AirQualityService _airQualityService;
  AirQualityDTO? _airQualityDTO;

  AirQualityDTO get airQuality => _airQualityDTO!;

  double _latitude = 0;
  double _longitude = 0;
  String _name = '';

  double get lat => _latitude;
  double get long => _longitude;
  String get name => _name;

  void setCoordinates(double lat, double long) {
    _latitude = lat;
    _longitude = long;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  Future<void> getAirQuality(
    double lat,
    double long,
  ) async {
    _airQualityDTO = await _airQualityService.getAirQuality(lat, long);
    notifyListeners();
  }
}
