import 'package:ecommerce_app/core/widget/spacing.dart';
import 'package:ecommerce_app/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadedStateWidget extends StatelessWidget {
  final BuildContext context;
  final List favoriteProducts;
  final FavouriteCubit favoriteCubit;
  const LoadedStateWidget(
      {super.key,
      required this.context,
      required this.favoriteProducts,
      required this.favoriteCubit});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await favoriteCubit.getFavoriteProducts();
      },
      color: Colors.red[600],
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Products count
          Container(
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
          ),
          verticalSpace(16),
          // Products list
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(8.w),
                itemCount: favoriteProducts.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey[200],
                  indent: 20.w,
                  endIndent: 20.w,
                ),
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return ProductItemWidget(
                      context: context,
                      product: product,
                      favoriteCubit: favoriteCubit);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
