import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/services/auth_services.dart';
import 'package:ecommerce_app/core/services/favourite_services.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';

// class FavouriteCubit extends Cubit<FavouriteState> {
//   FavouriteCubit() : super(FavouriteInitial());

//   final favouriteServices = FavouriteServicesImpl();
//   final authServices = AuthServicesImpl();

//   Future<void> getFavouriteProduct() async {
//     emit(FavouriteLoading());
//     try {
//       final favouriteProducts = await favouriteServices.getFavourite(
//         userId: authServices.currentUser()!.uid,
//       );
//       emit(FavouriteLoaded(favouriteProduct: favouriteProducts));
//     } catch (er) {
//       emit(FavouriteError(errorMessage: er.toString()));
//     }
//   }

//   Future<void> removeFavourite(String productId, BuildContext context) async {
//     emit(FavouriteRemoveing(productId: productId));
//     try {
//       final favouriteProducts = await favouriteServices.getFavourite(
//         userId: authServices.currentUser()!.uid,
//       );
//       await favouriteServices.removeFavourite(
//           userId: authServices.currentUser()!.uid, productId: productId);
//       emit(FavouriteRemoved(productId: productId));
//       emit(FavouriteLoaded(favouriteProduct: favouriteProducts));
//       // BlocProvider.of<FavouriteCubit>(context).getFavouriteProduct();
//     } catch (er) {
//       emit(FavouriteRemoveError(errMessage: er.toString()));
//     }
//   }
// }

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

  Future<void> removeFavorite(String productId) async {
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
      emit(FavouriteLoaded(favouriteProduct: favoriteProducts));
    } catch (e) {
      emit(FavouriteRemoveError(errMessage: e.toString()));
    }
  }
}
