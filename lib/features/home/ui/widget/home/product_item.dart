import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:ecommerce_app/features/home/logic/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 90,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade200,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: productItem.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: homeCubit,
                  buildWhen: (previous, current) =>
                      (current is SetFavouriteFailure &&
                          current.productId == productItem.id) ||
                      (current is SetFavouriteLoading &&
                          current.productId == productItem.id) ||
                      (current is SetFavouriteSuccess &&
                          current.productId == productItem.id),
                  builder: (context, state) {
                    if (state is SetFavouriteLoading) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (state is SetFavouriteSuccess) {
                      return state.isFav
                          ? InkWell(
                              onTap: () async =>
                                  await homeCubit.setFavourite(productItem,context),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                          : InkWell(
                              onTap: () async =>
                                  await homeCubit.setFavourite(productItem,context),
                              child: const Icon(
                                Icons.favorite_border,
                              ),
                            );
                    }
                    return InkWell(
                      onTap: () async =>
                          await homeCubit.setFavourite(productItem, context),
                      child: productItem.isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          productItem.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          productItem.category,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.grey,
              ),
        ),
        Text(
          '\$${productItem.price}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
