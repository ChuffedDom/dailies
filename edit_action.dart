import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditAction extends StatefulWidget {
  final QueryDocumentSnapshot docSnap;
  const EditAction({
    Key? key,
    required this.docSnap,
  }) : super(key: key);

  @override
  State<EditAction> createState() => _EditActionState();
}

class _EditActionState extends State<EditAction> {
  // This reads the contents of the text field
  var actionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    actionController = TextEditingController(text: widget.docSnap["action"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit task'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Action',
                ),
                autofocus: true,
                controller: actionController,
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("actions")
                              .doc(widget.docSnap.id)
                              .update({"action": actionController.text});
                          Navigator.pop(context);
                        },
                        child: const Text("Edit"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
