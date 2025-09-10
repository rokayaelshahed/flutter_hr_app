import 'package:flutter/material.dart';
import 'package:hr/views/screens/sales_order.dart';
import '../../models/orderData.dart';
import '../widgets/appbar.dart';
import '../widgets/order_card.dart';
import 'order_details_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final orders = [
      OrderData(
        product: 'أسم المنتج',
        customer: 'أسم العميل',
        price: '100 \$',
        statusText: 'مكتمل',
        statusColor: const Color(0xFF18A957),
        date: 'أغسطس 2025',
        quantity: 2,
      ),
      OrderData(
        product: 'أسم المنتج',
        customer: 'أسم العميل',
        price: '150 \$',
        statusText: 'جار تجهيز',
        statusColor: const Color(0xFFFFC107),
        date: 'أغسطس 2025',
        quantity: 1
      ),
      OrderData(
        product: 'أسم المنتج',
        customer: 'أسم العميل',
        price: '120 \$',
        statusText: 'جار تجهيز',
        statusColor: const Color(0xFFFFC107),
        date: 'أغسطس 2025',
        quantity: 3
      ),
      OrderData(
        product: 'أسم المنتج',
        customer: 'أسم العميل',
        price: '1500 \$',
        statusText: 'مكتمل',
        statusColor: const Color(0xFF18A957),
        date: 'يوليو 2025',
        quantity: 1
      ),
      OrderData(
        product: 'أسم المنتج',
        customer: 'أسم العميل',
        price: '100 \$',
        statusText: 'جار تجهيز',
        statusColor: const Color(0xFFFFC107),
        date: 'يوليو 2025',
        quantity: 2
      ),
    ];

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
                    const CustomAppBar(title: 'الطلبات'),
                    const SizedBox(height: 16),

                    // Create New Order Button
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F1F1F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SalesOrderPage()),
                          );                        },

                        label: const Text(
                          'إنشاء طلب جديد',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Filter and Record label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Icon(
                      Icons.filter_alt,
                      color: Color(0xFF1F1F1F),
                      size: 20,
                    ),
                    Spacer(),
                    Text(
                      'السجل',
                      style: TextStyle(
                        color: Color(0xFF1F1F1F),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Orders List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final isFirstOfMonth = index == 0 ||
                        orders[index - 1].date != order.date;

                    return Column(
                      children: [
                        // Date header
                        if (isFirstOfMonth) ...[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8, top: 8),
                              child: Text(
                                order.date,
                                style: const TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],

                        // Order card
                        // In your OrdersPage, update the OrderCard in the ListView.builder:

                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailsPage(
                                      order: order
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: OrderCard(
                              product: order.product,
                              client: order.customer,
                              price: order.price,
                              statusText: order.statusText,
                              statusColor: order.statusColor,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 12),
                        //   child: OrderCard(
                        //     product: order.product,
                        //     client: order.customer,
                        //     price: order.price,
                        //     statusText: order.statusText,
                        //     statusColor: order.statusColor,
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),

    );
  }
}
