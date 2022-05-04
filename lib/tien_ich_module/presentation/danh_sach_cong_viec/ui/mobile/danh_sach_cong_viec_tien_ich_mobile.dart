import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/drawer_slide/drawer_slide.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cong_viec_cua_ban_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cong_viec_da_hoan_thanh_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cv_da_hoan_thanh_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/da_bi_xoa_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/gan_cho_toi_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/nhom_cong_viec_moi_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachCongViecTienIchMobile extends StatefulWidget {
  const DanhSachCongViecTienIchMobile({Key? key}) : super(key: key);

  @override
  _DanhSachCongViecTienIchMobileState createState() =>
      _DanhSachCongViecTienIchMobileState();
}

class _DanhSachCongViecTienIchMobileState
    extends State<DanhSachCongViecTienIchMobile> {
  DanhSachCongViecTienIchCubit cubit = DanhSachCongViecTienIchCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.initialData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: cubit.titleAppBar.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBarWithTwoLeading(
              title: snapshot.data ?? S.current.cv_cua_ban,
              leadingIcon: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      ImageAssets.icBack,
                    ),
                  ),
                ],
              ),
              actions: [
                PopupMenuButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  icon: SvgPicture.asset(ImageAssets.ic_Group.svgToTheme()),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: AddToDoWidgetTienIch(
                        onTap: (value) {
                          cubit.addTodo(value);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    DrawerSlide.navigatorSlide(
                      context: context,
                      screen: MenuDSCV(
                        cubit: cubit,
                      ),
                      thenValue: (value) {},
                    );
                  },
                  icon: SvgPicture.asset(ImageAssets.icMenuCalender),
                )
              ],
            ),
            body: StreamBuilder<int>(
                stream: cubit.statusDSCV.stream,
                builder: (context, snapshotbool) {
                  return ScrollBarWidget(
                    children: [
                      BaseSearchBar(
                        hintText: S.current.tim_kiem_nhanh,
                        onChange: (value) {
                          cubit.search(value);
                        },
                      ),
                      if (snapshotbool.data == CVCB)
                        CvCuaBanWidget(
                          cubit: cubit,
                        ),
                      if (snapshotbool.data == CVQT)
                        CvQuanTrongWidget(
                          cubit: cubit,
                        ),
                      if (snapshotbool.data == DHT)
                        CongViecDaHoanThanhWidget(
                          cubit: cubit,
                        ),
                      if (snapshotbool.data == GCT)
                        GanChoToiWidget(
                          cubit: cubit,
                        ),
                      if (snapshotbool.data == DBX)
                        DaBiXoaWidget(
                          cubit: cubit,
                        ),
                      if (snapshotbool.data == NCXM)
                        NhomCvMoiWidget(
                          cubit: cubit,
                        )
                    ],
                  );
                }),
          );
        });
  }
}

class AddToDoWidgetTienIch extends StatefulWidget {
  final Function(String) onTap;

  const AddToDoWidgetTienIch({Key? key, required this.onTap}) : super(key: key);

  @override
  _AddToDoWidgetTienIchState createState() => _AddToDoWidgetTienIchState();
}

class _AddToDoWidgetTienIchState extends State<AddToDoWidgetTienIch> {
  bool isAdd = false;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.them_cong_viec,
                style: textNormalCustom(
                  color: textTitle,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 18,
                height: 18,
                child: Checkbox(
                  checkColor: Colors.white,
                  // color of tick Mark
                  activeColor: !isAdd ? sideTextInactiveColor : AppTheme.getInstance().colorField(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  side: const BorderSide(width: 1.5, color: lineColor),
                  value: true,
                  onChanged: (value) {
                    if (isAdd) {
                      widget.onTap(controller.text.trim());
                      controller.text = '';
                      focusNode.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: borderButtomColor)),
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: (value) {
                if (value.isEmpty) {
                  isAdd = false;
                } else {
                  isAdd = true;
                }
                setState(() {});
              },
              style: textNormal(infoColor, 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIconConstraints:
                    const BoxConstraints(maxWidth: 25, maxHeight: 14),
                prefixIcon: Container(
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      ImageAssets.icEdit,
                      width: 14,
                      height: 14,
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                isDense: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
