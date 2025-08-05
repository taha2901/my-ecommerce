import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String? text;
  final String? imgUrl;
  final VoidCallback? onTap;
  final bool isLoading;

   SocialMediaButton({
    super.key,
    this.text,
    this.imgUrl,
    this.onTap,
    this.isLoading = false,
  }) {
    assert (text != null && imgUrl != null  || isLoading == true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading ? const CircularProgressIndicator.adaptive() : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: imgUrl!,
                width: 25,
                height: 25,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 16),
              Text(text!),
            ],
          ),
        ),
      ),
    );
  }
}
