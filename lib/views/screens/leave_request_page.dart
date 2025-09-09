import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hr/views/widgets/appbar.dart';

class LeaveRequestFormPage extends StatefulWidget {
  const LeaveRequestFormPage({super.key});

  @override
  State<LeaveRequestFormPage> createState() => _LeaveRequestFormPageState();
}

class _LeaveRequestFormPageState extends State<LeaveRequestFormPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _leaveTypes = ['إجازة مرضية', 'إجازة سنوية', 'بدون راتب'];
  String? _selectedLeaveType;

  DateTime? _startDate;
  DateTime? _endDate;

  final TextEditingController _descController = TextEditingController();

  PlatformFile? _pickedFile;

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startDate : _endDate) ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 3),
      locale: const Locale('ar'),

      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: false,
      type: FileType.any,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() => _pickedFile = result.files.first);
    }
  }

  String _formatDate(DateTime? d) {
    if (d == null) return '';
    return '${d.day} / ${d.month} / ${d.year}';
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomAppBar(title: 'طلب إجازة'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE8E8E8)),
                    ),
                    child: Column(
                      children: const [
                        Icon(Icons.hourglass_top_rounded, size: 40, color: Color(0xFF1F1F1F)),
                        SizedBox(height: 8),
                        Text(
                          'الإجازات المتبقية لديك',
                          style: TextStyle(color: Color(0xFF4F4F4F), fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 6),
                        Text('  يوم\t11 ', style: TextStyle(color: Color(0xFF1F1F1F), fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // (Dropdown)
                  _RightLabelField(
                    label: 'نوع الإجازة',
                    child: _FieldShell(
                      child: DropdownButtonFormField<String>(
                        hint: const Text(
                          'اختر النوع',
                          style: TextStyle(color: Color(0xFF6B6B6B), fontWeight: FontWeight.w600 ,),
                        ),
                        isExpanded: true,
                        alignment: AlignmentDirectional.centerEnd,
                        value: _selectedLeaveType,
                        icon: const SizedBox.shrink(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 12),
                          prefixIcon : Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF6B6B6B),
                          ),
                        ),
                        items: _leaveTypes
                            .map((e) => DropdownMenuItem(value: e, child: Text(e,
                            textAlign: TextAlign.right)))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedLeaveType = v),
                        validator: (v) => v == null ? 'يرجى اختيار نوع الإجازة' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  //  (Date picker) start date
                  _RightLabelField(
                    label: 'تاريخ البدء',
                    child: _FieldShell(
                      child: InkWell(
                        onTap: () => _pickDate(isStart: true),
                        child: Row(
                          children: [
                            _IconBox(icon: Icons.calendar_today_rounded),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.right,

                                _startDate != null ? _formatDate(_startDate) : 'اختر التاريخ',
                                style: const TextStyle(color: Color(0xFF6B6B6B), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  //   (Date picker) end date
                  _RightLabelField(
                    label: 'تاريخ الإنتهاء',
                    child: _FieldShell(
                      child: InkWell(
                        onTap: () => _pickDate(isStart: false),
                        child: Row(
                          children: [
                            _IconBox(icon: Icons.calendar_today_rounded),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.right,

                                _endDate != null ? _formatDate(_endDate) : 'اختر التاريخ',
                                style: const TextStyle(color: Color(0xFF6B6B6B), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // desc (TextField)
                  _RightLabelField(
                    label: 'الوصف',
                    child: _FieldShell.multiline(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: _descController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'اكتب وصفًا',
                          border: InputBorder.none,
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'يرجى كتابة الوصف' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  //  (File picker) attachments
                  _RightLabelField(
                    label: 'المرفقات (اختياري)',
                    child: _FieldShell(
                      child: InkWell(
                        onTap: _pickFile,
                        child: Row(
                          children: [
                            const _IconBox(icon: Icons.file_upload_outlined),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.right,

                                _pickedFile?.name ?? 'قم برفع الملفات',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Color(0xFF6B6B6B), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Submit
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F1F1F),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Submit action here
                        }
                      },
                      child: const Text('تقديم الطلب', style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}

class _RightLabelField extends StatelessWidget {
  final String label;
  final Widget child;
  const _RightLabelField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
        const SizedBox(width: 12),
        SizedBox(
          width: 110,
          child: Text(
            label,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF4F4F4F),
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _FieldShell extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _FieldShell({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  });

  const _FieldShell.multiline({
    required this.child,
  }) : padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      padding: padding,
      child: child,
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  const _IconBox({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: const Color(0xFF1F1F1F)),
    );
  }
}