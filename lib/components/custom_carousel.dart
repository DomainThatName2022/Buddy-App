import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'custom_card.dart';

class CustomCarousel extends StatelessWidget {
  // const CustomCarousel({Key? key}) : super(key: key);

  final List _object;

  CustomCarousel(this._object);

  @override
  Widget build(BuildContext context) {
    final colors = ColorPalette();

    return CarouselSlider.builder(
      options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          viewportFraction: 0.5),
      itemCount: _object.length,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: _object[index],
        );
      },
    );
  }
}
