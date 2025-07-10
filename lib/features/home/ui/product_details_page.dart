import 'package:ecommerce_app/features/address/utils/app_colors.dart';
import 'package:ecommerce_app/core/widget/loading_indicator.dart';
import 'package:ecommerce_app/core/widget/message_display.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:ecommerce_app/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_details/product_counter_bloc_builder.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_details/product_desc_section.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_details/product_details_appbar.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_details/product_details_img_container.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_details/product_price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return LoadingIndicator();
        } else if (state is ProductDetailsError) {
          return MessageDisplay(
            message: state.message,
          );
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: ProductDetailsAppBar(),
            body: Stack(
              children: [
                ProductDetailsImageContainer(size: size, product: product),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.47),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        product.averageRate.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ProductCounterBlocBuilder(
                                  cubit: cubit, product: product),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Size',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is SizeSelected ||
                                current is ProductDetailsLoaded,
                            builder: (context, state) {
                              return Row(
                                children: ProductSize.values
                                    .map(
                                      (size) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6.0, right: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<
                                                        ProductDetailsCubit>(
                                                    context)
                                                .selectSize(size);
                                          },
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: state is SizeSelected &&
                                                      state.size == size
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : AppColors.grey2,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                size.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      color:
                                                          state is SizeSelected &&
                                                                  state.size ==
                                                                      size
                                                              ? AppColors.white
                                                              : AppColors.black,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          ProductDescriptionSection(product: product),
                          const Spacer(),
                          Row(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong!'),
            ),
          );
        }
      },
    );
  }
}
