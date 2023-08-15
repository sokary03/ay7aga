import 'package:flutter/material.dart';

class BmiCalculator extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Row(
          children:
          [
            Text(
              'fatima al sokkar',
            ),
            Icon(
              Icons.notification_add,
            ),

          ],
        ),


      ),
    );
  }
}
