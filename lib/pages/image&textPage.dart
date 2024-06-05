import 'package:flutter/material.dart';

class imagetextPage extends StatelessWidget {
  const imagetextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7D24D),
      body: SafeArea(
        child: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () {
             Navigator.pop(context);
          },
          iconSize: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
