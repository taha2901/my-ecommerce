import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/services/auth_services.dart';
import 'package:ecommerce_app/core/services/favourite_services.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:ecommerce_app/features/home/logic/home_cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';


class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  final favoriteServices = FavouriteServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getFavoriteProducts() async {
    emit(FavouriteLoading());
    try {
      final currentUser = authServices.currentUser();
      final favoriteProducts = await favoriteServices.getFavourite(
        userId: currentUser!.uid,
      );
      emit(FavouriteLoaded(favouriteProduct: favoriteProducts));
    } catch (e) {
      emit(FavouriteError(errorMessage: e.toString()));
    }
  }

  Future<void> removeFavorite(String productId,BuildContext context) async {
    emit(FavouriteRemoveing(productId: productId));
    try {
      final currentUser = authServices.currentUser();
      await favoriteServices.removeFavourite(
        userId: currentUser!.uid,
        productId: productId,
      );
      emit(FavouriteRemoved(productId: productId));
      final favoriteProducts = await favoriteServices.getFavourite(
        userId: currentUser.uid,
      );
      BlocProvider.of<HomeCubit>(context).getHomeData();
      emit(FavouriteLoaded(favouriteProduct: favoriteProducts));
    } catch (e) {
      emit(FavouriteRemoveError(errMessage: e.toString()));
    }
  }
}
