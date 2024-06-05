import 'package:flutter/material.dart';

class FirstRectangleBoxes extends StatelessWidget {
  final String leftText;
  final bool isHighlighted;
  final Function()? onTap;
  final BoxDecoration leftDecoration;

  const FirstRectangleBoxes({
    Key? key,
    required this.leftText,
    required this.isHighlighted,
    this.onTap,
    required this.leftDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0, top: 8),
            child: Container(
              width: 180,
              height: 250,
              decoration: leftDecoration.copyWith(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                 // bottomRight: Radius.circular(40.0),
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
                        leftText,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:0,
                    right: 0,
                    left: 10,
                    child: Image.asset(
                      'lib/assets/todo3.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 8),
          ),
        ],
      ),
    );
  }
}
