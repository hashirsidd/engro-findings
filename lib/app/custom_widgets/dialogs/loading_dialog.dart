import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/underline_text_field.dart';

class LoadingDialog extends StatelessWidget {

  const LoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: const Align(
          child: SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ));
  }
}
