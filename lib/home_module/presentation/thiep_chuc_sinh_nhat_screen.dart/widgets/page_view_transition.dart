import 'package:carousel_slider/carousel_slider.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  final List<String> listImage;
  final Function(int) onSelect;
  final double viewportFraction;

  const PageViewWidget(
      {Key? key,
      required this.listImage,
      required this.onSelect,
      this.viewportFraction = 0.6})
      : super(key: key);

  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
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
      items: List.generate(widget.listImage.length, (index) {
        final data = widget.listImage[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: index == indexSelect ? linkColor : Colors.transparent,
                width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: pageCell(data),
        );
      }),
      options: CarouselOptions(
        onPageChanged: (index, _) {
          indexSelect = index;
          widget.onSelect(index);
          setState(() {});
        },
        enlargeCenterPage: true,
        viewportFraction: widget.viewportFraction,
        aspectRatio: 1.0,
      ),
    );
  }

  Widget pageCell(String url) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.white, width: 4),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
