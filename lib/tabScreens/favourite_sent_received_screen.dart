import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteSentReceivedScreen extends StatefulWidget {
  const FavouriteSentReceivedScreen({super.key});

  @override
  State<FavouriteSentReceivedScreen> createState() => _FavouriteSentReceivedScreenState();
}

class _FavouriteSentReceivedScreenState extends State<FavouriteSentReceivedScreen>
{

  bool isFavouriteSentClicked = true;
  List<String> favouriteSentList = [];
  List<String> favouriteReceivedList = [];
  List favouritesList = [];

  getFavouriteListKeys() async
  {
    if(isFavouriteSentClicked)
    {
      var favouriteSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("favouriteSent")
          .get();

      for(int i=0; i<favouriteSentDocument.docs.length; i++)
      {
        favouriteSentList.add(favouriteSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favouriteSentList);

    }
    else
    {
      var favouriteReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("favouriteReceived")
          .get();

      for(int i=0; i<favouriteReceivedDocument.docs.length; i++)
      {
        favouriteReceivedList.add(favouriteReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favouriteReceivedList);

    }

  }

  getKeysDataFromUsersCollection(List<String> keysList) async
  {
    var allUsersDocument = await FirebaseFirestore.instance.collection("users").get();

    for(int i=0; i<allUsersDocument.docs.length; i++)
    {
      for(int k=0; k<keysList.length; k++)
      {
        if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k])
        {
          favouritesList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      favouritesList;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFavouriteListKeys();

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: ()
              {
                favouriteSentList.clear();
                favouriteSentList = [];
                favouriteReceivedList.clear();
                favouriteReceivedList = [];
                favouritesList.clear();
                favouritesList = [];

                setState(() {
                  isFavouriteSentClicked = true;
                });
                getFavouriteListKeys();
              },
              child: Text(
                "My Favourites",
                style: TextStyle(
                  color: isFavouriteSentClicked ? Colors.white : Colors.grey,
                  fontWeight: isFavouriteSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14
                ),
              ),
            ),

            const Text(
              "   |   ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            TextButton(
              onPressed: ()
              {
                favouriteSentList.clear();
                favouriteSentList = [];
                favouriteReceivedList.clear();
                favouriteReceivedList = [];
                favouritesList.clear();
                favouritesList = [];

                setState(() {
                  isFavouriteSentClicked = false;
                });
                getFavouriteListKeys();
              },
              child: Text(
                "I'm their Favourite",
                style: TextStyle(
                    color: isFavouriteSentClicked ? Colors.grey : Colors.white,
                    fontWeight: isFavouriteSentClicked ? FontWeight.normal : FontWeight.bold,
                    fontSize: 14,
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: favouritesList.isEmpty ?
      const Center(
        child: Icon(
          Icons.person_off_sharp,
          color: Colors.white,
          size: 60,
        ),
      ):
          GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(8),
            children: List.generate(favouritesList.length, (index)
            {
              return GridTile(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    color: Colors.blue.shade200,
                    child: GestureDetector(
                      onTap: ()
                      {

                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(favouritesList[index]["imageProfile"],),
                            fit: BoxFit.cover,
                          )
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const Spacer(),

                                //name - profession
                                Text(
                                  favouritesList[index]["name"].toString() + " ⦿ " + favouritesList[index]["profession"].toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                //icon and country
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                      size: 12,
                                    ),

                                    Expanded(
                                      child: Text(
                                        favouritesList[index]["city"].toString(),
                                        maxLines: 2,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })
          )
    );
  }
}
