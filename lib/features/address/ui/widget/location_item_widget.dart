import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/location_item_model.dart';
import '../../logic/cubit/address_cubit.dart';

class LocationItemWidget extends StatelessWidget {
  const LocationItemWidget({
    super.key,
    required this.cubit,
    required this.location,
    required this.onTap,
    required this.borderColor,
  });
  final Color borderColor;
  final VoidCallback? onTap;
  final ChooseLocationCubit cubit;
  final LocationItemModel location;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.city,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${location.city}, ${location.country}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                   CircleAvatar(
                    radius: 55,
                    backgroundColor: borderColor,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(
                      location.imgUrl,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
