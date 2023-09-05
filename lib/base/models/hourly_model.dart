import 'package:json_annotation/json_annotation.dart';
part 'hourly_model.g.dart';

@JsonSerializable()
class Hourly {
  Hourly(
    this.time,
    this.pm10,
    this.pm25,
    this.nitrogenDioxide,
  );

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
  Map<String, dynamic> toJson() => _$HourlyToJson(this);
  final List<int> time;
  final List<double?> pm10;
  @JsonKey(name: 'pm2_5')
  final List<double?> pm25;
  @JsonKey(name: 'nitrogen_dioxide')
  final List<double?> nitrogenDioxide;
}
