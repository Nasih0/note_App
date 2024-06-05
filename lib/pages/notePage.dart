import 'dart:ui'; // For blur effect

import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  final Function(String, String) onSave;
  final String? existingHeading;
  final String? existingDescription;
  final String? documentId;

  const AddNotePage({
    required this.onSave,
    this.existingHeading,
    this.existingDescription,
    this.documentId,
    Key? key,
  }) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _headingController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _headingController = TextEditingController(text: widget.existingHeading);
    _descriptionController =
        TextEditingController(text: widget.existingDescription);
  }

  @override
  void dispose() {
    _headingController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSave() {
    widget.onSave(
      _headingController.text,
      _descriptionController.text,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildGlassyTextField(_headingController, 'Heading'),
            SizedBox(height: 20),
            _buildGlassyTextField(_descriptionController, 'add your note here',
                maxLines: 10),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white.withOpacity(0.2), // Replaces primary
                foregroundColor: Colors.white, // Replaces onPrimary
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Save', style: TextStyle(fontSize: 18.0)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGlassyTextField(
      TextEditingController controller, String labelText,
      {int maxLines = 1}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            ),
            maxLines: maxLines,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
