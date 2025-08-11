import 'package:ecommerce_app/core/widget/custom_app_bar.dart';
import 'package:ecommerce_app/core/widget/spacing.dart';
import 'package:ecommerce_app/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/error_state_widget.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/favourite_empty.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/header_section.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/loaded_state_widget.dart';
import 'package:ecommerce_app/features/favourite/ui/widget/loading_states_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavouriteCubit>(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            const CustomHomeHeader(),
            verticalSpace(16),
            // Header Section
            HeaderSection(
              context: context,
            ),
            verticalSpace(16),
            // Content Section
            Expanded(
              child: BlocBuilder<FavouriteCubit, FavouriteState>(
                bloc: favoriteCubit,
                // إزالة buildWhen عشان يسمع لكل التغييرات
                builder: (context, state) {
                  return _buildContent(context, state, favoriteCubit);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    FavouriteState state,
    FavouriteCubit favoriteCubit,
  ) {
    if (state is FavouriteLoading) {
      return LoadingStatesWidget();
    } else if (state is FavouriteLoaded) {
      final favoriteProducts = state.favouriteProduct;
      if (favoriteProducts.isEmpty) {
        return FavouriteEmpty(
          onStartShopping: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      }
      return LoadedStateWidget( favoriteProducts:  favoriteProducts,favoriteCubit:  favoriteCubit);
    } else if (state is FavouriteError) {
      return ErrorStateWidget(errorMessage: state.errorMessage);
    }
    return const SizedBox.shrink();
  }
}
