import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/NoteDetailsPage.dart';
import 'package:note_app/pages/image&textPage.dart';
import 'package:note_app/pages/notePage.dart';
import 'package:note_app/pages/todoPage.dart';
import 'package:note_app/services/firestore.dart';
import 'package:note_app/widgets/rounded_rectangle.dart';
import 'package:note_app/widgets/second_rectangle.dart';
import 'package:note_app/widgets/firstRectangle.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final FirestoreService firestoreService = FirestoreService();
  List<Map<String, String>> notes = [];
  // List<String> notes = [];
  // Text controller to access the text in the openNoteBox dialog box
  final TextEditingController textController = TextEditingController();

  void _addNote(String heading, String description) {
    setState(() {
      notes.add({'heading': heading, 'description': description});
      firestoreService.addNote(heading, description);
    });
  }

  int _highlightedIndex = 0;

  void _onBoxTapped(int index) {
    setState(() {
      _highlightedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "My\nNotes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 10), // Add some space between the text and the row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _onBoxTapped(0),
                    child: RectangleContainer(
                      color: Color.fromARGB(255, 0, 0, 0),
                      text: 'all',
                      isHighlighted: _highlightedIndex == 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onBoxTapped(1),
                    child: RectangleContainer(
                      color: Color.fromARGB(255, 0, 0, 0),
                      text: 'important',
                      isHighlighted: _highlightedIndex == 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onBoxTapped(2),
                    child: RectangleContainer(
                      color: Color.fromARGB(255, 0, 0, 0),
                      text: 'to do',
                      isHighlighted: _highlightedIndex == 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onBoxTapped(3),
                    child: RectangleContainer(
                      color: Color.fromARGB(255, 0, 0, 0),
                      text: 'special',
                      isHighlighted: _highlightedIndex == 3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First Rectangle with Sharp Edge
                  FirstRectangleBoxes(
                    leftText: 'to do listt',
                    isHighlighted: false,
                    onTap: () {
                      // Navigate to respective page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TodoPage(),
                        ),
                      );
                    },
                    leftDecoration: BoxDecoration(
                      color: Color(0xFFE87A55),
                    ),
                  ),

                  // Second Rectangle with Sharp Edge
                  secondRectangleBoxes(
                    rightText: 'image notes',
                    isHighlighted: false,
                    onTap: () {
                      // Navigate to respective page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const imagetextPage()
                        ),
                      );
                    },
                    rightDecoration: BoxDecoration(
                      color: Color(0xFFF7D24D),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getNoteStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List noteList = snapshot.data!.docs;
                    print(
                        "Notes fetched: ${noteList.length}"); // Debug statement
                    // Display list
                    return ListView.builder(
                      itemCount: noteList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = noteList[index];
                        String docID = document.id;

                        // Get note from each doc
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String heading = data['heading'] ?? 'No Heading';
                        String description =
                            data['description'] ?? 'No Description';

                        print("Note: $heading"); // Debug statement
                        print("Description: $description"); // Debug statement
                        // Debug statement
                        // Determine the color based on the index
                        Color backgroundColor;
                        if (index % 3 == 0) {
                          backgroundColor = Color(0xFFF5EBC8);
                        } else if (index % 3 == 1) {
                          backgroundColor = Color(0xFFABD476);
                        } else {
                          backgroundColor = Color(0xFF6696CE);
                        }
                        // Display as a list tile
                        return Card(
                          color: Colors.black,
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Container(
                              height: 80,
                              width: 10,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NoteDetailsPage(
                                            docID: docID,
                                                heading: data['heading'],
                                                description:
                                                    data['description'],
                                              )));
                                },
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    heading,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 0, 0, 0,),fontSize: 20),
                                  ),
                                ),
                                trailing: IconButton(
                                    onPressed: () =>
                                        firestoreService.deleteNote(docID),
                                    icon: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: const Icon(Icons.delete,color: Color.fromARGB(255, 0, 0, 0),size: 30,),
                                    )),
                              )),
                        );
                      },
                    );
                  } else {
                    // If there is no data, return a message
                    return const Text(" nothing",
                        style: TextStyle(color: Colors.white));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNotePage(onSave: _addNote)),
              );
            },
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 133, 133, 133),
              size: 40,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
