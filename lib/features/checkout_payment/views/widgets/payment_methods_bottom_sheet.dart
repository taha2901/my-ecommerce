import 'package:ecommerce_app/features/checkout_payment/views/widgets/custom_button_bloc_consumer.dart';
import 'package:ecommerce_app/features/checkout_payment/views/widgets/payment_methods_list_view.dart';
import 'package:flutter/material.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  final String? passedAmount;
  const PaymentMethodsBottomSheet({super.key, this.passedAmount,});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32,
          ),
          CustomButtonBlocConsumer(
            passedAmount: passedAmount ?? '0',
          ),
        ],
      ),
    );
  }
}
