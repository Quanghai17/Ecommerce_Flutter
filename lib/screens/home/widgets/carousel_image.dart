import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/utils/global_variables.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((imageUrl) {
        return Builder(
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * .025),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width * .48,
                )),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 2500),
        autoPlayCurve: Curves.easeInOutCubic,
        scrollPhysics: const ClampingScrollPhysics(),
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 1,
        height: MediaQuery.of(context).size.width * .4,
      ),
    );
  }
}
