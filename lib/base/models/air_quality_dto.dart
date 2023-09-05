import 'package:json_annotation/json_annotation.dart';
import 'package:zadatak/base/models/hourly_model.dart';

part 'air_quality_dto.g.dart';

@JsonSerializable()
class AirQualityDTO {
  AirQualityDTO({
    required this.latitude,
    required this.longitude,
    required this.hourly,
  });

  factory AirQualityDTO.fromJson(Map<String, dynamic> json) =>
      _$AirQualityDTOFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityDTOToJson(this);

  final double latitude;
  final double longitude;
  final Hourly hourly;
}
