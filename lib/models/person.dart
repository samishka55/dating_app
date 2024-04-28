import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  //Personal info
  String? uid;
  String? imageProfile;
  String? name;
  String? username;
  String? email;
  String? city;
  String? phone;
  String? profession;
  String? password;
  //String? interests;


  Person({
    this.uid,
    this.imageProfile,
    this.name,
    this.username,
    this.email,
    this.city,
    this.phone,
    this.profession,
    this.password,
    //this.interests,
  });

  static Person fromdataSnapshot(DocumentSnapshot snapshot)
  {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return Person(
      uid: dataSnapshot["uid"],
      imageProfile: dataSnapshot["imageProfile"],
      name: dataSnapshot["name"],
      username: dataSnapshot["username"],
      email: dataSnapshot["email"],
      city: dataSnapshot["city"],
      phone: dataSnapshot["phone"],
      profession: dataSnapshot["profession"],
      password: dataSnapshot["password"],
      //interests: dataSnapshot["interests"]
    );

  }

  Map<String, dynamic> toJson()=>
      {
        "uid": uid,
        "imageProfile": imageProfile,
        "name": name,
        "username": username,
        "email": email,
        "city": city,
        "phone": phone,
        "profession": profession,
        "password": password,
        //"interests": interests,
      };

}