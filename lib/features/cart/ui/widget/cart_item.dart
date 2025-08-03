import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/widget/spacing.dart';
import 'package:ecommerce_app/features/cart/logic/cart/cart_cubit.dart';
import 'package:ecommerce_app/features/home/data/add_to_cart.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_details/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, bottom: 8.0.h),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.grey2,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: cartItem.product.imgUrl,
              height: 125.h,
              width: 125.w,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        cartItem.product.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // زر الحذف
                    BlocBuilder<CartCubit, CartState>(
                      bloc: cubit,
                      buildWhen: (previous, current) =>
                          current is CartItemRemoving &&
                          current.productId == cartItem.product.id,
                      builder: (context, state) {
                        if (state is CartItemRemoving) {
                          return SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        }
                        return IconButton(
                          onPressed: () => _showDeleteDialog(context, cubit),
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 20.sp,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        );
                      },
                    ),
                  ],
                ),
                verticalSpace(4),
                Text.rich(
                  TextSpan(
                    text: 'Size: ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.grey,
                        ),
                    children: [
                      TextSpan(
                        text: cartItem.size.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                verticalSpace(12),
                BlocBuilder<CartCubit, CartState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is QuantityCounterLoaded &&
                      current.productId == cartItem.product.id,
                  builder: (context, state) {
                    if (state is QuantityCounterLoaded) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CounterWidget(
                              value: state.value,
                              productId: cartItem.product.id,
                              cubit: cubit,
                              cartItem: cartItem,
                            ),
                          ),
                          horizontalSpace(4),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '\$${(state.value * cartItem.product.price).toStringAsFixed(1)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          value: cartItem.quantity,
                          productId: cartItem.product.id,
                          cubit: cubit,
                          initialValue: cartItem.quantity,
                          cartItem: cartItem,
                        ),
                        Text(
                          '\$${cartItem.totalPrice.toStringAsFixed(1)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة إظهار نافذة تأكيد الحذف
  void _showDeleteDialog(BuildContext context, CartCubit cubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: Text(
              'Are you sure you want to remove "${cartItem.product.name}" from your cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                cubit.removeFromCart(cartItem);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
