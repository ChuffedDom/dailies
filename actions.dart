import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'delete_action.dart';
import 'edit_action.dart';

class ActionItem extends StatefulWidget {
  // send a single doc to the widget
  final QueryDocumentSnapshot doc;
  ActionItem({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  State<ActionItem> createState() => _ActionItemState();
}

class _ActionItemState extends State<ActionItem> {
  @override
  Widget build(BuildContext context) {
    // Get the values for the field of the doc
    String action = widget.doc["action"];
    bool isDone = widget.doc["done"];
    String docId = widget.doc.id;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.25,
          ),
        ),
      ),
      child: ListTile(
        leading: Checkbox(
          onChanged: (value) {
            // Get document by id and update field as a map
            FirebaseFirestore.instance
                .collection("actions")
                .doc(docId)
                .update({"done": value});
            setState(() {});
          },
          value: isDone,
        ),
        title: Text(action),
        trailing: PopupMenuButton<String>(
          onSelected: (choice) => handleClick(
            choice,
            docSnap: widget.doc,
            context: context,
          ),
          itemBuilder: (BuildContext context) {
            return {'edit', 'delete'}.map((String choice) {
              return PopupMenuItem(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}

void handleClick(String value,
    {required QueryDocumentSnapshot docSnap, required BuildContext context}) {
  switch (value) {
    case 'edit':
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return EditAction(
              docSnap: docSnap,
            );
          },
        ),
      );
      break;
    case 'delete':
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return DeleteAction(
              docSnap: docSnap,
            );
          },
        ),
      );
      break;
  }
}
