import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/services/auth_services.dart';
import 'package:ecommerce_app/core/services/product_details_services.dart';
import 'package:ecommerce_app/features/home/data/add_to_cart.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  ProductSize? selectedSize;
  int quantity = 1;

  final productDetailsSercices = ProductDetailsServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getProductDetails(String id) async {
    emit(ProductDetailsLoading());

    try {
      final selectedProduct =
          await productDetailsSercices.fetchProductDetails(id);

      emit(ProductDetailsLoaded(product: selectedProduct));
    } catch (e) {
      emit(ProductDetailsError(message: "Error: $e"));
    }
  }

  void incrementCounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void selectSize(ProductSize size) {
    selectedSize = size;
    emit(SizeSelected(size: size));
  }

  Future<void> addToCart(String productId, BuildContext context) async {
    emit(ProductAddingToCart());
    try {
      final selectedProduct = await productDetailsSercices.fetchProductDetails(
        productId,
      );

      final cartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        product: selectedProduct,
        size: selectedSize!,
        quantity: quantity,
      );

      debugPrint("Adding to cart: ${cartItem.product.name}");

      await productDetailsSercices.addToCart(
          cartItem, authServices.currentUser()!.uid);

      debugPrint("Product added to cart successfully");

      emit(ProductAddedToCart(productId: productId));
    } catch (e) {
      debugPrint("Error adding to cart: $e");
      emit(ProductAddedToCartError(message: "Error: $e"));
    }
  }
}
