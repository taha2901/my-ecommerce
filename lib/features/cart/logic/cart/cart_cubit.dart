import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/services/auth_services.dart';
import 'package:ecommerce_app/core/services/cart_services.dart';
import 'package:ecommerce_app/features/home/data/add_to_cart.dart';
import 'package:ecommerce_app/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(CartInitial());

//   int quantity = 1;
//   final cartServices = CartServicesImp();
//   final authServices = AuthServicesImpl();

//   Future<void> getCartItems() async {
//     emit(CartLoading());
//     try {
//       final subTotal = dummyCart.fold<double>(
//         0,
//         (previousValue, item) =>
//             previousValue + (item.product.price * item.quantity),
//       );
//       final currentUser = authServices.currentUser();
//       final cartItems = await cartServices.fetchCartItems(currentUser!.uid);
//       emit(CartLoaded(cartItems, subTotal));
//     } catch (e) {
//       emit(state);
//     }
//   }

//   Future<void> incrementCounter(AddToCartModel cartItem,
//       [int? initialValue]) async {
//     //في حال تمرير initialValue، سيتم استخدامه بدلاً من القيمة الحالية.
//     if (initialValue != null) quantity = initialValue;
//     quantity++;
//     try {
//       emit(QuantityCounterLoading());
//       final updatedCartItem = cartItem.copyWith(quantity: quantity);
//       final currentUser = authServices.currentUser()!.uid;
//       await cartServices.setCartItem(currentUser, updatedCartItem);

//       emit(QuantityCounterLoaded(
//           value: quantity, productId: updatedCartItem.product.id));
//       final cartItems = await cartServices.fetchCartItems(currentUser);
//       emit(SubTotalUpdated(_subTotal(cartItems)));
//     } catch (e) {
//       emit(QuantityCounterError(errMessage: e.toString()));
//     }
//   }

//   Future<void> decrementCounter(AddToCartModel cartItem,
//       [int? initialValue]) async {
//     if (initialValue != null) quantity = initialValue;
//     quantity--;
//     try {
//       emit(QuantityCounterLoading());
//       final updatedCartItem = cartItem.copyWith(quantity: quantity);
//       final currentUser = authServices.currentUser()!.uid;
//       await cartServices.setCartItem(currentUser, updatedCartItem);

//       emit(QuantityCounterLoaded(
//           value: quantity, productId: updatedCartItem.product.id));
//       final cartItems = await cartServices.fetchCartItems(currentUser);
//       emit(SubTotalUpdated(_subTotal(cartItems)));
//     } catch (e) {
//       emit(QuantityCounterError(errMessage: e.toString()));
//     }
//   }

//   double _subTotal(List<AddToCartModel> cartItems) => dummyCart.fold<double>(
//         0,
//         (previousValue, item) =>
//             previousValue + (item.product.price * item.quantity),
//       );
// }




class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  final cartServices = CartServicesImp();
  final authServices = AuthServicesImpl();

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      final currentUser = authServices.currentUser();
      final cartItems = await cartServices.fetchCartItems(currentUser!.uid);

      emit(CartLoaded(cartItems, _subtotal(cartItems)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> incrementCounter(AddToCartModel cartItem,
      [int? initialValue]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    try {
      emit(QuantityCounterLoading());
      final updatedCartItem = cartItem.copyWith(quantity: quantity);
      final currentUser = authServices.currentUser();

      await cartServices.setCartItem(currentUser!.uid, updatedCartItem);
      emit(QuantityCounterLoaded(
        value: quantity,
        productId: updatedCartItem.product.id,
      ));
      final cartItems = await cartServices.fetchCartItems(currentUser.uid);
      emit(SubtotalUpdated(_subtotal(cartItems)));
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  Future<void> decrementCounter(AddToCartModel cartItem,
      [int? initialValue]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity--;
    try {
      emit(QuantityCounterLoading());
      final updatedCartItem = cartItem.copyWith(quantity: quantity);
      final currentUser = authServices.currentUser();

      await cartServices.setCartItem(currentUser!.uid, updatedCartItem);
      emit(QuantityCounterLoaded(
        value: quantity,
        productId: updatedCartItem.product.id,
      ));
      final cartItems = await cartServices.fetchCartItems(currentUser.uid);
      emit(SubtotalUpdated(_subtotal(cartItems)));
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  double _subtotal(List<AddToCartModel> cartItems) => cartItems.fold<double>(
      0,
      (previousValue, item) =>
          previousValue + (item.product.price * item.quantity));
}