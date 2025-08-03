import 'package:ecommerce_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

// class TotalPrice extends StatelessWidget {
//   const TotalPrice({super.key, required this.title, required this.value});

//   final String title, value;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: Styles.style24,
//         ),
//         const Spacer(),
//         Text(
//           value,
//           textAlign: TextAlign.center,
//           style: Styles.style24,
//         )
//       ],
//     );
//   }
// }




class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.receipt_long_rounded,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
