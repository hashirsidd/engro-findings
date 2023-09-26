import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';

class FindingsTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final int maxLines;
  final bool enabled;

  const FindingsTextField({
    Key? key,
    required this.textEditingController,
    required this.title,
    required this.hint,
    this.maxLines = 10,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          Spacing.vStandard,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 3.0,
                  ),
                ],
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              scrollPhysics: const BouncingScrollPhysics(),
              minLines: 1,
              maxLines: maxLines,
              enabled: enabled,
              controller: textEditingController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey),
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
