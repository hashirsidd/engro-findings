import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitDialog extends StatelessWidget {
  final String title;
  final String description;
  final String rightButtonText;
  final String leftButtonText;
  final Function rightButtonOnTap;
  final Function leftButtonOnTap;
  final Widget titleWidget;
  final Color titleTextColor;
  final Icon titleIcon;

  const SubmitDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.rightButtonText,
    required this.leftButtonText,
    required this.rightButtonOnTap,
    required this.leftButtonOnTap,
    this.titleWidget = const SizedBox(),
    this.titleIcon = const Icon(Icons.check, color: Colors.green, size: 100),
    this.titleTextColor = Colors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromRGBO(250, 250, 250, 1)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Get.back(); // Close the dialog
                },
              ),
            ),
            titleIcon,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: titleTextColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => leftButtonOnTap(),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Text(leftButtonText, style: TextStyle(color: titleTextColor)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => rightButtonOnTap(),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: titleTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: Text(rightButtonText),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
