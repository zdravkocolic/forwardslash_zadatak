import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zadatak/base/models/air_quality_dto.dart';

import '../provider/air_quality_details.dart';

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({
    super.key,
    required this.provider,
    required this.text,
    required this.isStartDate,
    required this.airQuality,
  });

  final AirQualityDetails provider;
  final String text;
  final bool isStartDate;
  final AirQualityDTO airQuality;
  @override
  Widget build(BuildContext context) {
    final startDate = context.watch<AirQualityDetails>().startDate;
    final endDate = context.watch<AirQualityDetails>().endDate;
    return ElevatedButton(
        onPressed: () async {
          await showDatePicker(
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.black, // header background color
                    onPrimary: Colors.white, // header text color
                    onSurface: Colors.black, // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: startDate != null
                ? DateTime.parse(startDate)
                : endDate != null
                    ? DateTime.parse(endDate)
                    : DateTime.now(),
            firstDate: startDate != null
                ? DateTime.parse(startDate)
                : DateTime.now().subtract(const Duration(days: 60)),
            lastDate: endDate != null
                ? DateTime.parse(endDate)
                : DateTime.now().add(const Duration(days: 1)),
          ).then((value) {
            if (value != null) {
              String date = DateFormat('yyyy-MM-dd').format(value);
              isStartDate
                  ? provider.setStartDate(date)
                  : provider.setEndDate(date);
              kIsWeb
                  ? provider.startDate != null && provider.endDate != null
                      ? provider.getAirQualityFiltered(
                          airQuality.latitude, airQuality.longitude)
                      : null
                  : null;
            }
          });
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ));
  }
}
