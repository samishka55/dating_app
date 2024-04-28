import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../authenticationScreen/appearance.dart';
import '../widgets/custom_text_field_widget.dart';


class AccountSettingsScreen extends StatefulWidget
{
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen>
{

  bool uploading = false, next = false;
  final List<File> _image = [];
  List<String> urlsList = [];
  double val = 0;

  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController professionTextEditingController = TextEditingController();

  String name = '';
  String username = '';
  String email = '';
  String city = '';
  String phone = '';
  String profession = '';

  chooseImage() async
  {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }

  uploadImages() async
  {
    int i = 1;

    for(var img in _image)
    {
      setState(() {
        val = i / _image.length;
      });

      var refImages = FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");

      await refImages.putFile(img)
          .whenComplete(() async
      {
        await refImages.getDownloadURL()
            .then((urlImage)

        {
          urlsList.add(urlImage);
          i++;
        });
      });
    }
  }

  retrieveUserData() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get().then((snapshot)
    {
      if(snapshot.exists)
      {
        setState(() {
          name = snapshot.data()!["name"];
          username = snapshot.data()!["username"];
          email = snapshot.data()!["email"];
          city = snapshot.data()!["city"];
          phone = snapshot.data()!["phone"];
          profession = snapshot.data()!["profession"];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserData();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Profile Information" : "Choose 5 Images",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          next
              ? Container()
              : IconButton(
                    onPressed: ()
                    {
                      showDialog(
                          context: context,
                          builder: (context)
                          {
                    return const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Uploading images..."),
                                ],
                              )
                          );
                        }
                    );
                    uploadImages();
                    },
                icon: const Icon(Icons.navigate_next_outlined, size: 36,
                ),
          )
        ],
      ),
      body: next ?
      const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(
                height: 10,
              ),

              //name
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

              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ) :
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: GridView.builder(
                itemCount: _image.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index)
                {
                  return index == 0
                      ? Container(
                          color: Colors.white30,
                          child: Center(
                            child: IconButton(
                              onPressed: ()
                              {
                                !uploading ? chooseImage() : null;
                              },
                              icon: const Icon(Icons.add),
                      ),
                    ),
                  )
                      : Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                              _image[index - 1]
                          ),
                          fit: BoxFit.cover,
                        )
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}







// class AccountSettingsScreen extends StatefulWidget {
//   const AccountSettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
// }
//
// class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
//   List<String> list = <String>['One', 'Two', 'Three', 'Four', 'Five'];
//   List<String> dropdownValues = [];
//
//   @override
//   void initState() {
//     super.initState();
//     dropdownValues = List.generate(list.length, (index) => list.first);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dropdown Menu Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             for (int i = 0; i < list.length; i++)
//               DropdownButton<String>(
//                 value: dropdownValues[i],
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     dropdownValues[i] = newValue!;
//                   });
//                 },
//                 items: list.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Example of how to access selected values
//                 for (int i = 0; i < list.length; i++) {
//                   print('Selected value $i: ${dropdownValues[i]}');
//                 }
//               },
//               child: Text('Print Selected Values'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(const MaterialApp(
//     home: AccountSettingsScreen(),
//   ));
// }


// /// Flutter code sample for [Radio].
//
//
// class AccountSettingsScreen extends StatelessWidget {
//   const AccountSettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Radio Sample')),
//         body: const Center(
//           child: RadioExample(),
//         ),
//       ),
//     );
//   }
// }
//
// enum SingingCharacter { lafayette, jefferson, samishka }
//
// class RadioExample extends StatefulWidget {
//   const RadioExample({super.key});
//
//   @override
//   State<RadioExample> createState() => _RadioExampleState();
// }
//
// class _RadioExampleState extends State<RadioExample> {
//   SingingCharacter? _character = SingingCharacter.lafayette;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         ListTile(
//           title: const Text('Lafayette'),
//           leading: Radio<SingingCharacter>(
//             value: SingingCharacter.lafayette,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value;
//               });
//             },
//           ),
//         ),
//         ListTile(
//           title: const Text('Thomas Jefferson'),
//           leading: Radio<SingingCharacter>(
//             value: SingingCharacter.jefferson,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value;
//               });
//             },
//           ),
//         ),
//         ListTile(
//           title: const Text('Samishka'),
//           leading: Radio<SingingCharacter>(
//             value: SingingCharacter.samishka,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }



// //CheckBox
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AccountSettingsScreen(),
//     );
//   }
// }
//
// class AccountSettingsScreen extends StatefulWidget {
//   @override
//   _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
// }
//
// class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
//   List<String> selectedItems = [];
//
//   List<String> items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Multi Selection Demo'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (BuildContext context, int index) {
//           final String item = items[index];
//           return CheckboxListTile(
//             title: Text(item),
//             value: selectedItems.contains(item),
//             onChanged: (bool ? value) {
//               setState(() {
//                 if (value != null) {
//                   if (value) {
//                     selectedItems.add(item);
//                   } else {
//                     selectedItems.remove(item);
//                   }
//                 }
//               });
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Do something with selected items
//           print(selectedItems);
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }



