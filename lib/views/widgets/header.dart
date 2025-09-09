import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/app_color.dart';

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        children: [
          Row(
            children: [
              // Left side (Notifications + Calendar)
              Row(
                children: const [
                  Icon(Icons.notifications_none_rounded, color: Colors.white, size: 22),
                  SizedBox(width: 12),
                  Icon(Icons.calendar_today_outlined, color: Colors.white, size: 18),
                ],
              ),

              const Spacer(),

              //  Right side (Name + Job + Avatar)
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'الإسم',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'الوظيفة',
                        style: TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 18, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}