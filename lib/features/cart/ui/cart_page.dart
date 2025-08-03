import 'package:ecommerce_app/core/widget/custom_app_bar.dart';
import 'package:ecommerce_app/core/widget/spacing.dart';
import 'package:ecommerce_app/features/cart/logic/cart/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/ui/widget/cart_item.dart';
import 'package:ecommerce_app/features/cart/ui/widget/empty_cart.dart';
import 'package:ecommerce_app/features/checkout_payment/data/repos/checkout_repo_impl.dart';
import 'package:ecommerce_app/features/checkout_payment/presentation/manger/payment_cubit.dart';
import 'package:ecommerce_app/features/checkout_payment/views/widgets/payment_methods_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // لون خلفية أنعم
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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Loading your cart...',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    );
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
                        // إضافة header للسلة
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 24.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'My Cart',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${state.cartItems.length} ${state.cartItems.length == 1 ? 'item' : 'items'}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(16),
                        
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
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
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: state.cartItems.length,
                                    padding: EdgeInsets.all(8.w),
                                    itemBuilder: (context, index) {
                                      return CartItemWidget(
                                          cartItem: state.cartItems[index]);
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: Colors.grey[200],
                                        height: 1,
                                        indent: 16.w,
                                        endIndent: 16.w,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                        ),
                        _buildOrderSummary(context, state, cubit),
                        _buildCheckoutButton(context, state),
                      ],
                    );
                  } else if (state is CartError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.sp,
                            color: Colors.red[300],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Oops! Something went wrong',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                color: Theme.of(context).primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
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
                  SizedBox(height: 12.h),
                  _buildSummaryRow(context, 'Shipping', shipping),
                  SizedBox(height: 16.h),
                  
                  // خط منقط محسن
                  Row(
                    children: List.generate(
                      50,
                      (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          height: 1.5,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: _buildSummaryRow(
                      context,
                      'Total Amount',
                      total,
                      isTotal: true,
                    ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: isTotal ? Colors.grey[800] : Colors.grey[600],
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18.sp : 16.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? Theme.of(context).primaryColor : Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context, CartLoaded state) {
    final subtotal = state.subtotal;
    final shipping = 10.0;
    final total = subtotal + shipping;
    debugPrint('Total amount in checkout page: $total');
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return BlocProvider(
                  create: (context) => PaymenttCubit(CheckoutRepoImpl()),
                  child: PaymentMethodsBottomSheet(total: total),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_rounded,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}