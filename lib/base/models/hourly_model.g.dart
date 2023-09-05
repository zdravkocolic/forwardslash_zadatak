// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
      (json['time'] as List<dynamic>).map((e) => e as int).toList(),
      (json['pm10'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
      (json['pm2_5'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
      (json['nitrogen_dioxide'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
    );

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'time': instance.time,
      'pm10': instance.pm10,
      'pm2_5': instance.pm25,
      'nitrogen_dioxide': instance.nitrogenDioxide,
    };
