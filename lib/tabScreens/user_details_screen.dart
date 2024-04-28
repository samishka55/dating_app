import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/AccountSettingsScreen/account_settings_screen.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatefulWidget {

  String? userID;

  UserDetailsScreen({super.key, this.userID});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {

  //Personal info
  String name = '';
  String username = '';
  String email = '';
  String city = '';
  String phone = '';
  String profession = '';
  //String interests = '';

  //slider images
  String urlImage1 = "https://firebasestorage.googleapis.com/v0/b/dating-app-d737c.appspot.com/o/placeholder%2Fprofile_avatar%20(2).jpg?alt=media&token=1ba821d3-90ca-47ef-8aae-39b4655bc98e";
  String urlImage2 = "https://firebasestorage.googleapis.com/v0/b/dating-app-d737c.appspot.com/o/placeholder%2Fprofile_avatar%20(2).jpg?alt=media&token=1ba821d3-90ca-47ef-8aae-39b4655bc98e";
  String urlImage3 = "https://firebasestorage.googleapis.com/v0/b/dating-app-d737c.appspot.com/o/placeholder%2Fprofile_avatar%20(2).jpg?alt=media&token=1ba821d3-90ca-47ef-8aae-39b4655bc98e";
  String urlImage4 = "https://firebasestorage.googleapis.com/v0/b/dating-app-d737c.appspot.com/o/placeholder%2Fprofile_avatar%20(2).jpg?alt=media&token=1ba821d3-90ca-47ef-8aae-39b4655bc98e";
  String urlImage5 = "https://firebasestorage.googleapis.com/v0/b/dating-app-d737c.appspot.com/o/placeholder%2Fprofile_avatar%20(2).jpg?alt=media&token=1ba821d3-90ca-47ef-8aae-39b4655bc98e";

  retrieveUserInfo() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userID)
        .get()
        .then((snapshot)
    {
      if(snapshot.exists)
      {
        if(snapshot.data()!["urlImage1"] != null)
        {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            urlImage4 = snapshot.data()!["urlImage4"];
            urlImage5 = snapshot.data()!["urlImage5"];
          });
        }
        setState(() {
          name = snapshot.data()!["name"];
          username = snapshot.data()!["username"];
          email = snapshot.data()!["email"];
          city = snapshot.data()!["city"];
          phone = snapshot.data()!["phone"];
          profession = snapshot.data()!["profession"];
          //interests = snapshot.data()!["interests"];
        });

      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserInfo();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "User Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: widget.userID != FirebaseAuth.instance.currentUser!.uid ? IconButton(
          onPressed: ()
          {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_outlined, size: 30,),
        ) : Container(),
        actions: [
          widget.userID == FirebaseAuth.instance.currentUser!.uid ?
          Row(
            children: [
              IconButton(
                onPressed: ()
                {
                  Get.to(const AccountSettingsScreen());
                },
                icon: const Icon(
                  Icons.settings,
                  size: 30,
                ),
              ),
              IconButton(
              onPressed: ()
                {
                  FirebaseAuth.instance.signOut();
                },
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                ),
            ],
          ) : Container()
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [

              //image slider
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Carousel(
                    indicatorBarColor: Colors.black.withOpacity(0.3),
                    autoScrollDuration: const Duration(seconds: 2),
                    animationPageDuration: const Duration(milliseconds: 500),
                    activateIndicatorColor: Colors.black,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: 30,
                    indicatorHeight: 10,
                    indicatorWidth: 10,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.network(urlImage1, fit: BoxFit.cover),
                      Image.network(urlImage2, fit: BoxFit.cover),
                      Image.network(urlImage3, fit: BoxFit.cover),
                      Image.network(urlImage4, fit: BoxFit.cover),
                      Image.network(urlImage5, fit: BoxFit.cover),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10.0),

              //Use information title
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Personal info:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              //User information table data
              Container(
                padding: const EdgeInsets.all(32.0),
                child: Table(
                  children: [

                    //Name
                    TableRow(
                      children: [
                        const Text(
                          "Name:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )

                        )
                        
                      ]
                    ),

                    //Extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text("")
                      ]
                    ),

                    //City
                    TableRow(
                        children: [
                          const Text(
                            "City:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                              city,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              )

                          )

                        ]
                    ),

                    //Extra row
                    const TableRow(
                        children: [
                          Text(""),
                          Text("")
                        ]
                    ),

                    //City
                    TableRow(
                        children: [
                          const Text(
                            "Phone no:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                              phone,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              )

                          )

                        ]
                    ),

                    //Extra row
                    const TableRow(
                        children: [
                          Text(""),
                          Text("")
                        ]
                    ),

                    //Email
                    TableRow(
                        children: [
                          const Text(
                            "Email:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                              email,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              )
                          )
                        ]
                    ),

                    //Extra row
                    const TableRow(
                        children: [
                          Text(""),
                          Text("")
                        ]
                    ),

                    //Profession
                    TableRow(
                        children: [
                          const Text(
                            "Profession:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                              profession,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              )
                          )
                        ]
                    ),

                    //Extra row
                    const TableRow(
                        children: [
                          Text(""),
                          Text("")
                        ]
                    ),

                    // TableRow(
                    //     children: [
                    //       const Text(
                    //         "Interests:",
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 18,
                    //         ),
                    //       ),
                    //
                    //       Text(
                    //           interests,
                    //           style: const TextStyle(
                    //             color: Colors.grey,
                    //             fontSize: 18,
                    //           )
                    //       )
                    //     ]
                    // ),
                    //
                    // //Extra row
                    // const TableRow(
                    //     children: [
                    //       Text(""),
                    //       Text("")
                    //     ]
                    // ),


                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
