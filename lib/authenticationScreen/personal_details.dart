import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_text_field_widget.dart';
import 'package:dating_app/controllers/authentication_controllers.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key});

  @override
  State<PersonalDetails> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<PersonalDetails> {
  bool showProgressBar = false;

  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController professionTextEditingController = TextEditingController();
  //TextEditingController publishedDateTimeTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Choose image circle avatar
              AuthenticationController.authController.imageFile == null
                  ? const CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage("images/profile_avatar.png"),
                backgroundColor: Colors.black,
              )
                  : Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: FileImage(File(AuthenticationController.authController.imageFile!.path)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await AuthenticationController.authController.pickImageFileFromGallery();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () async {
                      await AuthenticationController.authController.captureImageFromCamera();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Name
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: nameTextEditingController,
                  labelText: "Name",
                  iconData: Icons.person_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Username
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: usernameTextEditingController,
                  labelText: "Username",
                  iconData: Icons.person_search_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Email
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: emailTextEditingController,
                  labelText: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // City
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: cityTextEditingController,
                  labelText: "City",
                  iconData: Icons.location_city_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Phone number
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: phoneTextEditingController,
                  labelText: "Phone Number",
                  iconData: Icons.phone_android_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Profession
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: professionTextEditingController,
                  labelText: "Profession",
                  iconData: Icons.work,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Password
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: passwordTextEditingController,
                  labelText: "Password",
                  iconData: Icons.lock_outline,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: InkWell(
                  onTap: () async {
                    if (AuthenticationController.authController.imageFile != null) {
                      if (nameTextEditingController.text.trim().isNotEmpty &&
                          usernameTextEditingController.text.trim().isNotEmpty &&
                          emailTextEditingController.text.trim().isNotEmpty &&
                          cityTextEditingController.text.trim().isNotEmpty &&
                          phoneTextEditingController.text.trim().isNotEmpty &&
                          professionTextEditingController.text.trim().isNotEmpty &&
                          passwordTextEditingController.text.trim().isNotEmpty) {

                        setState(() {
                          showProgressBar = true;
                        });

                        await AuthenticationController.authController.createNewUserAccount(
                          AuthenticationController.authController.profileImage!,
                          nameTextEditingController.text.trim(),
                          usernameTextEditingController.text.trim(),
                          emailTextEditingController.text.trim(),
                          cityTextEditingController.text.trim(),
                          phoneTextEditingController.text.trim(),
                          professionTextEditingController.text.trim(),
                          passwordTextEditingController.text.trim(),
                        );

                        setState(() {
                          showProgressBar = false;
                          AuthenticationController.authController.imageFile = null;
                        });



                      } else {
                        Get.snackbar("Some Empty field(s)", "Please fill out all fields");
                      }
                    } else {
                      Get.snackbar("Image file missing", "Please select image from gallery or capture with camera");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //if (showProgressBar) CircularProgressIndicator(), // Show progress indicator if showProgressBar is true
            ],
          ),
        ),
      ),
    );
  }
}
