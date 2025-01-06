import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layouts/DemoScreen.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  TextEditingController mycontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Navigate To DemoScreen" , style: TextStyle(
            fontSize: 20,
          ),),
          TextField(
            controller: mycontroller,
            autofocus: true,

          ),
          ElevatedButton(onPressed:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DemoScreen(name : mycontroller.text.toString())));
          }, child: Text("Go To DemoScreen"))
        ],
      ),
    );
  }
}
