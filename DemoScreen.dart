import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  DemoScreen({super.key, required this.name});
  var name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("HELLO " + name),
          ElevatedButton(onPressed:() {
            Navigator.pop(context);
          },child: Text("Go Back"),)
        ],
      ),
    );
  }
}
