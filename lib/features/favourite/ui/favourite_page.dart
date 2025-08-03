import 'package:ecommerce_app/core/widget/custom_app_bar.dart';
import 'package:ecommerce_app/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/favourite_empty.dart';
import 'package:ecommerce_app/features/home/logic/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavouriteCubit>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            const CustomHomeHeader(),
            SizedBox(height: 16.h),
            
            // Header Section
            _buildHeaderSection(context),
            SizedBox(height: 16.h),
            
            // Content Section
            Expanded(
              child: BlocBuilder<FavouriteCubit, FavouriteState>(
                bloc: favoriteCubit,
                // إزالة buildWhen عشان يسمع لكل التغييرات
                builder: (context, state) {
                  return _buildContent(context, state, favoriteCubit);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.favorite_rounded,
              color: Colors.red[600],
              size: 28.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Favorites',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Your saved products',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    FavouriteState state,
    FavouriteCubit favoriteCubit,
  ) {
    if (state is FavouriteLoading) {
      return _buildLoadingState();
    } else if (state is FavouriteLoaded) {
      final favoriteProducts = state.favouriteProduct;
      if (favoriteProducts.isEmpty) {
        return FavouriteEmpty(
          onStartShopping: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      }
      return _buildLoadedState(context, favoriteProducts, favoriteCubit);
    } else if (state is FavouriteError) {
      return _buildErrorState(state.errorMessage);
    }
    return const SizedBox.shrink();
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red[600]!),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading your favorites...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
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
            errorMessage,
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

  Widget _buildLoadedState(
    BuildContext context,
    List favoriteProducts,
    FavouriteCubit favoriteCubit,
  ) {
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
          SizedBox(height: 16.h),
          
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
                  return _buildProductItem(context, product, favoriteCubit);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    dynamic product,
    FavouriteCubit favoriteCubit,
  ) {
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
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 16.w),
          
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
            listenWhen: (previous, current) =>
                current is FavouriteRemoveError,
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
              
              if (state is FavouriteRemoved &&
                  state.productId == product.id) {
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