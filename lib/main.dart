import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zadatak/base/data_source/air_quality_data_source.dart';
import 'package:zadatak/base/app/config/app_constants.dart';
import 'package:zadatak/base/repositories/air_quality_repository.dart';
import 'package:zadatak/base/service/air_quality_service.dart';
import 'package:zadatak/screens/google_map_screen.dart';

import 'base/provider/air_quality_details.dart';
import 'base/provider/coordinates.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Dio(context.read())),
        Provider(
            create: (context) => AirQualityDataSource(context.read<Dio>(),
                baseUrl: AppConstants.baseUrl)),
        Provider(
            create: (context) =>
                AirQualityRepository(context.read<AirQualityDataSource>())),
        Provider(
            create: (context) =>
                AirQualityService(context.read<AirQualityRepository>())),
        ChangeNotifierProvider(
            create: (context) =>
                Coordinates(context.read<AirQualityService>())),
        ChangeNotifierProvider(
            create: (context) =>
                AirQualityDetails(context.read<AirQualityService>())),
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GoogleMapScreen(),
      },
    );
  }
}
