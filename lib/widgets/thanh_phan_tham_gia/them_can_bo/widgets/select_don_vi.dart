import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/widgets/tree_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectDonVi extends StatefulWidget {
  final Function(DonViModel) onChange;
  final String? title;
  final String? hintText;
  final ThanhPhanThamGiaCubit cubit;
  const SelectDonVi({
    Key? key,
    required this.onChange,
    this.title,
    this.hintText,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SelectDonVi> createState() => _SelectDonViState();
}

class _SelectDonViState extends State<SelectDonVi> {
  final ThemDonViCubit _themDonViCubit = ThemDonViCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   widget.cubit.getTreeDonVi.listen((event) {
     _themDonViCubit.getTreeDonVi(event);
   });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? S.current.don_vi_phong_ban,
          style: textNormal(titleItemEdit, 14.0.textScale()),
        ),
        SizedBox(
          height: 8.0.textScale(),
        ),
        GestureDetector(
          onTap: () {
            showSelect();
          },
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title(),
                  style: textNormal(textTitle, 14.0.textScale()),
                ),
                SvgPicture.asset(ImageAssets.icEditInfor)
              ],
            ),
          ),
        )
      ],
    );
  }

  void showSelect() {
    if (isMobile()) {
      showBottomSheetCustom<Node<DonViModel>>(
        context,
        title: S.current.chon_thanh_phan_tham_gia,
        child: TreeDonVi(
          themDonViCubit: _themDonViCubit,
        ),
      ).then((value) {
        if (value != null) {
          widget.onChange(value.value);
          setState(() {});
        }
      });
    } else {
      showDiaLogTablet<Node<DonViModel>>(
        context,
        title: S.current.chon_thanh_phan_tham_gia,
        child: TreeDonVi(
          themDonViCubit: _themDonViCubit,
        ),
        isBottomShow: true,
        funcBtnOk: () {
          Navigator.pop(context, _themDonViCubit.selectNodeOnlyValue);
        },
      ).then((value) {
        if (value != null) {
          widget.onChange(value.value);
          setState(() {});
        }
      });
    }
  }

  String title() {
    if (_themDonViCubit.selectNodeOnlyValue == null) {
      return widget.hintText ?? S.current.chon_don_vi_phong_ban;
    } else {
      final Node<DonViModel> nodeDonVi = _themDonViCubit.selectNodeOnlyValue!;
      if (nodeDonVi.children.isEmpty) {
        return nodeDonVi.value.name;
      }
      return '${nodeDonVi.value.name} (${nodeDonVi.children.length})';
    }
  }
}

class TreeDonVi extends StatelessWidget {
  final ThemDonViCubit themDonViCubit;
  const TreeDonVi({Key? key, required this.themDonViCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: 20.0.textScale(space: 4),
          ),
          BaseSearchBar(
            onChange: (value) {
              themDonViCubit.onSearch(value);
            },
          ),
          SizedBox(
            height: 18.0.textScale(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.danh_sach_don_vi_tham_gia,
                  style: textNormal(textTitle, 16),
                ),
                SizedBox(
                  height: 22.0.textScale(space: -9),
                ),
                Expanded(
                  child: StreamBuilder<List<Node<DonViModel>>>(
                    stream: themDonViCubit.getTree,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? <Node<DonViModel>>[];
                      if (data.isNotEmpty) {
                        return SingleChildScrollView(
                          keyboardDismissBehavior: isMobile()
                              ? ScrollViewKeyboardDismissBehavior.onDrag
                              : ScrollViewKeyboardDismissBehavior.manual,
                          child: Column(
                            children: List.generate(
                              data.length,
                              (index) => TreeViewWidget(
                                selectOnly: true,
                                themDonViCubit: themDonViCubit,
                                node: data[index],
                              ),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: const [
                          NodataWidget(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          screenDevice(
            mobileScreen: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: DoubleButtonBottom(
                title1: S.current.dong,
                title2: S.current.luu,
                onPressed1: () {
                  Navigator.pop(context);
                },
                onPressed2: () {
                  Navigator.pop(context, themDonViCubit.selectNodeOnlyValue);
                },
              ),
            ),
            tabletScreen: const SizedBox(),
          )
        ],
      ),
    );
  }
}
