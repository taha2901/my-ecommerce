
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberOfProductsWidget extends StatelessWidget {
  const NumberOfProductsWidget({
    super.key,
    required this.favoriteProducts,
  });

  final List favoriteProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 20.sp,
            color: Colors.grey[600],
          ),
          SizedBox(width: 8.w),
          Text(
            '${favoriteProducts.length} ${favoriteProducts.length == 1 ? 'item' : 'items'} in favorites',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
