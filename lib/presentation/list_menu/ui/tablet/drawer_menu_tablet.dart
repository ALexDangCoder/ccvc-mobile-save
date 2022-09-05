import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/list_menu/bloc/list_menu_cubit.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/tablet/widgetTablet/item_drawer_menu_tablet.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/tablet/widgetTablet/item_dropdown_menu_tablet.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseMenuTablet extends StatefulWidget {
  final Animation<Offset> offsetAnimation;
  final String title;
  final String image;

  // const ModelMenuCCVC({Key? key}) : super(key: key);
  const BaseMenuTablet(this.offsetAnimation, this.title, this.image, {Key? key})
      : super(key: key);

  @override
  _BaseMenuPhoneState createState() => _BaseMenuPhoneState();
}

class _BaseMenuPhoneState extends State<BaseMenuTablet> {
  late ListMenuCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ListMenuCubit();
  }

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
                  position: widget.offsetAnimation,
                  child: Scaffold(
                    backgroundColor: fontColor,
                    appBar: AppBarDefaultClose(widget.title, fontColorTablet2),
                    body: SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 17, right: 7, top: 25),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: List.generate(
                                  _cubit.menuItems.length,
                                  (index) => ItemDrawerMenuTablet(
                                    _cubit,
                                    _cubit.img[index],
                                    _cubit.menuItems[index].menuTitle,
                                    index,
                                  ),
                                ),
                              ),
                              // ListView.builder(
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   itemCount: _cubit.menuItems.length,
                              //   itemBuilder: (context, index) {
                              //     return ItemDrawerMenuTablet(
                              //         _cubit,
                              //         _cubit.img[index],
                              //         _cubit.menuItems[index].menuTitle,
                              //         index);
                              //   },
                              // ),
                              if (_cubit.menuItems.isEmpty)
                                const SizedBox()
                              else
                                Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 25, top: 8),
                                  height: 1,
                                  color: containerColorTab,
                                ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _cubit.menuItems.length,
                                itemBuilder: (context, index) {
                                  return ItemDropDownMenuTablet(
                                    image: _cubit.img[index],
                                    title: _cubit.menuItems[index].menuTitle,
                                    cubit: _cubit,
                                    index: index,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
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

// Navigator.push(
// context,
// PageRouteBuilder(
// reverseTransitionDuration:
// const Duration(milliseconds: 250),
// transitionDuration: const Duration(milliseconds: 250),
// pageBuilder: (_, animation, ___) {
// const begin = Offset(-1.0, 0.0);
// const end = Offset.zero;
// final tween = Tween(begin: begin, end: end);
// final offsetAnimation = animation.drive(tween);
// return ModelMenuCCVC(offsetAnimation, 'Họp');
// },
// opaque: false,
// ),
// );
