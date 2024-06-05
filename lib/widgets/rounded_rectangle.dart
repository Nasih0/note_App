import 'package:flutter/material.dart';

class RectangleContainer extends StatefulWidget {
  final Color color;
  final String text;
  final bool isHighlighted;

  RectangleContainer({
    required this.color,
    required this.text,
    required this.isHighlighted,
  });

  @override
  State<RectangleContainer> createState() => _RectangleContainerState();
}

class _RectangleContainerState extends State<RectangleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 60,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(
          color: widget.isHighlighted ? Colors.white : const Color.fromARGB(255, 103, 103, 103),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(26.0), // Optional: for rounded corners
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.isHighlighted ? Colors.white : Color.fromARGB(255, 112, 111, 111),
            fontWeight: FontWeight.w200,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}