// ignore_for_file: deprecated_member_use
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

class CustomTabbar extends StatelessWidget {
  final int initialValue;
  final Map<int, Widget> children;
  final ValueChanged<int> onValueChanged;

  const CustomTabbar({
    super.key,
    required this.initialValue,
    required this.children,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      fixedWidth: 90,
      height: 40,
      initialValue: initialValue,
      children: children,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 248, 248, 248),
        borderRadius: BorderRadius.circular(20),
      ),
      thumbDecoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color.fromARGB(255, 158, 192, 254), Color.fromARGB(255, 148, 164, 251)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: onValueChanged,
    );
  }
}
