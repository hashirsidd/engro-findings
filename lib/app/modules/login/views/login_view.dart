import 'package:Findings/app/custom_widgets/widgets/underline_text_field.dart';
import 'package:Findings/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.23),
                    child: Image.asset('assets/engro.png', height: 80),
                  ),
                  const SizedBox(height: 20),
                  UnderlineTextField(
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textController: controller.emailController,
                    isPassword: false.obs,
                  ),
                  const SizedBox(height: 10),
                  UnderlineTextField(
                    labelText: 'Password',
                    textController: controller.passwordController,
                    isPassword: true.obs,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap:()=> controller.onTapForgotPassword(context),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Forgot Password',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.onPressLogin,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
