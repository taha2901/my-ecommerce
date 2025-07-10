
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:ecommerce_app/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_details/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCounterBlocBuilder extends StatelessWidget {
  const ProductCounterBlocBuilder({
    super.key,
    required this.cubit,
    required this.product,
  });

  final ProductDetailsCubit cubit;
  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit,ProductDetailsState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is QuantityCounterLoaded ||
          current is ProductDetailsLoaded,
      builder: (context, state) {
        if (state is QuantityCounterLoaded) {
          return CounterWidget(
            value: state.value,
            productId: product.id,
            
            cubit:
                BlocProvider.of<ProductDetailsCubit>(
                    context),
          );
        } else if (state is ProductDetailsLoaded) {
          return CounterWidget(
            value: 1,
            productId: state.product.id,
            cubit:
                BlocProvider.of<ProductDetailsCubit>(
                    context),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
