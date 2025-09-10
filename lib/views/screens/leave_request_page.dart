import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hr/views/widgets/appbar.dart';

import '../widgets/form_widgets.dart';

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
                  RightLabelField(
                    label: 'نوع الإجازة',
                    child: FieldShell(
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
                            .map((e) => DropdownMenuItem(
                            value: e,
                            alignment: AlignmentDirectional.centerStart,
                            child: Align(alignment: Alignment.centerRight, child: Text(e))
                        )
                        )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedLeaveType = v),
                        validator: (v) => v == null ? 'يرجى اختيار نوع الإجازة' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  //  (Date picker) start date
                  RightLabelField(
                    label: 'تاريخ البدء',
                    child: FieldShell(
                      child: InkWell(
                        onTap: () => _pickDate(isStart: true),
                        child: Row(
                          children: [
                            IconBox(icon: Icons.calendar_today_rounded),
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
                  RightLabelField(
                    label: 'تاريخ الإنتهاء',
                    child: FieldShell(
                      child: InkWell(
                        onTap: () => _pickDate(isStart: false),
                        child: Row(
                          children: [
                            IconBox(icon: Icons.calendar_today_rounded),
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
                  RightLabelField(
                    label: 'الوصف',
                    child: FieldShell.multiline(
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
                  RightLabelField(
                    label: 'المرفقات (اختياري)',
                    child: FieldShell(
                      child: InkWell(
                        onTap: _pickFile,
                        child: Row(
                          children: [
                            const IconBox(icon: Icons.file_upload_outlined),
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


