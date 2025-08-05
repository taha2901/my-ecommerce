import 'package:ecommerce_app/core/widget/spacing.dart';
import 'package:ecommerce_app/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/home/logic/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemWidget extends StatelessWidget {
 final BuildContext context;
  final  dynamic product;
  final  FavouriteCubit favoriteCubit;
  const ProductItemWidget({super.key, required this.context, this.product, required this.favoriteCubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imgUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[100],
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey[400],
                    size: 24.sp,
                  ),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[100],
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          verticalSpace(16),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money_rounded,
                      size: 16.sp,
                      color: Colors.green[600],
                    ),
                    Text(
                      '${product.price}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Remove Button
          BlocConsumer<FavouriteCubit, FavouriteState>(
            bloc: favoriteCubit,
            listenWhen: (previous, current) => current is FavouriteRemoveError,
            listener: (context, state) {
              if (state is FavouriteRemoveError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.white),
                        SizedBox(width: 8.w),
                        Expanded(child: Text(state.errMessage)),
                      ],
                    ),
                    backgroundColor: Colors.red[600],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }
            },
            buildWhen: (previous, current) =>
                (current is FavouriteRemoveing &&
                    current.productId == product.id) ||
                (current is FavouriteRemoved &&
                    current.productId == product.id) ||
                current is FavouriteRemoveError,
            builder: (context, state) {
              if (state is FavouriteRemoveing &&
                  state.productId == product.id) {
                return Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(8.w),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red[600]!),
                  ),
                );
              }

              if (state is FavouriteRemoved && state.productId == product.id) {
                // تحديث صفحة الهوم عند حذف عنصر من المفضلة
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  BlocProvider.of<HomeCubit>(context).getHomeData();
                  // إعادة تحميل قائمة المفضلة لتحديث UI
                  favoriteCubit.getFavoriteProducts();
                });
              }

              return Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red[600],
                    size: 20.sp,
                  ),
                  onPressed: () => _showDeleteConfirmation(
                    context,
                    product,
                    favoriteCubit,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  void _showDeleteConfirmation(
    BuildContext context,
    dynamic product,
    FavouriteCubit favoriteCubit,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                color: Colors.red[600],
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Remove from Favorites',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to remove "${product.name}" from your favorites?',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // استدعاء remove مع await للتأكد من إتمام العملية
                await favoriteCubit.removeFavorite(product.id, context);
                // تحديث فوري لصفحة المفضلة
                await favoriteCubit.getFavoriteProducts();
                // تحديث صفحة الهوم لتحديث حالة القلوب
                // BlocProvider.of<HomeCubit>(context).getHomeData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Remove',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}