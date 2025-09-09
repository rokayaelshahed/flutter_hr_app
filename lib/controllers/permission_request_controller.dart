import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PermissionRequestController extends ChangeNotifier {
  DateTime? date;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  final DateFormat _dateFmt = DateFormat('d / M / y');

  String get dateText => date == null ? '' : _dateFmt.format(date!);
  String get fromTimeText => _formatTime(fromTime);
  String get toTimeText => _formatTime(toTime);

  String _formatTime(TimeOfDay? t) {
    if (t == null) return '';
    final dt = DateTime(0, 1, 1, t.hour, t.minute);
    return DateFormat('h : mm a').format(dt);
  }

  Future<void> pickDate(BuildContext context) async {
    final initial = date ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(DateTime.now().year - 2),
      lastDate: DateTime(DateTime.now().year + 3),
      locale: const Locale('ar'),
      builder: (context, child) {
        final theme = Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF1F1F1F),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xFF1F1F1F),
          ),
          dialogBackgroundColor: Colors.white,
        );
        return Theme(data: theme,
        child: child!);
      },
    );
    if (picked != null) {
      date = picked;
      notifyListeners();
    }
  }

  Future<void> pickTime(BuildContext context, {required bool isFrom}) async {
    final base = isFrom ? fromTime : toTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: base ?? TimeOfDay.now(),
      builder: (context, child) {
        final theme = Theme.of(context).copyWith(

          colorScheme: const ColorScheme.light(

            primary: Color(0xFF1F1F1F),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xFF1F1F1F),
          ),
        );
        return Theme(data: theme, child:  child!);
      },
    );
    if (picked != null) {
      if (isFrom) {
        fromTime = picked;
      } else {
        toTime = picked;
      }
      notifyListeners();
    }
  }

  void submit() {
    // Handle the submission logic here
    print('Permission Request Submitted:');
    print('Date: $dateText');
    print('From Time: $fromTimeText');
    print('To Time: $toTimeText');
  }
  bool get isValid => date != null && fromTime != null && toTime != null;
}