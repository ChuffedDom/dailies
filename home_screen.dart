import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'actions.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dailies'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.account_circle_sharp),
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'logout'}.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            // get the documents in the action collection
            stream: db
                .collection('actions')
                .orderBy("done")
                .where(
                  "uid",
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid,
                )
                .snapshots(),
            builder: (context, snapshot) {
              // Whilst waiting for stream
              if (!snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              var docs = snapshot.data!.docs;
              if (docs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: Center(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'add-action');
                      },
                      child: const Text("Start by Adding a Task"),
                    ),
                  ),
                );
              }
              // A bit like looping through a query list
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: docs.length,
                  // For each item in list do this
                  itemBuilder: (BuildContext context, int index) {
                    return ActionItem(
                      doc: docs[index],
                    );
                  });
            },
          ),
          // Wrap button in centre to not create full width in ListView
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                var collection =
                    FirebaseFirestore.instance.collection('actions').where(
                          "uid",
                          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
                        );
                var querySnapshots = await collection.get();
                for (var doc in querySnapshots.docs) {
                  await doc.reference.update({
                    'done': false,
                  });
                }
              },
              child: const Text("New Day"),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'add-action');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void handleClick(String value) {
  switch (value) {
    case 'logout':
      FirebaseAuth.instance.signOut();
      break;
  }
}
