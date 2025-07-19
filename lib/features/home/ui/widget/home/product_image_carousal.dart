import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/home/data/home_carousal_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class ProductImageCarousel extends StatelessWidget {
  final dynamic state;
  const ProductImageCarousel({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return FlutterCarousel.builder(
      itemCount: dummyHomeCarouselItems.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: CachedNetworkImage(
          imageUrl: dummyHomeCarouselItems[itemIndex].imgUrl,

          fit: BoxFit.fill, 
          width: screenWidth, 
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
      options: FlutterCarouselOptions(
        height: 200,
        showIndicator: true,
        autoPlay: true,
        viewportFraction: 1, 
        slideIndicator:  CircularWaveSlideIndicator(),
      ),
    );
  }
}
