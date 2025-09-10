import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  const IconBox({required this.icon});

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


class RightLabelField extends StatelessWidget {
  final String label;
  final Widget child;
  const RightLabelField({required this.label, required this.child});

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

class FieldShell extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const FieldShell({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  });

  const FieldShell.multiline({
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

class CardShell extends StatelessWidget {
  final Widget child;
  const CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 18),
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