import 'package:ecommerce_app/core/services/auth_services.dart';
import 'package:ecommerce_app/core/services/favourite_services.dart';
import 'package:ecommerce_app/core/services/home_services.dart';
import 'package:ecommerce_app/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/home/data/home_carousal_item_model.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();
  final favouriteServices = FavouriteServicesImpl();

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.fetchProducts();
      final homeCarouselItems = await homeServices.fetchHomeCarouselItems();
      final favouriteProducts = await favouriteServices.getFavourite(
        userId: authServices.currentUser()!.uid,
      );
      final List<ProductItemModel> finalProducts = products.map(
        (product) {
          final isFavorite = favouriteProducts.any(
            (item) => item.id == product.id,
          );
          return product.copyWith(isFavorite: isFavorite);
        },
      ).toList();
      emit(HomeLoaded(
        carouselItems: homeCarouselItems,
        products: finalProducts,
      ));
    } catch (e) {
      emit(HomeError("Error: $e"));
    }
  }

  Future<void> setFavourite(ProductItemModel product, BuildContext context) async {
    emit(SetFavouriteLoading(productId: product.id));
    try {
      final currentUser = authServices.currentUser();
      final favouriteProducts = await favouriteServices.getFavourite(
        userId: currentUser!.uid,
      );
      // any  : بتلف على كل ايتيم موجود ف مفضلو ف هيبقا ب ترو
      final isFavourite =
          favouriteProducts.any((item) => item.id == product.id);
      if (isFavourite) {
        await favouriteServices.removeFavourite(
            userId: currentUser.uid, productId: product.id);
      } else {
        await favouriteServices.addFavourite(
            userId: currentUser.uid, product: product);
      }

      emit(SetFavouriteSuccess(isFav: !isFavourite, productId: product.id));
      
      BlocProvider.of<FavouriteCubit>(context).getFavoriteProducts();
    } catch (e) {
      emit(SetFavouriteFailure(e.toString(), product.id));
    }
  }
}
