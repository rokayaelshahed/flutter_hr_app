import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
   final bool enabled;

  const NumberField({
    super.key,
    required this.controller,  this.enabled = true,
  });

  void _increment() {
    final currentValue = int.tryParse(controller.text) ?? 0;
    controller.text = (currentValue + 1).toString();
  }

  void _decrement() {
    final currentValue = int.tryParse(controller.text) ?? 0;
    if (currentValue > 1) {
      controller.text = (currentValue - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          // Left side arrows
          SizedBox(width: 22,),
          if (enabled)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _increment,
                  child: const Icon(Icons.arrow_drop_up, size: 20),
                ),
                GestureDetector(
                  onTap: _decrement,
                  child: const Icon(   Icons.arrow_drop_down,
                       size: 20),
                ),
              ],
            ),

          // Expanded number field
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              enabled: enabled,
              textAlign: TextAlign.right, // number aligned to right
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              style: TextStyle(
                fontSize: 16,
                color: enabled ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
