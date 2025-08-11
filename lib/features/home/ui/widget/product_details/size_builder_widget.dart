
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:ecommerce_app/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeBuilderWidget extends StatelessWidget {
  const SizeBuilderWidget({
    super.key,
    required this.cubit,
  });

  final ProductDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is SizeSelected ||
          current is ProductDetailsLoaded,
      builder: (context, state) {
        return Row(
          children: ProductSize.values
              .map(
                (size) => Padding(
                  padding: const EdgeInsets.only(
                      top: 6.0, right: 8.0),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<
                                  ProductDetailsCubit>(
                              context)
                          .selectSize(size);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state is SizeSelected &&
                                state.size == size
                            ? Theme.of(context)
                                .primaryColor
                            : AppColors.grey2,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(12.0),
                        child: Text(
                          size.name,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                color:
                                    state is SizeSelected &&
                                            state.size ==
                                                size
                                        ? AppColors.white
                                        : AppColors.black,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

