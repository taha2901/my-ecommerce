import 'package:ecommerce_app/features/checkout_payment/views/widgets/thank_you_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ThankYouViewBody extends StatelessWidget {
//   final String total;
//   const ThankYouViewBody({super.key, required this.total, });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//            ThankYouCard(total: total,),
//           Positioned(
//             bottom: MediaQuery.sizeOf(context).height * .2 + 20,
//             left: 20 + 8,
//             right: 20 + 8,
//             child: const CustomDashedLine(),
//           ),
//           Positioned(
//               left: -20,
//               bottom: MediaQuery.sizeOf(context).height * .2,
//               child: const CircleAvatar(
//                 backgroundColor: Colors.white,
//               )),
//           Positioned(
//               right: -20,
//               bottom: MediaQuery.sizeOf(context).height * .2,
//               child: const CircleAvatar(
//                 backgroundColor: Colors.white,
//               )),
//            Positioned(
//             top: -50,
//             left: 0,
//             right: 0,
//             child: CustomCheckIcon(),
//           ),
//         ],
//       ),
//     );
//   }
// }



class ThankYouViewBody extends StatelessWidget {
  final String total;
  const ThankYouViewBody({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 36.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ThankYouCard(total: total),
          
          // خط منقط محسن
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * .2 + 20,
            left: 20 + 8,
            right: 20 + 8,
            child: Row(
              children: List.generate(
                60,
                (index) => Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    height: 2,
                    decoration: BoxDecoration(
                      color: const Color(0xffB8B8B8),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // الدوائر الجانبية محسنة
          Positioned(
            left: -20,
            bottom: MediaQuery.sizeOf(context).height * .2,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -20,
            bottom: MediaQuery.sizeOf(context).height * .2,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
          
          // أيقونة التأكيد محسنة
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff34A853),
                      const Color(0xff34A853).withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
