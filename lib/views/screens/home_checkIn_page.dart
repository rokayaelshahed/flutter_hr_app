import 'package:flutter/material.dart';
import '../widgets/header.dart';

import '../../constant/app_color.dart';
import '../widgets/historyItem.dart';
import '../widgets/order_card.dart';
import 'history page.dart';

class HomeCheckInPage extends StatefulWidget {
  const HomeCheckInPage({super.key});

  @override
  State<HomeCheckInPage> createState() => _HomeCheckInPageState();
}

class _HomeCheckInPageState extends State<HomeCheckInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _AttendanceCard(),
                    const SizedBox(height: 16),
                    const SectionTitle(title: 'السجل'),
                    const SizedBox(height: 8),
                    const HistoryItem(
                      title: 'تم تسجيل الدخول في التاسعة صباحا',
                      dayTitle: 'الخميس',
                      dayNumber: '1',
                      month: 'أغسطس',
                    ),
                    const SizedBox(height: 8),
                    _ShowMore(
                      text: 'عرض المزيد',
                      onTap: () {
                        //navigate to history page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AttendanceHistoryPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const SectionTitle(title: 'الطلبات'),
                    const SizedBox(height: 12),
                    const OrderCard(
                      product: 'اسم المنتج  ',
                      client: 'اسم العامل',
                      price: '100\$',
                      statusText: 'مكتمل',
                      statusColor: Color(0xFF18A957),
                    ),
                    const SizedBox(height: 12),
                    const OrderCard(
                      product: 'اسم المنتج  ',
                      client: 'اسم العميل',
                      price: '100\$',
                      statusText: 'قيد التنفيذ',
                      statusColor: Color(0xFFFFC107),
                    ),
                    const SizedBox(height: 8),
                    _ShowMore(text: 'عرض المزيد', onTap: () {}),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  const _AttendanceCard();
  //add var for time and text in button
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'الحضور والانصراف',
              style: TextStyle(
                color: Color(0xFF4F4F4F),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Align(
            alignment: Alignment.center,
            child: Text(
              '9 : 00 AM',
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(28),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white12,
                  child: Icon(
                    Icons.keyboard_double_arrow_left_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Handle swipe to check in action
                    },
                    child: const Text(
                      'اسحب لتسجيل الحضور',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 28),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2C2C2C),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ShowMore extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _ShowMore({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF2C2C2C),
            fontSize: 13,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFF2C2C2C),
          ),
        ),
      ),
    );
  }
}


