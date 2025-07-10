import 'package:ecommerce_app/core/widget/custom_button.dart';
import 'package:ecommerce_app/features/checkout_payment/data/models/payment_intent_input_model.dart';
import 'package:ecommerce_app/features/checkout_payment/views/thank_you_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/manger/payment_cubit.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  final String? passedAmount;
  const CustomButtonBlocConsumer({super.key, this.passedAmount});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymenttCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          debugPrint('passed amount in custom button blco consumer in thank view page is ${passedAmount}');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return  ThankYouView();
              },
            ),
          );
        }

        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          debugPrint(state.errMessage);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            debugPrint('passed amount in custom button bloc consumer in button is ${passedAmount}');
            PaymentIntentInputModel paymentIntentInputModel =
                PaymentIntentInputModel(
                  amount: passedAmount ?? '0', 
                  currency: 'USD',
                  cusomerId: 'cus_SCZxTwXxxe7kWr',
                );
                
            BlocProvider.of<PaymenttCubit>(
              context,
            ).makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
          isLoading: state is PaymentLoading ? true : false,
          text: 'Continue',
        );
      },
    );
  }
}
