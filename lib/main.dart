import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './widgets/new-medicine.dart';
import './models/medicines.dart';
import './widgets/medicines-list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine App',
      home: Homepage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  final List<Medicine> userMeds = [
    // Medicine(
    //   id: 'med1',
    //   name: 'pandol',
    //   time: DateTime.now(),
    //   dose: 1,
    // ),
    // Medicine(
    //   id: 'med1',
    //   name: 'carbimazole',
    //   time: DateTime.now(),
    //   dose: 1,
    // ),
    // Medicine(
    //   id: 'med1',
    //   name: 'profin',
    //   time: DateTime.now(),
    //   dose: 1,
    // ),
  ];

  //adding state listener
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  //clearing the state listeners
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  //method to do when state changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  void addMedicine(String medName, int medDose, TimeOfDay chosenTime) {
    final newMed = Medicine(
      id: DateTime.now().toString(),
      name: medName,
      time: chosenTime,
      dose: medDose,
    );
    setState(() {
      userMeds.add(newMed);
    });
  }

  void showMeds(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewMedicine(addMedicine),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteMedicine(String id) {
    setState(() {
      userMeds.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Reminder'),
        actions: [
          IconButton(
            onPressed: () => {showMeds(context)},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: MedsList(userMeds, deleteMedicine),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {showMeds(context)},
      ),
    );
  }
}
