import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_text_field.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../custom_widgets/widgets/drop_down.dart';
import '../controllers/create_users_controller.dart';

class CreateUsersView extends GetView<CreateUsersController> {
  const CreateUsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> areaList = [
      'PM&S',
      'URUT-I',
      'UREA-II',
      'URUT-III',
      'AMM-II',
      'AMM-III',
      'Workshop'
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'CREATE USERS',
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  FindingsTextField(
                    textEditingController: controller.usernameController,
                    title: 'Name',
                    hint: 'Employee Name',
                    maxLines: 1,
                    nextFocus: controller.emailFocus,
                  ),
                  FindingsTextField(
                    textEditingController: controller.userEmailController,
                    title: 'Email',
                    hint: 'Employee Email',
                    maxLines: 1,
                    nextFocus: controller.passwordFocus,
                    currentFocus: controller.emailFocus,
                  ),
                  FindingsTextField(
                    textEditingController: controller.userPasswordController,
                    title: 'Password',
                    hint: 'Password',
                    nextFocus: controller.passwordAgainFocus,
                    currentFocus: controller.passwordFocus,
                    maxLines: 1,
                  ),
                  FindingsTextField(
                    textEditingController:
                        controller.userPasswordAgainController,
                    title: 'Password',
                    hint: 'Password',
                    nextFocus: controller.codeFocus,
                    currentFocus: controller.passwordAgainFocus,
                    maxLines: 1,
                  ),
                  FindingsTextField(
                    textEditingController: controller.employeeCodeController,
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
                  Spacing.vStandard,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Admin",
                        style: TextStyle(fontSize: 18),
                      ),
                      Obx(() => Switch(
                        value: controller.isAdmin.value,
                        activeColor: Colors.green,
                        onChanged: (bool value) {
                          controller.isAdmin.value = value;
                        },
                      )),
                    ],
                  ),

                ]),
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
                  onPressed: controller.onPressCreateUser,
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
