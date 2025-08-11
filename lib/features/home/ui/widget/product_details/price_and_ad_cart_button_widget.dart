
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:ecommerce_app/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_details/product_price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceAndAddCartButtonWidget extends StatelessWidget {
  const PriceAndAddCartButtonWidget({
    super.key,
    required this.product,
    required this.cubit,
  });

  final ProductItemModel product;
  final ProductDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProductPriceText(product: product),
        BlocBuilder<ProductDetailsCubit,
            ProductDetailsState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is ProductAddedToCart ||
              current is ProductAddingToCart,
          builder: (context, state) {
            if (state is ProductAddingToCart) {
              return ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                ),
                child: const CircularProgressIndicator
                    .adaptive(),
              );
            }
    
            if (state is ProductAddedToCart) {
              debugPrint(
                  "Product added to cart successfully");
            }
    
            return ElevatedButton.icon(
              onPressed: () {
                if (cubit.selectedSize != null) {
                  cubit.addToCart(product.id, context);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please select size',
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              label: const Text('Add to Cart'),
              icon:
                  const Icon(Icons.shopping_bag_outlined),
            );
          },
        ),
      ],
    );
  }
}
