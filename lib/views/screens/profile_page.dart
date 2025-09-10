import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Icon
                const SizedBox(height: 50),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF202020),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 50),

                // Personal Information Section
                _SectionCard(
                  title: 'معلومات شخصية',
                  children: [
                    _ReadOnlyField(label: 'الاسم', value: 'الاسم'),
                    _ReadOnlyField(label: 'رقم الهاتف', value: 'رقم الهاتف'),
                    _ReadOnlyField(label: 'البريد الإلكتروني', value: 'البريد الإلكتروني'),
                  ],
                ),

                const SizedBox(height: 20),

                // Job Information Section
                _SectionCard(
                  title: 'بيانات وظيفية',
                  children: [
                    _ReadOnlyField(label: 'الرقم الوظيفي', value: 'الرقم الوظيفي'),
                    _ReadOnlyField(label: 'الوظيفة', value: 'الوظيفة'),
                    _ReadOnlyField(label: 'القسم', value: 'القسم'),
                    _ReadOnlyField(label: 'المدير المباشر', value: 'المدير المباشر'),
                    _ReadOnlyField(label: 'نوع التوظيف', value: 'نوع التوظيف'),
                    _ReadOnlyField(label: 'الحالة الوظيفية', value: 'الحالة الوظيفية'),
                    _ReadOnlyField(label: 'تاريخ التعيين', value: 'تاريخ التعيين'),
                    _ReadOnlyField(label: 'نوع العقد', value: 'نوع العقد'),
                    _ReadOnlyField(label: 'تاريخ انتهاء العقد', value: 'تاريخ انتهاء العقد'),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),

    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDEDED)),
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
          // Section Title
          Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF202020),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),

          // Fields
          ...children,
        ],
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;

  const _ReadOnlyField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Value (expanded to take most space)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEDEDED)),
              ),
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFF202020),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Label (fixed width, right-aligned)
          SizedBox(
            width: 100,
            child: Text(
              label,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF202020),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

