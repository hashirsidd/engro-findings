import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/custom_widgets/widgets/drop_down.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_text_field.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> areaList = [
      'PM&S',
      'URUT-I',
      'UREA-II',
      'URUT-III',
      'AMM-II',
      'AMM-III'
    ];
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PROFILE',
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                border:
                                    Border.all(color: Colors.black12, width: 2)),
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 7.0,
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1600',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 7.0,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.grey,
                                )),
                          )
                        ],
                      ),
                    ),
                    FindingsTextField(
                      textEditingController: controller.usernameController,
                      title: 'Name',
                      hint: 'Name',
                      maxLines: 1,
                      nextFocus: controller.emailFocus,
                    ),
                    FindingsTextField(
                      textEditingController: controller.usernameController,
                      title: 'Email',
                      hint: 'Email',
                      maxLines: 1,
                      nextFocus: controller.codeFocus,
                      currentFocus: controller.emailFocus,
                    ),
                    FindingsTextField(
                      textEditingController: controller.usernameController,
                      title: 'Code',
                      hint: 'Employee Code',
                      maxLines: 1,
                      currentFocus: controller.codeFocus,
                    ),
                    DropDown(
                      dropDownList: areaList,
                      value: controller.area,
                      hint: 'Select area',
                      title: 'Area',
                    ),
                    Spacing.vLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Notifications",
                          style: TextStyle(fontSize: 18),
                        ),
                        Obx(() => Switch(
                              value: controller.allowNotification.value,
                              activeColor: Colors.green,
                              onChanged: (bool value) {
                                controller.allowNotification.value = value;
                              },
                            )),
                      ],
                    ),

                  ]),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom < 50)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(bottom: 30),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.onPressSave,
                  style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    'Create User',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
