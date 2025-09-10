import 'package:flutter/material.dart';
import 'package:hr/views/screens/leave_request_page.dart';
import 'package:hr/views/screens/permission_request_page.dart';
import 'package:hr/views/screens/sales_order.dart';

import '../widgets/header.dart';
import '../widgets/historyItem.dart';
import '../widgets/order_card.dart';
import 'home_checkIn_page.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ServiceFeedItem> items = [
      _ServiceFeedItem.history(
        title: 'تم تقديم طلب إجازة مرضية',
        dayTitle: 'الخميس',
        dayNumber: '1',
        month: 'أغسطس',
        badge: 'قيد المراجعة',
      ),
      _ServiceFeedItem.history(
        title: 'طلب إذن للخروج من الساعة 3 الى 3:30',
        dayTitle: 'الخميس',
        dayNumber: '1',
        month: 'أغسطس',
        badge: 'تم الموافقة',
      ),
      _ServiceFeedItem.order(
        product: 'اسم المنتج',
        client: 'اسم العميل',
        price: '100\$',
        statusText: 'قيد التنفيذ',
        statusColor: const Color(0xFFFFC107),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: 22),
            const SectionTitle(title: 'الخدمات'),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _ServicesButtons(),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.filter_alt, color: Color(0xFF1F1F1F)),
                        Spacer(),
                        SectionTitle(title: 'السجل'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: item.map(
                            history: (h) => HistoryItem(
                              title: h.title,
                              dayTitle: h.dayTitle,
                              dayNumber: h.dayNumber,
                              month: h.month,
                              badge: h.badge,
                            ),
                            order: (o) => OrderCard(
                              product: o.product,
                              client: o.client,
                              price: o.price,
                              statusText: o.statusText,
                              statusColor: o.statusColor,
                            ),
                          ),
                        );
                      },
                    ),
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

class _ServicesButtons extends StatelessWidget {
  const _ServicesButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ServiceButton(icon: Icons.campaign_outlined, label: 'طلب إجازة', onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LeaveRequestFormPage()));

        },),
        const SizedBox(height: 10),
        _ServiceButton(icon: Icons.access_time, label: 'طلب إذن خروج', onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PermissionRequestPage()));
        },),
        const SizedBox(height: 10),
        _ServiceButton(icon: Icons.credit_card, label: 'طلب بيع', onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SalesOrderPage()));

        },),
      ],
    );
  }
}

class _ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const _ServiceButton({required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Icon(icon, color: Colors.white),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
//
// class _Badge extends StatelessWidget {
//   final String text;
//   const _Badge({required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF3F3F3),
//         borderRadius: BorderRadius.circular(6),
//         border: Border.all(color: const Color(0xFFE0E0E0)),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Color(0xFF676767),
//           fontSize: 10.5,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
// }

class _ServiceFeedItem {
  final _HistoryData? historyData;
  final _OrderData? orderData;

  _ServiceFeedItem.history({
    required String title,
    required String dayTitle,
    required String dayNumber,
    required String month,
    String? badge,
  }) : historyData = _HistoryData(
         title: title,
         dayTitle: dayTitle,
         dayNumber: dayNumber,
         month: month,
         badge: badge,
       ),
       orderData = null;

  _ServiceFeedItem.order({
    required String product,
    required String client,
    required String price,
    required String statusText,
    required Color statusColor,
  }) : orderData = _OrderData(
         product: product,
         client: client,
         price: price,
         statusText: statusText,
         statusColor: statusColor,
       ),
       historyData = null;

  T map<T>({
    required T Function(_HistoryData) history,
    required T Function(_OrderData) order,
  }) {
    if (historyData != null) return history(historyData!);
    return order(orderData!);
  }
}

class _HistoryData {
  final String title;
  final String dayTitle;
  final String dayNumber;
  final String month;
  final String? badge;
  const _HistoryData({
    required this.title,
    required this.dayTitle,
    required this.dayNumber,
    required this.month,
    this.badge,
  });
}

class _OrderData {
  final String product;
  final String client;
  final String price;
  final String statusText;
  final Color statusColor;
  const _OrderData({
    required this.product,
    required this.client,
    required this.price,
    required this.statusText,
    required this.statusColor,
  });
}
