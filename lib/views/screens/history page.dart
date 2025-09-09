import 'package:flutter/material.dart';
import 'package:hr/views/widgets/appbar.dart';

import '../widgets/historyItem.dart';
import 'home_checkIn_page.dart';

class AttendanceHistoryPage extends StatelessWidget {
  const AttendanceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _TopCard(),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Icon(Icons.filter_alt, color: Color(0xFF1F1F1F)),
                    Spacer(),
                    const SectionTitle(title: 'السجل'),

                  ],
                ),
                const SizedBox(height: 8),
                const _MonthLabel(text: '2025 أغسطس'),
                const SizedBox(height: 8),
                const HistoryItem(
                  title: 'تم تسجيل الحضور في التاسعة صباحا',
                  dayTitle: 'الخميس',
                  dayNumber: '1',
                  month: 'أغسطس',
                ),
                const SizedBox(height: 10),
                const _MonthLabel(text: '2025 يوليو'),
                const SizedBox(height: 8),
                const HistoryItem(
                  title: 'تم تسجيل الإنصراف في الخامسة مساء',
                  dayTitle: 'الأربعاء',
                  dayNumber: '31',
                  month: 'يوليو',
                ),
                const SizedBox(height: 10),
                const HistoryItem(
                  title: 'تم تسجيل الحضور في التاسعة صباحا',
                  dayTitle: 'الأربعاء',
                  dayNumber: '31',
                  month: 'يوليو',
                ),
                const SizedBox(height: 10),
                const HistoryItem(
                  title: 'تم تسجيل الإنصراف في الخامسة صباحا',
                  dayTitle: 'الثلاثاء',
                  dayNumber: '30',
                  month: 'يوليو',
                ),
                const SizedBox(height: 10),
                const HistoryItem(
                  title: 'تم تسجيل الحضور في التاسعة صباحا',
                  dayTitle: 'الثلاثاء',
                  dayNumber: '30',
                  month: 'يوليو',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

    );
  }
}

class _TopCard extends StatelessWidget {
  const _TopCard();
//pass time and button text as parameters
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 18),
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
        children: [
          CustomAppBar(title:'الحضور والانصراف')
        ,
          const SizedBox(height: 22),
          const Text(
            '5 : 00 PM',
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 46,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'تم تسجيل الإنصراف',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthLabel extends StatelessWidget {
  final String text;
  const _MonthLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF9E9E9E),
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

