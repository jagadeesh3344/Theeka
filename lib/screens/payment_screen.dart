import 'package:flutter/material.dart';
import '../models/address.dart';
import '../models/order_confirmation.dart';
import '../models/payment_method.dart';
import '../models/restaurant.dart';
import '../services/order_repository.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/confirm_pay_button.dart';
import '../widgets/other_payment_methods_card.dart';
import '../widgets/payable_amount_card.dart';
import '../widgets/payment_header.dart';
import '../widgets/upi_payment_card.dart';
import 'order_placed_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Map<String, int> cartQuantities;
  final DeliveryAddress? deliveryAddress;
  final double payableAmount;
  final int coinsRedeemed;
  final VoidCallback? onBack;
  final VoidCallback? onPaymentSuccess;

  const PaymentScreen({
    super.key,
    required this.restaurant,
    this.cartQuantities = const {},
    this.deliveryAddress,
    required this.payableAmount,
    this.coinsRedeemed = 0,
    this.onBack,
    this.onPaymentSuccess,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethodType _selectedMethod = PaymentMethodType.upi;
  UpiProvider _selectedUpiProvider = UpiProvider.googlePay;
  late final TextEditingController _upiController;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _upiController = TextEditingController(text: 'vatsa@sample');
  }

  @override
  void dispose() {
    _upiController.dispose();
    super.dispose();
  }

  int get _itemCount {
    if (widget.cartQuantities.isEmpty) return 2;
    return widget.cartQuantities.values.fold(0, (sum, count) => sum + count);
  }

  Future<void> _handleConfirmAndPay() async {
    if (_isProcessing) return;

    // Validate UPI ID if UPI is selected
    if (_selectedMethod == PaymentMethodType.upi) {
      final upiText = _upiController.text.trim();
      if (upiText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: ThekaaColors.terracotta,
            content: Text(
              'Please enter a valid UPI ID',
              style: TextStyle(fontFamily: 'Inter', color: Colors.white),
            ),
          ),
        );
        return;
      }
    }

    setState(() {
      _isProcessing = true;
    });

    // Simulate brief payment processing
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    setState(() {
      _isProcessing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ThekaaColors.primaryText,
        content: Text(
          'Order confirmed with ${widget.restaurant.name}! Paid ₹${widget.payableAmount.toInt()}',
          style: const TextStyle(
            fontFamily: 'Inter',
            color: ThekaaColors.cardBackground,
          ),
        ),
      ),
    );

    final orderConfirmation = OrderConfirmation.fromCheckout(
      restaurant: widget.restaurant,
      cartQuantities: widget.cartQuantities,
      deliveryAddress: widget.deliveryAddress,
      payableAmount: widget.payableAmount,
      coinsRedeemed: widget.coinsRedeemed,
      paymentMethod: _selectedMethod,
    );

    OrderRepository.instance.addOrUpdateOrder(orderConfirmation);

    if (widget.onPaymentSuccess != null) {
      widget.onPaymentSuccess!();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderPlacedScreen(
            order: orderConfirmation,
            onBack: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Section A: Header
            PaymentHeader(
              onBack: widget.onBack ?? () => Navigator.of(context).pop(),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section B: Amount Payable Card
                    PayableAmountCard(
                      payableAmount: widget.payableAmount,
                      restaurant: widget.restaurant,
                      itemCount: _itemCount,
                      deliveryAddress: widget.deliveryAddress,
                    ),

                    // Section C: "Choose how to pay" Header
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 8.0),
                      child: Text(
                        'Choose how to pay',
                        style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: ThekaaColors.primaryText,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),

                    // Section D: UPI Payment Card (Expanded & Selected)
                    UpiPaymentCard(
                      isSelected: _selectedMethod == PaymentMethodType.upi,
                      selectedProvider: _selectedUpiProvider,
                      upiController: _upiController,
                      onProviderSelected: (provider) {
                        setState(() {
                          _selectedUpiProvider = provider;
                          _selectedMethod = PaymentMethodType.upi;
                        });
                      },
                      onSelect: () {
                        setState(() {
                          _selectedMethod = PaymentMethodType.upi;
                        });
                      },
                    ),

                    // Section E: Other Payment Methods Card (Cards, Net Banking, COD)
                    OtherPaymentMethodsCard(
                      selectedMethod: _selectedMethod,
                      isCodAvailable: true,
                      onSelectMethod: (method) {
                        setState(() {
                          _selectedMethod = method;
                        });
                      },
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Section F: Fixed Bottom Payment Button (NO bottom navigation bar)
            ConfirmPayButton(
              payableAmount: widget.payableAmount,
              coinsRedeemed: widget.coinsRedeemed,
              isProcessing: _isProcessing,
              onPressed: _handleConfirmAndPay,
            ),
          ],
        ),
      ),
    );
  }
}

