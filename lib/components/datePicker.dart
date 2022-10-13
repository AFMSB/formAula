import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key}) : super(key: key);

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  late DateTime data = DateTime(2022, 10, 13);

  void updateDateState(DateTime? newDate){
    if (newDate != null) {
      setState(() {
        data = newDate;
      });
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
