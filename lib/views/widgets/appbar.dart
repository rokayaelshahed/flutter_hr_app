import 'package:flutter/material.dart';

import '../../constant/app_color.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
         Text(
          title,
          style: TextStyle(
            color: Color(0xFF202020),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 6),
        IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.chevron_right_rounded, color: Color(0xFF202020)),),
      ],
    );

  }
}