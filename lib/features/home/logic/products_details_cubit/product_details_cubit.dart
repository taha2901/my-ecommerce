import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/services/auth_services.dart';
import 'package:ecommerce_app/core/services/cart_services.dart';
import 'package:ecommerce_app/core/services/product_details_services.dart';
import 'package:ecommerce_app/features/cart/logic/cart/cart_cubit.dart';
import 'package:ecommerce_app/features/home/data/add_to_cart.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

// class ProductDetailsCubit extends Cubit<ProductDetailsState> {
//   ProductDetailsCubit() : super(ProductDetailsInitial());
//   ProductSize? selectedSize;
//   int quantity = 1;

//   final productDetailsSercices = ProductDetailsServicesImpl();
//   final authServices = AuthServicesImpl();

//   Future<void> getProductDetails(String id) async {
//     emit(ProductDetailsLoading());

//     try {
//       final selectedProduct =
//           await productDetailsSercices.fetchProductDetails(id);

//       emit(ProductDetailsLoaded(product: selectedProduct));
//     } catch (e) {
//       emit(ProductDetailsError(message: "Error: $e"));
//     }
//   }

//   void incrementCounter(String productId) {
//     quantity++;
//     emit(QuantityCounterLoaded(value: quantity));
//   }

//   void decrementCounter(String productId) {
//     quantity--;
//     emit(QuantityCounterLoaded(value: quantity));
//   }

//   void selectSize(ProductSize size) {
//     selectedSize = size;
//     emit(SizeSelected(size: size));
//   }

//   Future<void> addToCart(String productId, BuildContext context) async {
//     emit(ProductAddingToCart());
//     try {
//       final selectedProduct = await productDetailsSercices.fetchProductDetails(
//         productId,
//       );

//       final cartItem = AddToCartModel(
//         id: DateTime.now().toIso8601String(),
//         product: selectedProduct,
//         size: selectedSize!,
//         quantity: quantity,
//       );

//       debugPrint("Adding to cart: ${cartItem.product.name}");

//       await productDetailsSercices.addToCart(
//           cartItem, authServices.currentUser()!.uid);

//       debugPrint("Product added to cart successfully");
//       BlocProvider.of<CartCubit>(context).getCartItems();

//       emit(ProductAddedToCart(productId: productId));
//     } catch (e) {
//       debugPrint("Error adding to cart: $e");
//       emit(ProductAddedToCartError(message: "Error: $e"));
//     }
//   }
// }



class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSize? selectedSize;
  int quantity = 1;
  List<AddToCartModel> currentCartItems = []; // لحفظ العناصر الحالية في الكارت

  final productDetailsSercices = ProductDetailsServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getProductDetails(String id) async {
    emit(ProductDetailsLoading());

    try {
      final selectedProduct =
          await productDetailsSercices.fetchProductDetails(id);
      
      // جلب عناصر الكارت الحالية للتحقق من وجود المنتج
      await _loadCurrentCartItems();
      
      emit(ProductDetailsLoaded(product: selectedProduct));
    } catch (e) {
      emit(ProductDetailsError(message: "Error: $e"));
    }
  }

  // جلب العناصر الحالية في الكارت
  Future<void> _loadCurrentCartItems() async {
    try {
      final currentUser = authServices.currentUser();
      if (currentUser != null) {
        final cartServices = CartServicesImp();
        currentCartItems = await cartServices.fetchCartItems(currentUser.uid);
      }
    } catch (e) {
      debugPrint("Error loading cart items: $e");
    }
  }

  // التحقق من وجود المنتج في الكارت مع نفس الحجم
  bool isProductInCart(String productId, ProductSize size) {
    return currentCartItems.any((item) => 
        item.product.id == productId && item.size == size);
  }

  void incrementCounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    if (quantity > 1) {
      quantity--;
      emit(QuantityCounterLoaded(value: quantity));
    }
  }

  void selectSize(ProductSize size) {
    selectedSize = size;
    emit(SizeSelected(size: size));
  }

  Future<void> addToCart(String productId, BuildContext context) async {
    if (selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select size')),
      );
      return;
    }

    // التحقق من وجود المنتج مع نفس الحجم في الكارت
    if (isProductInCart(productId, selectedSize!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This product with size ${selectedSize!.name} is already in your cart'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

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
      
      // إضافة المنتج للقائمة المحلية
      currentCartItems.add(cartItem);
      
      // تحديث الكارت في الصفحة الأخرى
      final cartCubit = BlocProvider.of<CartCubit>(context);
      await cartCubit.getCartItems();

      emit(ProductAddedToCart(productId: productId));
      
      // إظهار رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added to cart successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint("Error adding to cart: $e");
      emit(ProductAddedToCartError(message: "Error: $e"));
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product to cart: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // إعادة تعيين القيم عند مغادرة الصفحة
  void resetValues() {
    selectedSize = null;
    quantity = 1;
    currentCartItems.clear();
  }
}