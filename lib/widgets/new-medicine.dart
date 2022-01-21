import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewMedicine extends StatefulWidget {
  final Function addmedz;

  NewMedicine(this.addmedz);

  @override
  _NewMedicineState createState() => _NewMedicineState();
}

class _NewMedicineState extends State<NewMedicine> {
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();
  dynamic futureTime;

  void _submitData() {
    final enternedName = _nameController.text;
    final enteredDose = int.parse(_doseController.text);

    if (enternedName.isEmpty || enteredDose <= 0 || futureTime == null) {
      return;
    }
    widget.addmedz(
      enternedName,
      enteredDose,
      futureTime,
    );
    Navigator.of(context).pop();
  }

  void _timeSelctor() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime == null) {
        return;
      }
      setState(() {
        futureTime = selectedTime;
        print(futureTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.greenAccent,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(labelText: 'Name'),
            controller: _nameController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Dose'),
            controller: _doseController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(futureTime == null
                      ? 'No Time chosen!'
                      : ' Picked Time: ${futureTime.hour}:${futureTime.minute}'),
                ),
                FlatButton(
                  onPressed: _timeSelctor,
                  child: Text(
                    'Select Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: _submitData,
            child: Text('Add Reminder'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
        ]),
      ),
    );
  }
}
