import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/widget/custom_app_bar.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/cart/logic/cart/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/ui/widget/cart_item.dart';
import 'package:ecommerce_app/features/cart/ui/widget/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHomeHeader(),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<CartCubit>(context);
                  if (state is CartLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is CartLoaded) {
                    if (state.cartItems.isEmpty) {
                      return EmptyCartWidget(
                        onStartShopping: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.cartItems.length,
                                  itemBuilder: (context, index) {
                                    return CartItemWidget(
                                        cartItem: state.cartItems[index]);
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                        color: AppColors.grey2, height: 1);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildOrderSummary(context, state, cubit),
                        _buildCheckoutButton(context, state),
                      ],
                    );
                  } else if (state is CartError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Something went wrong!'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(
      BuildContext context, CartLoaded state, CartCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Column(
        children: [
          Divider(color: AppColors.grey2),
          BlocBuilder<CartCubit, CartState>(
            bloc: cubit,
            buildWhen: (previous, current) => current is SubtotalUpdated,
            builder: (context, subtotalState) {
              final subtotal = subtotalState is SubtotalUpdated
                  ? subtotalState.subtotal
                  : state.subtotal;
              final shipping = 10.0;
              final total = subtotal + shipping;

              return Column(
                children: [
                  _buildSummaryRow(context, 'Subtotal', subtotal),
                  _buildSummaryRow(context, 'Shipping', shipping),
                  SizedBox(height: 8.h),
                  Dash(
                    dashColor: AppColors.grey3,
                    length: MediaQuery.of(context).size.width - 32,
                  ),
                  SizedBox(height: 8.h),
                  _buildSummaryRow(
                    context,
                    'Total Amount',
                    total,
                    isTotal: true,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String title,
    double amount, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.grey,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context, CartLoaded state) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushNamed(
              Routers.checkoutRoute,
              arguments: (state.subtotal + 10).toString(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            'Checkout',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
