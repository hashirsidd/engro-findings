import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnderlineTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController textController;
  final RxBool isPassword;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final RxBool showPassword = true.obs;

  UnderlineTextField({
    Key? key,
    required this.labelText,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    required this.isPassword,
  }) {
    if (isPassword.value) {
      showPassword.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Obx(
        () => TextField(
          onChanged: onChanged,
          controller: textController,
          obscureText: !showPassword.value,
          // Observe the RxBool for password visibility
          keyboardType: keyboardType,
          autocorrect: false,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.green),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            suffixIcon: isPassword.value
                ? IconButton(
                    icon: Icon(
                      showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      if (isPassword.value) {
                        showPassword
                            .toggle(); // Toggle the RxBool to show/hide password
                      }
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
