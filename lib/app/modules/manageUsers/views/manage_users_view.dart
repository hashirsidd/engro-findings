import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../custom_widgets/widgets/appBar.dart';
import '../controllers/manage_users_controller.dart';

class ManageUsersView extends GetView<ManageUsersController> {
  ManageUsersView({Key? key}) : super(key: key);
  @override
  final ManageUsersController controller = Get.put(ManageUsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'MANAGE USERS',
      ),
      body: Obx(()=>ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int i) {
          UserModel user = controller.usersList[i];
          return user.uid != controller.homeController.user.value.uid? Container(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: user.profilePictureUrl != ''
                              ? CachedNetworkImage(
                                  imageUrl: user.profilePictureUrl,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/user.png',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Spacing.hStandard,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    user.name,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  )),
                                  const Text('Area : '),
                                  Text(user.area,
                                      style: const TextStyle(fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Spacing.vSmall,
                              Text(
                                user.email,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacing.vStandard,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Admin'),
                        Switch(
                          value: user.isAdmin,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            controller.changeUserAdminStatus(i);
                          },
                        )
                      ],
                    ),
                    Spacing.vStandard,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Block User'),
                        Switch(
                          value: !user.isLoginAllowed,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            controller.changeUserBlockStatus(i);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ):SizedBox();
        },
        itemCount: controller.usersList.length,
      )),
    );
  }
}
