import 'package:flutter/material.dart';
import 'package:hr/models/orderData.dart';
import '../widgets/appbar.dart';
import '../widgets/order_summary_sheet.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderData order;


  const OrderDetailsPage({
     required this.order,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  children: [
                    const CustomAppBar(title: 'تفاصيل الطلب'),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'ملخص الطلب',
                        style: TextStyle(
                          color: Color(0xFF1F1F1F),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Order Summary Card
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
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
                          children: [
                            // Header Row
                            Row(
                              children: const [
                                Expanded(
                                  child: HeaderCell(text: 'الحالة'),
                                ),
                                Expanded(
                                  child: HeaderCell(text: 'الإجمالي'),
                                ),
                                Expanded(
                                  child: HeaderCell(text: 'السعر'),
                                ),
                                Expanded(
                                  child: HeaderCell(text: 'الكمية'),
                                ),
                                Expanded(
                                  child: HeaderCell(text: 'المنتج'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Product Details Row
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        //  Handle remove action
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('تم حذف المنتج من الطلب'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE53935),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          'إزالة',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ValueCell(text: order.total),
                                ),
                                Expanded(
                                  child: ValueCell(text: order.price),
                                ),
                                Expanded(
                                  child: ValueCell(text: order.quantity.toString()),
                                ),
                                Expanded(
                                  child: ValueCell(text: order.product, alignRight: true),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Color(0xFFEDEDED)),
                            const SizedBox(height: 12),

                            // Total Row
                            Row(
                              children: [
                                Text(
                                  order.total,
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
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Action Buttons
                      Column(
                        children: [
                          // Edit Order Button
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F1F1F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                //  Navigate to edit order
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تعديل الطلب'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              },
                              child: const Text(
                                'تعديل الطلب',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Cancel Button
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF1F1F1F)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'إلغاء',
                                style: TextStyle(
                                  color: Color(0xFF1F1F1F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
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
