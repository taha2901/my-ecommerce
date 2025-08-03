
import 'package:ecommerce_app/core/widget/cutom_app_bar.dart';
import 'package:ecommerce_app/features/checkout_payment/views/widgets/thank_you_view_body.dart';
import 'package:flutter/material.dart';

class ThankYouView extends StatelessWidget {
  final String total;
  const ThankYouView({super.key, required this.total, });

  @override
  Widget build(BuildContext context) {
     debugPrint('Total amount in ThankYouView: $total');
    return Scaffold(
      appBar: buildAppBar(),
      body: Transform.translate(
          offset: const Offset(0, -16), child:  ThankYouViewBody(total: total,)),
    );
  }
}
