import 'package:ecommerce_app/features/checkout_payment/views/widgets/custom_button_bloc_consumer.dart';
import 'package:ecommerce_app/features/checkout_payment/views/widgets/payment_methods_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  final double total;
  const PaymentMethodsBottomSheet({
    super.key, required this.total,
  });

  @override
  Widget build(BuildContext context) {
     debugPrint('Total amount in PaymentMethodsBottomSheet page: $total');
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16.h,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32.h,
          ),
          CustomButtonBlocConsumer(total: total,),
        ],
      ),
    );
  }
}
