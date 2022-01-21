import 'package:flutter/material.dart';
import '../models/medicines.dart';
import 'package:intl/intl.dart';

class MedsList extends StatelessWidget {
  final List<Medicine> medz;
  final Function removeMedz;

  MedsList(this.medz, this.removeMedz);

  @override
  Widget build(BuildContext context) {
    return medz.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'android/assets/images/medKit.jpg',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "No medicine added yet !",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Card(
                  margin: EdgeInsets.only(top: 10),
                  elevation: 5,
                  shadowColor: Colors.greenAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        medz[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        '${medz[index].dose} tablet/s',
                        style: TextStyle(
                          fontFamily: 'veredana',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        
                        ' At : ${medz[index].time.hour}: ${medz[index].time.minute}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'verdena',
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () => removeMedz(medz[index].id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          iconSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: medz.length,
          );
  }
}
