import 'package:dating_app/authenticationScreen/interests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_text_field_widget.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  @override
  State<Appearance> createState() => _LifestyleState();
}

class _LifestyleState extends State<Appearance> {

  //Apperance
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

  //Life Syle
  TextEditingController martialStatusTextEditingController = TextEditingController();
  TextEditingController incomeTextEditingController = TextEditingController();
  TextEditingController livingSituationTextEditingController = TextEditingController();
  TextEditingController smokingHabitsTextEditingController = TextEditingController();
  TextEditingController drinkingHabitsTextEditingController = TextEditingController();

  //Background-Cultural values
  TextEditingController religionTextEditingController = TextEditingController();
  TextEditingController educationLevelEditingController = TextEditingController();
  TextEditingController languagesSpokenTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Center(
                  child: Column(
                      children: [

                        const SizedBox(
                          height: 15,
                        ),

                        const Text(
                          "Appearance",
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),
      
                        Image.asset(
                          "images/v.png",
                          width: 200,
                        ),
      
                        const SizedBox(
                          height: 70,
                        ),
      
                          //height
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 36 ,
                            height: 55,
                            child: CustomTextFieldWidget(
                              editingController: heightTextEditingController,
                              labelText: "Height",
                              iconData: Icons.height_outlined,
                              isObscure: false,
                            ),
                          ),
      
      
      
                        const SizedBox(
                          height: 20,
                        ),
      
                        //weight
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 36 ,
                          height: 55,
                          child: CustomTextFieldWidget(
                            editingController: weightTextEditingController,
                            labelText: "Weight",
                            iconData: Icons.scale_outlined,
                            isObscure: false,
                          ),
                        ),
      
                        const SizedBox(
                          height: 20,
                        ),
      
                        //body type
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 36 ,
                          height: 55,
                          child: CustomTextFieldWidget(
                            editingController: bodyTypeTextEditingController,
                            labelText: "Body Type",
                            iconData: Icons.type_specimen,
                            isObscure: false,
                          ),
                        ),
      
                        const SizedBox(
                          height: 20,
                        ),

                        //Life style
                        const Text(
                          "Life Style",
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //maritial status
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 36 ,
                          height: 55,
                          child: CustomTextFieldWidget(
                            editingController: martialStatusTextEditingController,
                            labelText: "Body Type",
                            iconData: Icons.accessibility_new_outlined,
                            isObscure: false,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //income
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 36 ,
                          height: 55,
                          child: CustomTextFieldWidget(
                            editingController: incomeTextEditingController,
                            labelText: "Body Type",
                            iconData: Icons.money,
                            isObscure: false,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
      
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
                            onTap: ()
                            {
                                Get.to(const Interests());
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
                      ]
                  )
              )
          )
      ),
    );
  }
}