import 'package:ecommerce_app/features/checkout_payment/views/widgets/thank_you_view_body.dart';
import 'package:flutter/material.dart';
class ThankYouView extends StatelessWidget {
  final String total;
  const ThankYouView({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.grey[600]),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Payment Successful',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Transform.translate(
        offset: const Offset(0, -16),
        child: ThankYouViewBody(total: total),
      ),
    );
  }
}
