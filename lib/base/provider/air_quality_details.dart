import 'package:flutter/material.dart';
import 'package:zadatak/base/service/air_quality_service.dart';

import '../models/air_quality_dto.dart';

class AirQualityDetails with ChangeNotifier {
  AirQualityDetails(this._service);
  final AirQualityService _service;
  AirQualityDTO? _airQualityDTO;
  String? _startDate;
  String? _endDate;

  String? get startDate => _startDate;
  String? get endDate => _endDate;
  AirQualityDTO? get airQuality => _airQualityDTO;

  void getAirQualityDetails(double lat, double lng) async {
    _airQualityDTO = await _service.getAirQuality(lat, lng);
    notifyListeners();
  }

  void setStartDate(String? startDate) {
    _startDate = startDate;
    notifyListeners();
  }

  void setEndDate(String? endDate) {
    _endDate = endDate;
    notifyListeners();
  }

  void reset() {
    _startDate = null;
    _endDate = null;
    _airQualityDTO = null;
    notifyListeners();
  }

  void getAirQualityFiltered(double lat, double lng) async {
    _airQualityDTO =
        await _service.getAirQualityFiltered(lat, lng, startDate, endDate);
    notifyListeners();
  }
}
