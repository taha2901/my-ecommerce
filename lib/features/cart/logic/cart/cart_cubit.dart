import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/services/auth_services.dart';
import 'package:ecommerce_app/core/services/cart_services.dart';
import 'package:ecommerce_app/features/home/data/add_to_cart.dart';
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
//       final currentUser = authServices.currentUser();
//       final cartItems = await cartServices.fetchCartItems(currentUser!.uid);

//       emit(CartLoaded(cartItems, _subtotal(cartItems)));
//     } catch (e) {
//       emit(CartError(e.toString()));
//     }
//   }

//   Future<void> incrementCounter(AddToCartModel cartItem,
//       [int? initialValue]) async {
//     if (initialValue != null) {
//       quantity = initialValue;
//     }
//     quantity++;
//     try {
//       emit(QuantityCounterLoading());
//       final updatedCartItem = cartItem.copyWith(quantity: quantity);
//       final currentUser = authServices.currentUser();

//       await cartServices.setCartItem(currentUser!.uid, updatedCartItem);
//       emit(QuantityCounterLoaded(
//         value: quantity,
//         productId: updatedCartItem.product.id,
//       ));
//       final cartItems = await cartServices.fetchCartItems(currentUser.uid);
//       emit(SubtotalUpdated(_subtotal(cartItems)));
//     } catch (e) {
//       emit(QuantityCounterError(e.toString()));
//     }
//   }

//   Future<void> decrementCounter(AddToCartModel cartItem,
//       [int? initialValue]) async {
//     if (initialValue != null) {
//       quantity = initialValue;
//     }
//     quantity--;
//     try {
//       emit(QuantityCounterLoading());
//       final updatedCartItem = cartItem.copyWith(quantity: quantity);
//       final currentUser = authServices.currentUser();

//       await cartServices.setCartItem(currentUser!.uid, updatedCartItem);
//       emit(QuantityCounterLoaded(
//         value: quantity,
//         productId: updatedCartItem.product.id,
//       ));
//       final cartItems = await cartServices.fetchCartItems(currentUser.uid);
//       emit(SubtotalUpdated(_subtotal(cartItems)));
//     } catch (e) {
//       emit(QuantityCounterError(e.toString()));
//     }
//   }

//   double _subtotal(List<AddToCartModel> cartItems) => cartItems.fold<double>(
//       0,
//       (previousValue, item) =>
//           previousValue + (item.product.price * item.quantity));
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
    
    await _updateCartItemQuantity(cartItem, quantity);
  }

  Future<void> decrementCounter(AddToCartModel cartItem,
      [int? initialValue]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    
    if (quantity > 1) {
      quantity--;
      await _updateCartItemQuantity(cartItem, quantity);
    }
  }

  // دالة مشتركة لتحديث الكمية
  Future<void> _updateCartItemQuantity(AddToCartModel cartItem, int newQuantity) async {
    try {
      emit(QuantityCounterLoading());
      final updatedCartItem = cartItem.copyWith(quantity: newQuantity);
      final currentUser = authServices.currentUser();

      await cartServices.setCartItem(currentUser!.uid, updatedCartItem);
      emit(QuantityCounterLoaded(
        value: newQuantity,
        productId: updatedCartItem.product.id,
      ));
      
      // تحديث الكارت بالكامل
      await getCartItems();
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  // حذف عنصر من الكارت
  Future<void> removeFromCart(AddToCartModel cartItem) async {
    try {
      emit(CartItemRemoving(cartItem.product.id));
      final currentUser = authServices.currentUser();
      
      await cartServices.removeFromCart(currentUser!.uid, cartItem.id);
      
      emit(CartItemRemoved(cartItem.product.id));
      
      // تحديث الكارت بعد الحذف
      await getCartItems();
    } catch (e) {
      emit(CartError("Error removing item: $e"));
    }
  }

  // حذف كل العناصر من الكارت
  Future<void> clearCart() async {
    try {
      emit(CartLoading());
      final currentUser = authServices.currentUser();
      
      await cartServices.clearCart(currentUser!.uid);
      
      emit(CartLoaded([], 0.0));
    } catch (e) {
      emit(CartError("Error clearing cart: $e"));
    }
  }

  double _subtotal(List<AddToCartModel> cartItems) => cartItems.fold<double>(
      0,
      (previousValue, item) =>
          previousValue + (item.product.price * item.quantity));
}