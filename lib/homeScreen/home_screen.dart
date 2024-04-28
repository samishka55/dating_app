import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/tabScreens/favourite_sent_received_screen.dart';
import 'package:dating_app/tabScreens/like_sent_received_screen.dart';
import 'package:dating_app/tabScreens/swiping_screen.dart';
import 'package:dating_app/tabScreens/user_details_screen.dart';
import 'package:dating_app/tabScreens/view_sent_received_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{

  int screenIndex = 0;

  List tabScreenList =
  [
    const SwipingScreen(),
    const ViewSentReceivedScreen(),
    const FavouriteSentReceivedScreen(),
    const LikeSentReceivedScreen(),
    UserDetailsScreen(userID: FirebaseAuth.instance.currentUser!.uid,)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber)
        {
          setState(() {
            screenIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.shifting,
        // backgroundColor: Color(0xFF37474F),
        selectedItemColor: Color(0xFFFFFFFF),
        unselectedItemColor: Color(0xFF575252),
        currentIndex: screenIndex,
        items: const [

          //Swiping Screen icon Button
          BottomNavigationBarItem(
            icon: Icon(
                Icons.home,
              size: 30,
            ),
            label: ""
          ),

          //Views Sent and Received icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye,
                size: 30,
              ),
              label: ""
          ),

          //Favourite Sent and Received icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 30,
              ),
              label: ""
          ),

          //Likes sent and Received icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              label: ""
          ),

          //User details icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: ""
          ),

        ],
      ),
      body: tabScreenList[screenIndex],
    );
  }
}
