
import 'package:ecommerce_app/core/widget/cutom_app_bar.dart';
import 'package:ecommerce_app/features/checkout_payment/views/widgets/thank_you_view_body.dart';
import 'package:flutter/material.dart';

class ThankYouView extends StatelessWidget {
  // final String? passedAmount;
  const ThankYouView({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Transform.translate(
          offset: const Offset(0, -16), child:  ThankYouViewBody()),
    );
  }
}
