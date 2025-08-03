// import 'package:ecommerce_app/core/widget/custom_button.dart';
// import 'package:ecommerce_app/features/checkout_payment/presentation/manger/payment_cubit.dart';
// import 'package:ecommerce_app/features/checkout_payment/views/widgets/cart_info_item.dart';
// import 'package:ecommerce_app/features/checkout_payment/views/widgets/payment_methods_bottom_sheet.dart';
// import 'package:ecommerce_app/features/checkout_payment/views/widgets/total_price_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/repos/checkout_repo_impl.dart';


// class MyCartViewBody extends StatelessWidget {
//   final String? passedAmount;
//   const MyCartViewBody({super.key, this.passedAmount});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 18,
//           ),
//           Expanded(child: Image.asset('assets/images/basket_image.png')),
//           const SizedBox(
//             height: 25,
//           ),
//           const OrderInfoItem(
//             title: 'Order Subtotal',
//             value: r'42.97$',
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           const OrderInfoItem(
//             title: 'Discount',
//             value: r'0$',
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           const OrderInfoItem(
//             title: 'Shipping',
//             value: r'8$',
//           ),
//           const Divider(
//             thickness: 2,
//             height: 34,
//             color: Color(0xffC7C7C7),
//           ),
//           const TotalPrice(title: 'Total', value: r'$50.97'),
//           const SizedBox(
//             height: 16,
//           ),
//           CustomButton(
//             text: 'Complete Payment',
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//               //   return const PaymentDetailsView();
//               // }));

//               showModalBottomSheet(
//                   context: context,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   builder: (context) {
//                     return BlocProvider(
//                       create: (context) => PaymenttCubit(CheckoutRepoImpl()),
//                       child:  PaymentMethodsBottomSheet(passedAmount:  passedAmount,),
//                     );
//                   });
//             },
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//         ],
//       ),
//     );
//   }
// }
