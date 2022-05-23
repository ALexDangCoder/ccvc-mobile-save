import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewWidget extends StatefulWidget {
  final PageController pageController;

  const PageViewWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  final List<String> listImg = [
    'https://photo-cms-baonghean.zadn.vn/w607/Uploaded/2022/ftgbtgazsnzm/2020_07_14/ngoctrinhmuonsinhcon1_swej7996614_1472020.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR46vbIeWnWTrhYxLuEzN9ih1eb7xjCsp1rE2fMJ88Ln11VrzGUhSwcSUu4eDFiU-9zRCU&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwyzVlWrslUqyK4NtmPxvyu1FXt6bRyL1kbh-Pl4nV7PdedmSAmkoADHL_gFGoke7baKY&usqp=CAU'
  ];
  double viewportFraction = 0.4;
  double? pageOffset = 0;
  CarouselController controller = CarouselController();
  int indexSelect = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: controller,
      items: List.generate(
          listImg.length,
          (index) => Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                    border: Border.all(
                     color: Colors.white,width: 4),
                    image: DecorationImage(
                        image: NetworkImage(listImg[index]),
                        fit: BoxFit.cover)),
              )),
      options: CarouselOptions(
        onPageChanged: (index, _) {
          indexSelect = index;
          setState(() {});
        },
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
        aspectRatio: 1.0,
        initialPage: 0,
      ),
    );
  }
}
