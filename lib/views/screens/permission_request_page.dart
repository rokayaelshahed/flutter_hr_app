import 'package:flutter/material.dart';
import '../../controllers/permission_request_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/form_widgets.dart';

class PermissionRequestPage extends StatefulWidget {
  const PermissionRequestPage({super.key});

  @override
  State<PermissionRequestPage> createState() => _PermissionRequestPageState();
}

class _PermissionRequestPageState extends State<PermissionRequestPage> {
  late final PermissionRequestController controller;

  @override
  void initState() {
    super.initState();
    controller = PermissionRequestController()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _Card(
                  padding: const EdgeInsets.fromLTRB(14, 16, 14, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomAppBar(title: 'طلب إذن خروج'),
                      const SizedBox(height: 16),
                      RightLabelField(
                        label: 'التاريخ',
                        child: FieldShell(
                          child: InkWell(
                            onTap: () => controller.pickDate(context),
                            child: Row(
                              children: [
                                const IconBox(icon: Icons.calendar_today_rounded),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.right,
                                    controller.dateText.isEmpty ? 'اختر التاريخ' : controller.dateText,
                                    style: TextStyle(
                                      color: controller.dateText.isEmpty ? const Color(0xFF9E9E9E) : const Color(0xFF6B6B6B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      RightLabelField(
                        label: 'الوقت',
                        child: Row(
                          children: [
                            Expanded(
                              child: _PillField(

                                text: controller.fromTimeText.isEmpty ? '00 : 00 AM' : controller.fromTimeText,
                                onTap: () => controller.pickTime(context, isFrom: true),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const _SeparatorLabel(text: 'إلى'),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _PillField(
                                text: controller.toTimeText.isEmpty ? '00 : 00 AM' : controller.toTimeText,
                                onTap: () => controller.pickTime(context, isFrom: false),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 48,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Colors.black,
                            disabledBackgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          onPressed: controller.isValid ? controller.submit : null,
                          child: const Text('تقديم الطلب', style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class _Card extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  const _Card({required this.padding, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}

class _SeparatorLabel extends StatelessWidget {
  final String text;
  const _SeparatorLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Color(0xFF6B6B6B), fontSize: 12.5, fontWeight: FontWeight.w700));
  }
}

class _PillField extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _PillField({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFEDEDED)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: const TextStyle(color: Color(0xFF6B6B6B), fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}