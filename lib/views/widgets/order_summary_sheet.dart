import 'package:flutter/material.dart';

import 'order_card.dart';

class OrderSummarySheet extends StatelessWidget {
  final String customer;
  final String product;
  final int quantity;
  final double unitPrice;
  final double linePrice;
  final DateTime orderDate;

  //  status chip
  final String statusText;
  final Color statusColor;
  final VoidCallback? onDelete;


  const OrderSummarySheet({
    super.key,
    required this.customer,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.linePrice,
    required this.orderDate,
    this.statusText = 'إزالة',
    this.statusColor = const Color(0xFFE53935),
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // grab-handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'ملخص الطلب',
                  style: const TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEDEDED)),
                ),
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: Column(
                  children: [
                    // header row
                    Row(
                      children: const [
                        Expanded(
                          child: _HeaderCell(text: 'الحالة'),
                        ),
                        Expanded(
                          child: _HeaderCell(text: 'الإجمالي'),
                        ),
                        Expanded(
                          child: _HeaderCell(text: 'السعر'),
                        ),
                        Expanded(
                          child: _HeaderCell(text: 'الكمية'),
                        ),
                        Expanded(
                          child: _HeaderCell(text: 'المنتج'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // values row
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(onTap: onDelete,
                                borderRadius: BorderRadius.circular(8),
                                child: StatusChip(text: statusText, color: statusColor)),
                          ),
                        ),
                        Expanded(
                          child: _ValueCell(text: '${linePrice.toStringAsFixed(0)} \$'),
                        ),
                        Expanded(
                          child: _ValueCell(text: '${unitPrice.toStringAsFixed(0)} \$'),
                        ),
                        Expanded(
                          child: _ValueCell(text: quantity.toString()),
                        ),
                        Expanded(
                          child: _ValueCell(text: product),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: Color(0xFFEDEDED)),
                    const SizedBox(height: 8),

                    // totals block (can be extended if needed)
                    Row(
                      children: [
                        Text(
                          '${linePrice.toStringAsFixed(0)} \$',
                          style: const TextStyle(
                            color: Color(0xFF1F1F1F),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'الإجمالي',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF6B6B6B),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Create order
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F1F1F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // TODO: call create-order API
                    Navigator.of(context).maybePop();
                  },
                  child: const Text(
                    'إنشاء الطلب',
                    style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Cancel
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1F1F1F)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text(
                    'إلغاء',
                    style: TextStyle(color: Color(0xFF1F1F1F), fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ValueCell extends StatelessWidget {
  final String text;
  final bool alignRight;
  const _ValueCell({required this.text, this.alignRight = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignRight ? TextAlign.right : TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF1F1F1F),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String text;
  final Color color;
  const _StatusChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}