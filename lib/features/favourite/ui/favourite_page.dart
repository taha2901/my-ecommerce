import 'package:ecommerce_app/features/address/utils/app_colors.dart';
import 'package:ecommerce_app/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavouriteCubit>(context);

    return BlocBuilder<FavouriteCubit, FavouriteState>(
      bloc: favoriteCubit,
      buildWhen: (previous, current) =>
          current is FavouriteLoaded ||
          current is FavouriteLoading ||
          current is FavouriteError,
      builder: (context, state) {
        if (state is FavouriteLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is FavouriteLoaded) {
          final favoriteProducts = state.favouriteProduct;
          if (favoriteProducts.isEmpty) {
            return const Center(
              child: Text('No favorite products'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await favoriteCubit.getFavoriteProducts();
            },
            child: ListView.separated(
              itemCount: favoriteProducts.length,
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 20,
                  endIndent: 20,
                  color: AppColors.grey2,
                );
              },
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.price.toString()),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.imgUrl),
                    radius: 25,
                  ),
                  trailing: BlocConsumer<FavouriteCubit, FavouriteState>(
                    bloc: favoriteCubit,
                    listenWhen: (previous, current) => current is FavouriteRemoveError,
                    listener: (context, state) {
                      if (state is FavouriteRemoveError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errMessage),
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
                      if (state is FavouriteRemoveing) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      return IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.red,
                        ),
                        onPressed: () async {
                          await favoriteCubit.removeFavorite(product.id);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is FavouriteError) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}