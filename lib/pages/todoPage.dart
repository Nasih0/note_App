import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/services/firestore.dart';
//import 'firestore_service.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE87A55),
      appBar: AppBar(
        backgroundColor: Color(0xFFE87A55),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          iconSize: 30,
          color: Colors.black,
        ),
        title: Text(
          'To-Do List',
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        hintText: 'Add a new task',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_taskController.text.isNotEmpty) {
                        _firestoreService.addTodo(_taskController.text);
                        _taskController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestoreService.getTodoStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final todos = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      final task = todo['task'];
                      final completed = todo['completed'];

                      return ListTile(
                        leading: Checkbox(
                          value: completed,
                          onChanged: (bool? value) {
                            _firestoreService.updateTodoStatus(todo.id, value ?? false);
                          },
                        ),
                        title: Text(
                          task,
                          style: TextStyle(
                            color: completed ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
                            decoration: completed ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: const Color.fromARGB(255, 0, 0, 0)),
                          onPressed: () {
                            _firestoreService.deleteTodo(todo.id);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
