part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLoading extends FavouriteState {}

final class FavouriteLoaded extends FavouriteState {
  final List<ProductItemModel> favouriteProduct;

  FavouriteLoaded({required this.favouriteProduct});
}

final class FavouriteError extends FavouriteState {
  final String errorMessage;

  FavouriteError({required this.errorMessage});
}

final class FavouriteRemoved extends FavouriteState {
  final String productId;

  FavouriteRemoved({required this.productId});
}

final class FavouriteRemoveing extends FavouriteState {
  final String productId;

  FavouriteRemoveing({required this.productId});
}

final class FavouriteRemoveError extends FavouriteState {
  final String errMessage;

  FavouriteRemoveError({required this.errMessage});
}
