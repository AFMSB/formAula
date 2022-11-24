import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatelessWidget {
  final DateTime data;
  final ValueChanged onChanged;

  const MyDatePicker({required this.data, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Data de Nascimento',
                style: Theme.of(context).textTheme.bodyLarge),
            Text(DateFormat("dd/MM/yyyy").format(data),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        TextButton(
          child: const Text('Editar'),
          onPressed: () async {
            var newDate = await showDatePicker(
                context: context,
                initialDate: data,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            if (newDate == null) {
              return;
            }
            onChanged(newDate);
          },
        )
      ],
    );
  }
}
