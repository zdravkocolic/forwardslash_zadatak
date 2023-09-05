import 'package:flutter/material.dart';

class SelectedDateInfo extends StatelessWidget {
  const SelectedDateInfo({
    super.key,
    required this.context,
    required this.text,
    required this.date,
  });

  final BuildContext context;
  final String text;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: date != null
          ? Column(
              children: [
                Text(
                  '$text:',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  date ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
