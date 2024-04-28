import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/authenticationScreen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dating_app/models/person.dart' as personModel;
import '../homeScreen/home_screen.dart';

class AuthenticationController extends GetxController
{

  static AuthenticationController authController = Get.find();

  late Rx<User?> firebaseCurrentUser;
  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  pickImageFileFromGallery() async
  {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(imageFile != null)
      {
        Get.snackbar("Profile Image", "You have successfully picked your image");
      }

    pickedFile = Rx<File?>(File(imageFile!.path));

  }

  captureImageFromCamera() async
  {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(imageFile != null)
    {
      Get.snackbar("Profile Image", "You have successfully captured your photo");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));


  }

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      // Get a reference to the storage location
      Reference referenceStorage = FirebaseStorage.instance
          .ref()
          .child("Profile Images")
          .child(FirebaseAuth.instance.currentUser!.uid);

      // Upload the file to storage
      TaskSnapshot snapshot = await referenceStorage.putFile(imageFile);

      // Get the download URL of the uploaded image
      String downloadUrlOfImage = await snapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadUrlOfImage;
    } catch (error) {
      // Handle any errors that occur during the upload process
      print("Error uploading image to storage: $error");
      // You may want to throw an exception here or return a default URL
      return ""; // Return an empty string for simplicity, handle it in the calling code
    }
  }

  createNewUserAccount
      (
      File imageProfile, String name,
      String username, String email,
      //String age,
      String city,
      String phone, String profession,
      String password,
      //String publishedDateTime
      ) async
  {
    try
    {
      //1.authenticate user and createUser With Email And Password
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password);

      //2.upload image to storage
      String urlOfDownloadedImage = await uploadImageToStorage(imageProfile);

      //3.save user info to firestore database
      personModel.Person personInstance = personModel.Person(

        uid: FirebaseAuth.instance.currentUser!.uid,
        imageProfile: urlOfDownloadedImage,
        name: name, username: username,
        email: email, //age: int.parse(age),
        city: city, phone: phone, profession: profession,
        password: password, //publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personInstance.toJson());
      
      Get.snackbar("Account Created!", "Congratulations, Your account created successfully!");
      Get.to(const HomeScreen());

    }
    catch(errorMsg)
    {
      Get.snackbar("Account creation unsuccessful", "Error occured: $errorMsg");
    }
  }

  loginUser(String emailUser, String passwordUser) async
  {
    try
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailUser,
        password: passwordUser
      );
      
      Get.snackbar("Login successful", "You are successfuly logged-in");
      Get.to(const HomeScreen());

    }
    catch(errorMsg)
    {
      Get.snackbar("Login unsuccessful", "Error occured: $errorMsg");
    }
  }

  checkIfUserLoggedIn(User? currentUser)
  {
    if(currentUser == null)
    {
      Get.offAll(const LoginScreen());
    }
    else
    {
      Get.offAll(const HomeScreen());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    
    ever(firebaseCurrentUser, checkIfUserLoggedIn);
  }

}