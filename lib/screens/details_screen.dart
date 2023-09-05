import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zadatak/base/models/air_quality_dto.dart';
import 'package:zadatak/base/provider/air_quality_details.dart';
import 'package:zadatak/base/ui_components/my_date_picker.dart';
import 'package:zadatak/base/ui_components/selected_date_info.dart';

import '../base/ui_components/filter_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key, required this.airQuality, required this.cityName});

  final AirQualityDTO airQuality;
  final String cityName;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final bool isShowingMainData = true;
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final data = context.watch<AirQualityDetails>().airQuality;
    return WillPopScope(
      onWillPop: () async {
        context.read<AirQualityDetails>().reset();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              'Details for ${widget.cityName}',
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              !kIsWeb
                  ? FilterButton(airQuality: widget.airQuality)
                  : const SizedBox.shrink(),
            ],
          ),
          body: Container(
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kIsWeb
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                MyDatePicker(
                                  provider: context.read<AirQualityDetails>(),
                                  isStartDate: true,
                                  text: 'Pick start date',
                                  airQuality: widget.airQuality,
                                ),
                                SelectedDateInfo(
                                  context: context,
                                  text: 'Start date',
                                  date: context
                                      .watch<AirQualityDetails>()
                                      .startDate,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                MyDatePicker(
                                  provider: context.read<AirQualityDetails>(),
                                  isStartDate: false,
                                  text: 'Pick end date',
                                  airQuality: widget.airQuality,
                                ),
                                SelectedDateInfo(
                                  context: context,
                                  text: 'End date',
                                  date: context
                                      .watch<AirQualityDetails>()
                                      .endDate,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: kIsWeb
                      ? _buildScrollbarForWeb(data, context)
                      : _buildCustomScrollView(data, context),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLegend(name: 'Pm10', color: Colors.green),
                      _buildLegend(name: 'Pm2.5', color: Colors.pinkAccent),
                      _buildLegend(
                          name: 'Nitrogen dioxide', color: Colors.cyan),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollbarForWeb(AirQualityDTO? data, BuildContext context) {
    return Theme(
      data: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(Colors.grey[500])),
      ),
      child: Scrollbar(
        controller: _controller,
        thumbVisibility: true,
        trackVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: _buildCustomScrollView(data, context),
      ),
    );
  }

  Widget _buildCustomScrollView(AirQualityDTO? data, BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 70, 15, 20),
            child: SizedBox(
              height: 400,
              width: (data ?? widget.airQuality).hourly.time.length * 7 < 1000
                  ? 1000
                  : (data ?? widget.airQuality).hourly.time.length * 7,
              child: LineChart(
                LineChartData(
                  titlesData: titlesData1(context, data ?? widget.airQuality),
                  gridData: gridData,
                  borderData: borderData,
                  backgroundColor: const Color.fromRGBO(62, 63, 68, 1),
                  lineBarsData:
                      lineBarsData1(context, data ?? widget.airQuality),
                  maxY: (data ?? widget.airQuality)
                          .hourly
                          .pm10
                          .reduce((curr, next) => curr! > next! ? curr : next)!
                          .toInt() +
                      2,
                  minY: 0,
                ),
                duration: const Duration(milliseconds: 300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildLegend({required String name, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 10,
          width: 10,
          color: color,
        ),
      ],
    );
  }

  FlTitlesData titlesData1(BuildContext context, AirQualityDTO data) =>
      FlTitlesData(
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta),
        )),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              interval: 1,
              showTitles: true,
              getTitlesWidget: (value, meta) =>
                  bottomTitleWidgets(value, meta, data.hourly.time)),
        ),
      );

  List<LineChartBarData> lineBarsData1(
          BuildContext context, AirQualityDTO data) =>
      [
        lineChartBarData1(context, data),
        lineChartBarData2(context, data),
        lineChartBarData3(context, data),
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.white,
    );
    Widget text;
    text = Text(
      value.toStringAsFixed(0),
      style: style,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, List<int> time) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.white,
    );
    Widget text;
    var date = DateTime.fromMillisecondsSinceEpoch(time[value.toInt()] * 1000);

    if (date.hour == 0) {
      text = Text(
        DateFormat('d-MMM').format(date),
        style: style,
      );
    } else if (date.hour % 8 == 0) {
      text = Text(
        DateFormat('HH:mm').format(date),
        style: style,
      );
    } else {
      text = const Text('');
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  FlGridData get gridData =>
      const FlGridData(drawHorizontalLine: true, drawVerticalLine: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.transparent, width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData lineChartBarData1(BuildContext context, AirQualityDTO data) {
    return LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List<FlSpot>.generate(
          data.hourly.time.length,
          (index) => FlSpot(index.toDouble(), data.hourly.pm10[index]!),
        ));
  }

  LineChartBarData lineChartBarData2(
          BuildContext context, AirQualityDTO data) =>
      LineChartBarData(
        isCurved: true,
        color: Colors.pinkAccent,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink,
        ),
        spots: List<FlSpot>.generate(
          data.hourly.time.length,
          (index) => FlSpot(index.toDouble(), data.hourly.pm25[index]!),
        ),
      );

  LineChartBarData lineChartBarData3(
          BuildContext context, AirQualityDTO data) =>
      LineChartBarData(
        isCurved: true,
        color: Colors.cyan,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List<FlSpot>.generate(
          data.hourly.time.length,
          (index) =>
              FlSpot(index.toDouble(), data.hourly.nitrogenDioxide[index]!),
        ),
      );
}
