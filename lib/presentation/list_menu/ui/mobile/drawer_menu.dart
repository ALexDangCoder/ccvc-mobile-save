import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/menu_item_model.dart';
import 'package:ccvc_mobile/presentation/list_menu/bloc/list_menu_cubit.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/mobile/widget/item_drawer_menu.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/mobile/widget/item_dropdown_menu.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseMenuPhone extends StatefulWidget {
  final Animation<Offset> offsetAnimation;
  final String title;
  final String image;
  List<String> iconDrawer = [];
  List<String> iconDropdown = [];
  List<MenuItemSchedule> listDrawer = [];
  List<MenuItemSchedule> listDropdown = [];
  final Function(String)? onSelectItem;

  // const ModelMenuCCVC({Key? key}) : super(key: key);
  BaseMenuPhone(
    this.listDropdown,
    this.listDrawer,
    this.offsetAnimation,
    this.title,
    this.image,
    this.onSelectItem,
    this.iconDrawer,
    this.iconDropdown, {
    Key? key,
  }) : super(key: key);

  @override
  _BaseMenuPhoneState createState() => _BaseMenuPhoneState();
}

class _BaseMenuPhoneState extends State<BaseMenuPhone> {
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
                    backgroundColor: backgroundDrawerMenu,
                    appBar: AppBar(
                      elevation: 0,
                      title: Text(
                        widget.title,
                        style: textNormalCustom(fontSize: 14.0.textScale()),
                      ),
                      backgroundColor: backgroundDrawerMenu,
                      leading: Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: SvgPicture.asset(widget.image),
                            onPressed: () {},
                          );
                        },
                      ),
                    ),
                    body: SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 17, right: 7, top: 25),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: widget.listDrawer.length,
                                itemBuilder: (context, index) {
                                  return ItemDrawerMenu(
                                    _cubit,
                                    widget.iconDrawer[index],
                                    widget.listDrawer[index].menuTitle,
                                    index,
                                    onSelectItem: (value) {
                                      widget.onSelectItem!(value);
                                    },
                                  );
                                },
                              ),
                              if (_cubit.menuItems.isEmpty)
                                const SizedBox()
                              else
                                Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 25, top: 8),
                                  height: 1,
                                  color: containerColor,
                                ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: widget.listDropdown.length,
                                itemBuilder: (context, index) {
                                  return ItemDropDownMenu(
                                    image: widget.iconDropdown[index],
                                    title: widget.listDropdown[index].menuTitle,
                                    cubit: _cubit,
                                    index: index,
                                    onSelectItem: (value) {
                                      widget.onSelectItem!(value);
                                    },
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
