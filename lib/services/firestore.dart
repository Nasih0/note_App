import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  final CollectionReference todos = FirebaseFirestore.instance.collection('todos');

  // Notes methods
  Future<void> addNote(String note, String description) {
    return notes.add({
      'heading': note,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNoteStream() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }

  Future<void> updateNote(String docID, String note, String description) {
    return notes.doc(docID).update({
      'heading': note,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }

  // Todo methods
  Future<void> addTodo(String task) {
    return todos.add({
      'task': task,
      'completed': false,
      'timestamp': Timestamp.now(),
    });
  }
  

  Stream<QuerySnapshot> getTodoStream() {
    return todos.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> updateTodoStatus(String docID, bool status) {
    return todos.doc(docID).update({'completed': status});
  }

  Future<void> deleteTodo(String docID) {
    return todos.doc(docID).delete();
  }
}
