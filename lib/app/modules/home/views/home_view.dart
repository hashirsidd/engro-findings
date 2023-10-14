import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PROFILE);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.green, width: 2)),
                        clipBehavior: Clip.hardEdge,
                        height: 40,
                        width: 40,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            clipBehavior: Clip.hardEdge,
                            height: 45,
                            width: 45,
                            child: Obx(
                              () => controller.user.value.profilePictureUrl == ""
                                  ? Image.asset(
                                      'assets/user.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      controller.user.value.profilePictureUrl!,
                                      fit: BoxFit.cover,
                                    ),
                            )),
                      ),
                    ),
                    Image.asset(
                      'assets/engro.png',
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: controller.logoutUser,
                      child: const Icon(
                        Icons.logout,
                        color: Colors.grey,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              Spacing.vSmall,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacing.vSmall,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Field Maintainance',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'KEY AREA FINDINGS',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 32),
                          ),
                          Text(
                            'Share your learning with us!',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Spacing.vExtraLarge,
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Spacing.vExtraLarge,
                              Expanded(
                                child: LiquidPullToRefresh(
                                  onRefresh: controller.getUserData,
                                  showChildOpacityTransition: false,
                                  color: Colors.transparent,backgroundColor: Colors.green,
                                    springAnimationDurationInMilliseconds: 500,
                                    animSpeedFactor:2,
                                  height: 100,
                                  child: GridView.count(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20, top: 50, bottom: 60),
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    crossAxisCount: MediaQuery.of(context).size.width > 550 ? 4 : 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    children: [
                                      HomeTabs(
                                        title: 'Overview\nDashboard',
                                        assetPath: 'assets/dashboard.png',
                                        onTap: () {
                                          Get.toNamed(Routes.DASHBOARD);
                                        },
                                      ),
                                      HomeTabs(
                                        title: 'File Your\nFindings',
                                        assetPath: 'assets/fileFindings.png',
                                        onTap: () {
                                          Get.toNamed(Routes.FILE_FINDINGS);
                                        },
                                      ),
                                      HomeTabs(
                                        title: 'Site Wide\nFindings',
                                        assetPath: 'assets/siteSearch.png',
                                        onTap: () {
                                          Get.toNamed(Routes.SEARCH_FINDINGS);
                                        },
                                      ),
                                      HomeTabs(
                                        title: 'Submitted\nFindings',
                                        assetPath: 'assets/yourFindings.png',
                                        onTap: () => Get.toNamed(Routes.SUBMITTED_FINDINGS),
                                      ),
                                      Obx(
                                        () => controller.user.value.isAdmin
                                            ? HomeTabs(
                                                title: 'Create\nUsers',
                                                assetPath: 'assets/addUser.png',
                                                onTap: () => Get.toNamed(Routes.CREATE_USERS),
                                              )
                                            : const SizedBox(),
                                      ),
                                      Obx(
                                        () => controller.user.value.isAdmin
                                            ? HomeTabs(
                                                title: 'Findings\nApproval',
                                                assetPath: 'assets/approvals.png',
                                                onTap: () => Get.toNamed(Routes.FINDINGS_APPROVAL),
                                              )
                                            : const SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.SEARCH_FINDINGS);
                              },
                              child: AbsorbPointer(
                                absorbing: true,
                                child: SearchBar(
                                  elevation: MaterialStateProperty.all(10),
                                  hintText: "Search findings",
                                  hintStyle: MaterialStateProperty.all<TextStyle>(
                                      const TextStyle(color: Colors.grey)),
                                  textStyle: MaterialStateProperty.all<TextStyle>(
                                      Theme.of(context).textTheme.bodyMedium!),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  trailing: [
                                    IconButton(
                                      icon: const FaIcon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () {
                                        // Perform search here
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTabs extends StatelessWidget {
  final String title;
  final String assetPath;
  final Function onTap;

  const HomeTabs({
    Key? key,
    required this.title,
    required this.assetPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/iconbg.png'),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w300),
            ),
            Row(
              children: [
                const Spacer(),
                Image.asset(
                  assetPath,
                  height: 60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
