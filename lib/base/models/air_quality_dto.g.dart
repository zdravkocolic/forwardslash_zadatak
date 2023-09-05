// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_quality_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirQualityDTO _$AirQualityDTOFromJson(Map<String, dynamic> json) =>
    AirQualityDTO(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      hourly: Hourly.fromJson(json['hourly'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AirQualityDTOToJson(AirQualityDTO instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'hourly': instance.hourly,
    };
