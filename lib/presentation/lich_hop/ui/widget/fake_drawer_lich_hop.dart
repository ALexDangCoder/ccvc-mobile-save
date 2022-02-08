import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FakeDrawerLichHop extends StatelessWidget {
  final Animation<Offset> offsetAnimation;
  final String title1;
  final String image1;
  final String title2;
  final String image2;
  final String title3;
  final String image3;
  final Function ontap1;
  final Function ontap2;
  final Function ontap3;

  const FakeDrawerLichHop({
    Key? key,
    required this.title1,
    required this.image1,
    required this.title2,
    required this.image2,
    required this.title3,
    required this.image3,
    required this.ontap1,
    required this.ontap2,
    required this.ontap3,
    required this.offsetAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                color: backgroundDrawer,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: SafeArea(
                   child: Scaffold(
                     backgroundColor: backgroundDrawerMenu,
                     body: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        GestureDetector(
                          onTap: (){
                            ontap1();
                          },
                          child: Row(
                            children: [
                              IconButton(onPressed: (){

                              }, icon: SvgPicture.asset(image1)),
                              Text(title1),

                            ],
                          ),
                        ),
                         GestureDetector(
                           onTap: (){
                             ontap2();
                           },
                           child: Row(
                             children: [
                               IconButton(onPressed: (){

                               }, icon: SvgPicture.asset(image2)),
                               Text(title2),

                             ],
                           ),
                         ),
                         GestureDetector(
                           onTap: (){
                             ontap3();
                           },
                           child: Row(
                             children: [
                               IconButton(onPressed: (){

                               }, icon: SvgPicture.asset(image3)),
                               Text(title3),

                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                child: Container(color: backgroundDrawer),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
