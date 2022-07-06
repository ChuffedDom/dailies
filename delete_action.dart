import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteAction extends StatefulWidget {
  final QueryDocumentSnapshot docSnap;
  const DeleteAction({Key? key, required this.docSnap}) : super(key: key);

  @override
  State<DeleteAction> createState() => _DeleteActionState();
}

class _DeleteActionState extends State<DeleteAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Action"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Do you want to delete this Action?"),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                widget.docSnap["action"],
                style: Theme.of(context).textTheme.titleLarge,
              ),
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
                              .delete();
                          Navigator.pop(context);
                        },
                        child: const Text("Delete"),
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
