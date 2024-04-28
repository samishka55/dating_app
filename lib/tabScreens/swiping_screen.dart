import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controllers/profile_controller.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/tabScreens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwipingScreen extends StatefulWidget {
  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {

  ProfileController profileController = Get.put(ProfileController());
  String senderName = "";

  void shuffleUserProfiles() async {
    setState(() {
      profileController.allUsersProfileList.shuffle();
    });
  }

  readCurrentUserData() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((dataSnapshot)
    {
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (profileController.allUsersProfileList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          shuffleUserProfiles();
          return PageView.builder(
            itemCount: profileController.allUsersProfileList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final eachProfileInfo =
              profileController.allUsersProfileList[index];

              return DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      eachProfileInfo.imageProfile.toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      //Filter icon button
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: IconButton(
                            onPressed: ()
                            {

                            },
                            icon: const Icon(
                              Icons.filter_list,
                              size: 30,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      //User data
                      GestureDetector(
                        onTap: ()
                        {
                          profileController.viewSentAndViewReceived(
                              eachProfileInfo.uid.toString(),
                              senderName,
                          );

                          //send user to profile person userDetailsScreen
                          Get.to(UserDetailsScreen(
                              userID: eachProfileInfo.uid.toString()
                          ));
                        },
                        child: Column(
                          children: [

                            //Name
                            Text(
                              eachProfileInfo.name.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //Username
                            Text(
                              eachProfileInfo.username.toString()  + " ⦿ " + eachProfileInfo.city.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 3,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                    )
                                  ),
                                  child: Text(
                                    eachProfileInfo.profession.toString(),
                                  ),
                                )
                              ],
                            )

                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      //image buttons favourite,chat,like
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          //favourite button
                          GestureDetector(
                            onTap: ()
                            {
                              profileController.favouriteSentAndFavouriteReceived(
                                eachProfileInfo.uid.toString(),
                                senderName,

                              );
                            },
                            child: Image.asset(
                              "images/favourite.png",
                              width: 60,
                            ),
                          ),

                          //chat button
                          GestureDetector(
                            onTap: ()
                            {

                            },
                            child: Image.asset(
                              "images/chat.png",
                              width: 90,
                            ),
                          ),

                          //like button
                          GestureDetector(
                            onTap: ()
                            {
                              profileController.likeSentAndlikeReceived(
                                eachProfileInfo.uid.toString(),
                                senderName,
                              );

                            },
                            child: Image.asset(
                              "images/like.png",
                              width: 60,
                            ),
                          )

                        ],
                      )

                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
