import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddAction extends StatefulWidget {
  const AddAction({Key? key}) : super(key: key);

  @override
  State<AddAction> createState() => _AddActionState();
}

class _AddActionState extends State<AddAction> {
  // This reads the contents of the text field
  final actionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Action',
                ),
                controller: actionController,
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  // Get User ID from FirebaseAuth and Task from field
                  String? userId = FirebaseAuth.instance.currentUser?.uid;
                  String? action = actionController.text;
                  final newAction = <String, dynamic>{
                    "uid": userId,
                    "action": action,
                  };
                  FirebaseFirestore.instance
                      .collection('actions')
                      .add(newAction)
                      .then((DocumentReference doc) =>
                          print('DocumentSnapshot added with ID: ${doc.id}'));
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
