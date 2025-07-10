
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/address/utils/app_colors.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsImageContainer extends StatelessWidget {
  const ProductDetailsImageContainer({
    super.key,
    required this.size,
    required this.product,
  });

  final Size size;
  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey2,
      ),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          CachedNetworkImage(
            imageUrl: product.imgUrl,
            height: size.height * 0.4,
          ),
        ],
      ),
    );
  }
}
