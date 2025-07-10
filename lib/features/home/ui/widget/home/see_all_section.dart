
import 'package:flutter/material.dart';

class SeeAllSectionHeader extends StatelessWidget {
  const SeeAllSectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'New Arrivals',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          'See All',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
