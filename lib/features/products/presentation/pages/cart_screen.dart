import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/data/dummy_data.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/products/presentation/pages/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItemModel> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(DummyData.cartItems);
  }

  double get _subtotal =>
      _items.fold(0, (s, i) => s + i.price * i.quantity);
  double get _tax => _subtotal * 0.05;
  double get _total => _subtotal + _tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar per mockup
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.marketText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('EliteMarket', style: MarketTextStyles.appBarTitle.copyWith(fontWeight: FontWeight.w800)),
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
            child: const Icon(
              Icons.person_outline,
              color: AppColors.marketTextSub,
              size: 20,
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
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Text(
                  'Shopping Cart',
                  style: MarketTextStyles.sectionTitle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.marketCard,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.marketBorder),
                  ),
                  child: Text(
                    '${_items.length} Items',
                    style: MarketTextStyles.bodySmall.copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Cart items
                ..._items.asMap().entries.map((e) => _CartItemRow(
                  item: e.value,
                  onDelete: () => setState(() => _items.removeAt(e.key)),
                  onIncrement: () => setState(() => e.value.quantity++),
                  onDecrement: () {
                    if (e.value.quantity > 1) setState(() => e.value.quantity--);
                  },
                )),
                const SizedBox(height: 16),
                // Order Summary Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.marketCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.marketBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: MarketTextStyles.sectionTitle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SummaryRow(label: 'Subtotal', value: '\$${_subtotal.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      _SummaryRow(label: 'Shipping', value: 'Free', valueColor: AppColors.marketGreenDark),
                      const SizedBox(height: 8),
                      _SummaryRow(label: 'Tax (Estimated)', value: '\$${_tax.toStringAsFixed(2)}'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(color: AppColors.marketBorder),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: MarketTextStyles.sectionTitle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '\$${_total.toStringAsFixed(2)}',
                            style: MarketTextStyles.grandTotal.copyWith(
                              color: AppColors.marketText,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Proceed button (dark navy)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                    );
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.marketText, // Dark slate/navy color
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed to Checkout',
                          style: MarketTextStyles.buttonText.copyWith(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline, color: AppColors.marketTextSub, size: 13),
                    const SizedBox(width: 4),
                    Text(
                      'Secure Checkout Powered by ElitePay',
                      style: MarketTextStyles.bodySmall.copyWith(
                        fontSize: 11,
                        color: AppColors.marketTextSub,
                      ),
                    ),
                  ],
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

class _CartItemRow extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _CartItemRow({
    required this.item,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.marketCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.marketBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 70,
              height: 70,
              color: const Color(0xFFF8FAFC),
              child: Image.asset(
                item.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.inventory_2_outlined,
                  color: Color(0xFFCBD5E1),
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.marketBg,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.marketBorder),
                  ),
                  child: Text(
                    item.variant,
                    style: MarketTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      color: AppColors.marketTextSub,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Qty selector
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.marketBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.marketBorder),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: onDecrement,
                            child: Container(
                              width: 28,
                              height: 28,
                              alignment: Alignment.center,
                              child: const Icon(Icons.remove, color: AppColors.marketText, size: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${item.quantity}',
                              style: MarketTextStyles.productTitle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onIncrement,
                            child: Container(
                              width: 28,
                              height: 28,
                              alignment: Alignment.center,
                              child: const Icon(Icons.add, color: AppColors.marketText, size: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onDelete,
                child: const Icon(Icons.delete_outline, color: AppColors.marketRed, size: 20),
              ),
              const SizedBox(height: 20),
              Text(
                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                style: MarketTextStyles.price.copyWith(
                  fontSize: 14,
                  color: AppColors.marketGreenDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: MarketTextStyles.totalLabel.copyWith(color: AppColors.marketTextSub)),
        Text(
          value,
          style: MarketTextStyles.totalValue.copyWith(
            color: valueColor ?? AppColors.marketText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
