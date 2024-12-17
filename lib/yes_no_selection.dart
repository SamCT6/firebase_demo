import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_state.dart';
import 'src/widgets.dart';

int guests = 0;


class YesNoSelection extends StatelessWidget {
  
  const YesNoSelection(
      {super.key, required this.state, required this.onSelection});
  final Attending state;
  final void Function(Attending selection) onSelection;
  

  void addGuest (){
    FirebaseFirestore.instance.collection("attendees").doc(FirebaseAuth.instance.currentUser!.uid).set({
      'attending': true,
      "guests": guests
  });
  }
  void noGuest (){
    guests = 0;
    addGuest();
    FirebaseFirestore.instance.collection("attendees").doc(FirebaseAuth.instance.currentUser!.uid).set({
      'attending': false,
      "guests": guests,
      
  });
  }

  
  @override
  Widget build(BuildContext context) {
    switch (state) {
      case Attending.yes:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 100,
                child: TextField(
                decoration: InputDecoration(hintText: "How many guest?"),
                onChanged: (value) {
                  guests = int.parse(value);
                } ,
              ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: (noGuest),
                child: const Text('NO'),
              ),
              TextButton(onPressed: addGuest, child: Text("Enter"))
            ],
          ),
        );
      case Attending.no:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () => onSelection(Attending.yes),
                child: const Text('YES'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => onSelection(Attending.no),
                child: const Text('NO'),
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              StyledButton(
                onPressed: () => onSelection(Attending.yes),
                child: const Text('YES'),
              ),
              const SizedBox(width: 8),
              StyledButton(
                onPressed: () => onSelection(Attending.no),
                child: const Text('NO'),
              ),
              
            ],
          ),
        );
    }
  }
}