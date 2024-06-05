import 'package:flutter/material.dart';

//iimport 'package:flutter/material.dart';

class secondRectangleBoxes extends StatelessWidget {
  //final String leftText;
  final String rightText;
  final bool isHighlighted;
  final Function()? onTap;
 // final BoxDecoration leftDecoration;
  final BoxDecoration rightDecoration;

  const secondRectangleBoxes({
    Key? key,
    //required this.leftText,
    required this.rightText,
    required this.isHighlighted,
    this.onTap,
   // required this.leftDecoration,
    required this.rightDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Row(children: [
          Padding(
         padding: const EdgeInsets.only(right:0, top: 8),
            
            child: Container(
              width: 180,
              height: 250,
              decoration: rightDecoration.copyWith(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
               
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        rightText,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                   Positioned(
                    bottom: 10,
                    right: 10,
                    left: 10,
                    child: Image.asset(
                      'lib/assets/imagenote.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
