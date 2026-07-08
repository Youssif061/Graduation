import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/data/dummy_data.dart';
import 'package:expertisemarket/features/products/presentation/pages/order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _addressCtrl = TextEditingController();
  int _selectedPayment = 0; // 0 = Cash on Delivery

  final double _subtotal = 1798.00;
  final double _taxes = 143.84;
  double get _total => _subtotal + _taxes;

  @override
  void dispose() {
    _addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar as seen in mockup
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.marketText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Checkout', style: MarketTextStyles.appBarTitle.copyWith(fontWeight: FontWeight.w800)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.marketCardLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.marketBorder),
            ),
            child: const Center(
              child: Text(
                'JD',
                style: TextStyle(
                  color: AppColors.marketText,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.marketBorder,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                // ── Delivery Address ──────────────────────────────
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, color: AppColors.marketGreen, size: 18),
                              const SizedBox(width: 6),
                              Text('Delivery Address', style: MarketTextStyles.sectionTitle.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Locate on Map',
                              style: MarketTextStyles.bodySmall.copyWith(
                                color: AppColors.marketGreenDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'DELIVERY ADDRESS',
                        style: MarketTextStyles.sectionLabel,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.marketBg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.marketBorder),
                        ),
                        child: TextField(
                          controller: _addressCtrl,
                          style: MarketTextStyles.bodyMedium.copyWith(color: AppColors.marketText, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Enter your delivery address',
                            hintStyle: MarketTextStyles.bodySmall.copyWith(fontSize: 13, color: AppColors.marketTextMuted),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppColors.marketText, // Dark navy
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Confirm Address',
                            style: MarketTextStyles.buttonText.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // ── Order Review ──────────────────────────────────
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.inventory_2_outlined, color: AppColors.marketGreen, size: 18),
                          const SizedBox(width: 6),
                          Text('Order Review', style: MarketTextStyles.sectionTitle.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...DummyData.checkoutItems.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  color: const Color(0xFFF8FAFC),
                                  child: Image.asset(
                                    item.imageAsset,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.inventory_2_outlined,
                                      color: Color(0xFFCBD5E1),
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: MarketTextStyles.productTitle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text('Qty: ${item.quantity}', style: MarketTextStyles.bodySmall.copyWith(color: AppColors.marketTextSub)),
                                  ],
                                ),
                              ),
                              Text(
                                '\$${item.price.toStringAsFixed(0)}',
                                style: MarketTextStyles.price.copyWith(fontSize: 13, color: AppColors.marketGreenDark, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // ── Payment Method ────────────────────────────────
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.payment, color: AppColors.marketGreen, size: 18),
                          const SizedBox(width: 6),
                          Text('Payment Method', style: MarketTextStyles.sectionTitle.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => setState(() => _selectedPayment = 0),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _selectedPayment == 0
                                ? AppColors.marketGreenBadge
                                : AppColors.marketBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _selectedPayment == 0
                                  ? AppColors.marketGreen
                                  : AppColors.marketBorder,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.marketGreen,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.delivery_dining, color: Colors.white, size: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Cash on Delivery',
                                      style: MarketTextStyles.productTitle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text('Pay when your order arrives', style: MarketTextStyles.bodySmall.copyWith(color: AppColors.marketTextSub)),
                                  ],
                                ),
                              ),
                              Radio<int>(
                                value: 0,
                                groupValue: _selectedPayment,
                                onChanged: (v) => setState(() => _selectedPayment = v!),
                                activeColor: AppColors.marketGreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.marketTextSub, size: 14),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Please ensure you have the exact amount ready at the time of delivery to facilitate a smooth transaction.',
                              style: MarketTextStyles.bodySmall.copyWith(fontSize: 11, color: AppColors.marketTextSub),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // ── Summary ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      _SummaryRow(label: 'Subtotal', value: '\$${_subtotal.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      _SummaryRow(label: 'Taxes', value: '\$${_taxes.toStringAsFixed(2)}'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: AppColors.marketBorder),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount', style: MarketTextStyles.sectionTitle.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                          Text(
                            '\$${_total.toStringAsFixed(2)}',
                            style: MarketTextStyles.grandTotal.copyWith(fontSize: 18, color: AppColors.marketText, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Confirm button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
                    );
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.marketText, // Dark slate/navy
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirm Order',
                          style: MarketTextStyles.buttonText.copyWith(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.marketCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.marketBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: MarketTextStyles.totalLabel.copyWith(color: AppColors.marketTextSub)),
        Text(
          value,
          style: MarketTextStyles.totalValue.copyWith(
            color: AppColors.marketText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
