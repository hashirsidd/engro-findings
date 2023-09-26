import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DropDown extends StatelessWidget {
  final List<String> dropDownList;
  RxString value;
  final String hint;
  final String title;

  DropDown({
    Key? key,
    required this.dropDownList,
    required this.value,
    required this.hint,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Obx(() => DropdownButton(
                value: value.value == "" ? null : value.value,
                isExpanded: true,
                hint: Text(
                  hint,
                  style: const TextStyle(color: Colors.grey),
                ),
                underline: const SizedBox(),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: dropDownList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  if (newValue != null) value.value = newValue;
                },
              )),
        ),
      ],
    );
  }
}
