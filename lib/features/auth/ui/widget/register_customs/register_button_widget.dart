

// import 'package:ecommerce_app/core/utils/app_colors.dart';
// import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
// import 'package:ecommerce_app/features/cart/ui/widget/main_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class RegisterButtonWidget extends StatelessWidget {
//   const RegisterButtonWidget({
//     super.key,
//     required this.agreeToTerms,
//     required GlobalKey<FormState> formKey,
//     required this.cubit,
//     required this.emailController,
//     required this.passwordController,
//     required this.usernameController,
//   }) : _formKey = formKey;

//   final bool agreeToTerms;
//   final GlobalKey<FormState> _formKey;
//   final AuthCubit cubit;
//   final TextEditingController emailController;
//   final TextEditingController passwordController;
//   final TextEditingController usernameController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 56.h,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: agreeToTerms
//               ? [
//                   AppColors.primary,
//                   AppColors.primary.withOpacity(0.8),
//                 ]
//               : [
//                   Colors.grey.shade300,
//                   Colors.grey.shade400,
//                 ],
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: agreeToTerms
//             ? [
//                 BoxShadow(
//                   color: AppColors.primary.withOpacity(0.3),
//                   blurRadius: 12,
//                   offset: const Offset(0, 6),
//                 ),
//               ]
//             : [],
//       ),
//       child: MainButton(
//         text: 'إنشاء الحساب',
//         isLoading: state is AuthLoading,
//         onTap: agreeToTerms
//             ? () async {
//                 if (_formKey.currentState!.validate()) {
//                   await cubit.registerWithEmailAndPassword(
//                     emailController.text,
//                     passwordController.text,
//                     usernameController.text,
//                   );
//                 }
//               }
//             : null,
//       ),
//     );
//   }
// }
