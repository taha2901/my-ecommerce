
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class ProductImageCarousel extends StatelessWidget {
  final dynamic state ;
  const ProductImageCarousel({
    super.key, required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: state.carouselItems.length,
      itemBuilder: (BuildContext context, int itemIndex,
              int pageViewIndex) =>
          Padding(
        padding: const EdgeInsetsDirectional.only(end: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CachedNetworkImage(
            imageUrl: state.carouselItems[itemIndex].imgUrl,
            fit: BoxFit.fill,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        ),
      ),
      options: FlutterCarouselOptions(
        height: 200,
        showIndicator: true,
        autoPlay: true,
        slideIndicator: CircularWaveSlideIndicator(),
      ),
    );
  }
}
