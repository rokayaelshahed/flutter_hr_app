import 'package:flutter/material.dart';
import 'package:hr/views/widgets/number_field_widget.dart';
import '../widgets/appbar.dart';
import '../widgets/form_widgets.dart';
import '../widgets/order_summary_sheet.dart';

class SalesOrderPage extends StatefulWidget {
  const SalesOrderPage({super.key});

  @override
  State<SalesOrderPage> createState() => _SalesOrderPageState();
}

class _SalesOrderPageState extends State<SalesOrderPage> {
  // dummy data
  final List<String> _customers = ['العميل 1', 'العميل 2', 'العميل 3'];
  final List<String> _products = ['المنتج 1', 'المنتج 2', 'المنتج 3'];

  String? _customer;
  String? _product;
  DateTime? _orderDate;
  int _quantity = 1;
  String _unitPrice = '100';
  String _linePrice = '100';

  final TextEditingController _quantityController = TextEditingController(
    text: '1',
  );
  final TextEditingController _unitPriceController = TextEditingController(
    text: '100',
  );
  final TextEditingController _linePriceController = TextEditingController(
    text: '100',
  );

  String _formatDate(DateTime? d) {
    if (d == null) return '15 \\ 8 \\ 2025';
    return '${d.day} \\ ${d.month} \\ ${d.year}';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _orderDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      locale: const Locale('ar'),
      builder: (context, child) {
        final theme = Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF1F1F1F),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xFF1F1F1F),
          ),
        );
        return Theme(
          data: theme,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
        );
      },
    );
    if (picked != null) setState(() => _orderDate = picked);
  }

  void _updateLinePrice() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final unitPrice = double.tryParse(_unitPriceController.text) ?? 0.0;
    final linePrice = quantity * unitPrice;

    setState(() {
      _quantity = quantity;
      this._unitPrice = _unitPriceController.text;
      this._linePrice = linePrice.toString();
      _linePriceController.text = linePrice.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _quantityController.addListener(_updateLinePrice);
    _unitPriceController.addListener(_updateLinePrice);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _unitPriceController.dispose();
    _linePriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CardShell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomAppBar(title: 'طلب بيع'),
                          const SizedBox(height: 16),

                          // client
                          RightLabelField(
                            label: 'العميل',
                            child: FieldShell(
                              child: DropdownButtonFormField<String>(
                                hint: const Text(
                                  textAlign: TextAlign.right,
                                  'العميل ',
                                  style: TextStyle(
                                    color: Color(0xFF6B6B6B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                isExpanded: true,
                                alignment: AlignmentDirectional.centerEnd,
                                value: _customer,
                                icon: const SizedBox.shrink(),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 12),
                                  prefixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF6B6B6B),
                                  ),
                                ),
                                items: _customers
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) => setState(() => _customer = v),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection: TextDirection.rtl,
                                // Icon on the right
                                children: const [
                                  Icon(
                                    Icons.person_add_alt_1_rounded,
                                    size: 18,
                                    color: Color(0xFF1F1F1F),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'اضافة عميل جديد',
                                    style: TextStyle(
                                      color: Color(0xFF1F1F1F),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // order date
                          RightLabelField(
                            label: 'تاريخ الطلب',
                            child: FieldShell(
                              child: InkWell(
                                onTap: _pickDate,
                                child: Row(
                                  children: [
                                    const IconBox(
                                      icon: Icons.calendar_today_rounded,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        _formatDate(_orderDate),
                                        style: const TextStyle(
                                          color: Color(0xFF6B6B6B),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // product
                          RightLabelField(
                            label: 'المنتج',
                            child: FieldShell(
                              child: DropdownButtonFormField<String>(
                                hint: const Text(
                                  textAlign: TextAlign.right,
                                  'المنتج ',
                                  style: TextStyle(
                                    color: Color(0xFF6B6B6B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                isExpanded: true,
                                alignment: AlignmentDirectional.centerEnd,
                                value: _product,
                                icon: const SizedBox.shrink(),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 12),
                                  prefixIcon: Icon(Icons.arrow_drop_down),
                                ),
                                items: _products
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) => setState(() => _product = v),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // quantity
                          RightLabelField(
                            label: 'الكمية',
                            child: NumberField(controller: _quantityController),
                          ),
                          const SizedBox(height: 10),

                          // unit price
                          RightLabelField(
                            label: 'سعر الوحدة',
                            child: NumberField(
                              controller: _unitPriceController,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // note
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'يتم تعبئة السعر تلقائياً من بيانات المنتج ويمكن تعديله *',
                              style: TextStyle(
                                color: Color(0xFFBDBDBD),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // line price
                          RightLabelField(
                            label: 'سعر البند',
                            child: NumberField(
                              controller: _linePriceController,
                              enabled: false,
                            ),
                          ),
                          const SizedBox(height: 18),

                          // add to order
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F1F1F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                               // final qty = int.tryParse(_quantity as String) ?? 0;
                                final unit = double.tryParse(_unitPrice) ?? 0.0;
                                final line = double.tryParse(_linePrice) ?? 0.0;;

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  ),
                                  builder: (ctx) {
                                    return OrderSummarySheet(
                                      customer: _customer ?? 'العميل',
                                      product: _product ?? 'المنتج',
                                      quantity: _quantity,
                                      unitPrice: unit,
                                      linePrice: line,
                                      orderDate: _orderDate ?? DateTime.now(),
                                      statusText: 'إزالة',
                                      statusColor: const Color(0xFFE53935),
                                      onDelete: (){
                                        Navigator.of(context).pop();
                                        setState(() {
                                          _customer = null;
                                          _product = null;
                                          _quantity = 1;
                                          _quantityController.text = '1';
                                          _unitPriceController.text = '100';
                                          _linePriceController.text = '100';
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'إضافة الى الطلب',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // cancel
                          SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF1F1F1F),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'إلغاء',
                                style: TextStyle(
                                  color: Color(0xFF1F1F1F),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
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
