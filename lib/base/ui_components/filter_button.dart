import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zadatak/base/ui_components/selected_date_info.dart';

import '../models/air_quality_dto.dart';
import '../provider/air_quality_details.dart';
import 'my_date_picker.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.airQuality,
  });
  final AirQualityDTO airQuality;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AirQualityDetails>(context, listen: false);

    return IconButton(
        onPressed: () async {
          await _buildShowModalBottomSheet(context, provider);
        },
        icon: const Icon(
          Icons.filter_alt,
          color: Colors.white,
        ));
  }

  Future<dynamic> _buildShowModalBottomSheet(
      BuildContext context, AirQualityDetails provider) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: MediaQuery.sizeOf(context).height / 3,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            MyDatePicker(
                              provider: provider,
                              isStartDate: true,
                              text: 'Pick start date',
                              airQuality: airQuality,
                            ),
                            SelectedDateInfo(
                                context: context,
                                text: 'Start date',
                                date: context
                                    .watch<AirQualityDetails>()
                                    .startDate)
                          ],
                        ),
                        Column(
                          children: [
                            MyDatePicker(
                              provider: provider,
                              isStartDate: false,
                              text: 'Pick end date',
                              airQuality: airQuality,
                            ),
                            SelectedDateInfo(
                                context: context,
                                text: 'End date',
                                date:
                                    context.watch<AirQualityDetails>().endDate),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildElevatedButton(
                          provider: provider,
                          context: context,
                          text: 'Clear',
                          onPressed: () {
                            provider.setStartDate(null);
                            provider.setEndDate(null);
                            context
                                .read<AirQualityDetails>()
                                .getAirQualityDetails(
                                    airQuality.latitude, airQuality.longitude);
                          },
                        ),
                        _buildElevatedButton(
                          provider: provider,
                          context: context,
                          text: 'Select',
                          onPressed: context
                                          .watch<AirQualityDetails>()
                                          .startDate !=
                                      null &&
                                  context.watch<AirQualityDetails>().endDate !=
                                      null
                              ? () {
                                  provider.getAirQualityFiltered(
                                      airQuality.latitude,
                                      airQuality.longitude);
                                  Navigator.of(context).pop();
                                }
                              : null,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _buildElevatedButton({
    required AirQualityDetails provider,
    required BuildContext context,
    required String text,
    required Function()? onPressed,
  }) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(62, 63, 68, 1),
            padding: const EdgeInsets.symmetric(horizontal: 50)),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
