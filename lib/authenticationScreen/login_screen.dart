import 'package:dating_app/authenticationScreen/personal_details.dart';
import 'package:dating_app/controllers/authentication_controllers.dart';
import 'package:dating_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressbar = false;
  var controllerAuth = AuthenticationController();

  // google sign-in
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  // Future<void> _signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //       final UserCredential authResult = await _auth.signInWithCredential(credential);
  //       final User? user = authResult.user;
  //
  //       // Now you can handle the signed-in user as needed
  //       // For example, navigate to another screen after successful sign-in
  //       if (user != null) {
  //         // Navigate to the next screen or do any other operations
  //         // For example, you might want to navigate to the home screen:
  //         Navigator.pushReplacementNamed(context, '/home');
  //       }
  //     }
  //   } catch (error) {
  //     print('Google Sign-In Error: $error');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              const SizedBox(
                height: 120,
              ),

              Image.asset(
                "images/v.png",
                    width: 200,
              ),

              const SizedBox(
                height: 50,
              ),

              const Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),


              const Text(
                "Log in to find your best match",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //email
              SizedBox(
                width: MediaQuery.of(context).size.width - 36 ,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: emailTextEditingController,
                  labelText: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 15,
              ),


              //password
              SizedBox(
                width: MediaQuery.of(context).size.width - 36 ,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: passwordTextEditingController,
                  labelText: "Password",
                  iconData: Icons.lock_outline,
                  isObscure: true,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              //Login button
              Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),

                  )
                ),
                child: InkWell(
                  onTap: () async
                  {
                    if(emailTextEditingController.text.trim().isNotEmpty &&
                    passwordTextEditingController.text.trim().isNotEmpty)
                      {
                        setState(() {
                          showProgressbar = true;
                        });

                        await controllerAuth.loginUser
                          (
                            emailTextEditingController.text.trim(),
                            passwordTextEditingController.text.trim()
                        );

                        setState(() {
                          showProgressbar = false;
                        });


                      } else {
                    Get.snackbar("Email/Password is missing", "Please fill all fields");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // const SizedBox(
              //   height: 20,
              // ),
              //
              // // Google Sign-In button
              // ElevatedButton.icon(
              //   onPressed: _signInWithGoogle,
              //   icon: Icon(Icons.person),
              //   label: Text('Sign in with Google'),
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              //     foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              //     side: MaterialStateProperty.all<BorderSide>(
              //       BorderSide(color: Colors.red),
              //     ),
              //   ),
              // ),

              const SizedBox(
                height: 10,
              ),



              //Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                      "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(
                    width: 7,
                  ),

                  InkWell(
                    onTap: (){
                      //Get.put(AuthenticationController());
                      Get.to(const PersonalDetails());
                    },
                    child: const Text(
                        "Create Account",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              showProgressbar == true ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
              )
                  : Container()

            ],
          ),
        ),
      ),
    );
  }
}
