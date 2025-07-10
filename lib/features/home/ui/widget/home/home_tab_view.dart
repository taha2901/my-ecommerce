import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/features/home/logic/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/features/home/ui/widget/home/product_image_carousal.dart';
import 'package:ecommerce_app/features/home/ui/widget/home/product_item.dart';
import 'package:ecommerce_app/features/home/ui/widget/home/see_all_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      bloc:  homeCubit,
      buildWhen: (previous, current) =>  current is HomeError || current is HomeLoaded || current is HomeLoading,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ProductImageCarousel(
                  state: state,
                ),
                const SizedBox(height: 24.0),
                SeeAllSectionHeader(),
                const SizedBox(height: 16.0),
                GridView.builder(
                  itemCount: state.products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    // debugPrint('state.products[index].id: ${state.products[index].id}');
                    return InkWell(
                      onTap: () {
                        //  debugPrint('state.products[index].id: ${state.products[index].id}');
                        Navigator.of(context, rootNavigator: true).pushNamed(
                            Routers.productDetailsRoute,
                            arguments:  state.products[index].id);
                      },
                      child: ProductItem(
                        productItem: state.products[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(
            child: Text(
              state.errMessage,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
