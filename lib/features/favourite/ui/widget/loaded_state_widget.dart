import 'package:ecommerce_app/core/widget/spacing.dart';
import 'package:ecommerce_app/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/num_of_product_widget.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadedStateWidget extends StatelessWidget {
  final List favoriteProducts;
  final FavouriteCubit favoriteCubit;
  const LoadedStateWidget(
      {super.key, required this.favoriteProducts, required this.favoriteCubit});

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
          // num of products in favorites
          NumberOfProductsWidget(favoriteProducts: favoriteProducts),
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
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(8.w),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return Column(
                    children: [
                      ProductItemWidget(
                          product: product,
                          favoriteCubit: favoriteCubit),
                      if (index != favoriteProducts.length - 1)
                        Divider(
                          height: 1,
                          color: Colors.grey[200],
                          indent: 20.w,
                          endIndent: 20.w,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
