import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteEmpty extends StatefulWidget {
  final VoidCallback? onStartShopping;

  const FavouriteEmpty({super.key, this.onStartShopping});

  @override
  State<FavouriteEmpty> createState() => _FavouriteEmptyState();
}

class _FavouriteEmptyState extends State<FavouriteEmpty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.heart,
                size: 80.r,
                color: AppColors.kPrimaryColor.withOpacity(0.3),
              ),
              SizedBox(height: 24.h),
              Text(
                LocaleKeys.emptyFavouriteTitle.tr(),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  LocaleKeys.emptyFavouriteMessage.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.kGrayColor,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: 0.8.sw,
                child: ElevatedButton(
                  onPressed: widget.onStartShopping,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.shop, size: 20.r,color: Colors.white,),
                      SizedBox(width: 8.w),
                      Text(
                        LocaleKeys.emptyFavouriteButton.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}