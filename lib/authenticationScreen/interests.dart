import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_text_field_widget.dart';

class Interests extends StatefulWidget {
  const Interests({super.key});

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {

  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                Get.to(Interests());
                              },
                              child: const Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 16,
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


                        const Text(
                          "Interests",
                          style: TextStyle(
                            fontSize: 27,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        Image.asset(
                          "images/v.png",
                          width: 150,
                        ),

                        const SizedBox(
                          height: 70,
                        ),

                        //name
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

                        //name
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

                        //name
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
                              Get.to(Interests());
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