import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MySlider extends StatelessWidget {
  final double value;
  final ValueChanged onChanged;

  const MySlider({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Expectativa salarial',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Text(
          NumberFormat.currency(symbol: "€", decimalDigits: 0).format(value),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Slider(
            min: 800,
            max: 5000,
            divisions: 84,
            value: value,
            onChanged: onChanged),
      ],
    );
  }
}
