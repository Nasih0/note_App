import 'package:flutter/material.dart';
import 'package:note_app/services/firestore.dart';

class NoteDetailsPage extends StatefulWidget {
  final String docID;
  final String heading;
  final String description;

  const NoteDetailsPage({
    required this.docID,
    required this.heading,
    required this.description,
  });

  @override
  _NoteDetailsPageState createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  late TextEditingController _headingController;
  late TextEditingController _descriptionController;
  bool _isEditingTitle = false;
  bool _isEditingDescription = false;
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _headingController = TextEditingController(text: widget.heading);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _headingController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _toggleEditingTitle() {
    setState(() {
      _isEditingTitle = !_isEditingTitle;
    });
  }

  void _toggleEditingDescription() {
    setState(() {
      _isEditingDescription = !_isEditingDescription;
    });
  }

  Future<void> _saveNote() async {
    // Logic to save the note can be added here, e.g., update the backend or local storage
    // For this example, we're just toggling the editing mode off
    await firestoreService.updateNote(
      widget.docID,
      _headingController.text,
      _descriptionController.text,
    );
    setState(() {
      _isEditingTitle = false;
      _isEditingDescription = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7D24D),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7D24D),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 25,
                  color: Colors.black),
            ),
            GestureDetector(
              onTap: _toggleEditingTitle,
              child: _isEditingTitle
                  ? TextField(
                      controller: _headingController,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 50),
                    )
                  : Text(
                      _headingController.text,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 50),
                    ),
            ),
            SizedBox(height: 20),
            Text(
              'Description',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 25,
                  color: Colors.black),
            ),
            GestureDetector(
              onTap: _toggleEditingDescription,
              child: _isEditingDescription
                  ? TextField(
                      controller: _descriptionController,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      maxLines: null,
                    )
                  : Text(
                      _descriptionController.text,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
