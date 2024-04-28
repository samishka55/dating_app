import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";


class UploadPhotos extends StatelessWidget {
  UploadPhotos({super.key});

  List<String> selectedItems = [];
  List<String> interests = [
    'Music',
    'Arts',
    'Dance',
    'Movies',
    'Travel',
    'Food',
    'Athletics'
  ];


  FirebaseFirestore firestore = FirebaseFirestore.instance;


  // Upload interests
  Future<void> updateUserInterests(List<String> selectedItems) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Update user document with selected items
      await firestore.collection('users').doc(userId).update({
        'interests': selectedItems,
      });

      // Display success message
      print('User interests updated successfully!');
    } catch (error) {
      // Handle errors
      print('Error updating user interests: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("dd"),
      ),
    );
  }
}


