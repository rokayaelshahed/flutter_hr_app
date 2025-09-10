import 'dart:ui';

/// Model class for order data
class OrderData {
  final String product;
  final String customer;
  final String price;
  final String statusText;
  final Color statusColor;
  final String date;
  final int quantity;

  const OrderData({
    required this.product,
    required this.customer,
    required this.price,
    required this.statusText,
    required this.statusColor,
    required this.date,
    required this.quantity,
  });
  // Add method to calculate total
  String get total {
    final priceValue = double.tryParse(price.replaceAll(' \$', '')) ?? 0.0;
    final totalValue = priceValue * quantity;
    return '${totalValue.toStringAsFixed(0)} \$';
  }
}