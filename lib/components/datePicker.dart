import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key, required this.datePickerCallback}) : super(key: key);

  final Function(dynamic value) datePickerCallback;

  @override
  State<MyDatePicker> createState() => _MyDatePickerState(
      datePickerCallback
  );
}

class _MyDatePickerState extends State<MyDatePicker> {
  late DateTime data = DateTime(2022, 10, 13);
  final Function(dynamic value) datePickerCallback;

  _MyDatePickerState(this.datePickerCallback);

  void updateDateState(DateTime? newDate){
    if (newDate != null) {
      setState(() {
        data = newDate;
      });
      this.datePickerCallback(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text('Data de Nascimento'),
            Text(intl.DateFormat("dd/MM/yyyy").format(data)),
          ],
        ),
        TextButton(
            onPressed: () async {
              var newDate = await showDatePicker(
                  context: context,
                  initialDate: data,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2023));
              this.updateDateState(newDate);
            },
            child: Text('Editar')),
      ],
    );
  }
}
