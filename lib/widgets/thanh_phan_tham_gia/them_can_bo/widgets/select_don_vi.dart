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
  final bool isDonVi;
  final String? hintText;
  final ThanhPhanThamGiaCubit cubit;
  final ThemDonViCubit themDonViCubit;
  final bool isRequire;

  const SelectDonVi({
    Key? key,
    required this.onChange,
    this.title,
    this.hintText,
    required this.cubit,
    required this.themDonViCubit,
    this.isRequire = false,
    required this.isDonVi,
  }) : super(key: key);

  @override
  State<SelectDonVi> createState() => _SelectDonViState();
}

class _SelectDonViState extends State<SelectDonVi> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isRequire)
          Row(
            children: [
              Text(
                widget.title ?? S.current.don_vi_phong_ban,
                style: tokenDetailAmount(
                  fontSize: 14.0.textScale(),
                  color: titleItemEdit,
                ),
              ),
              const Text(
                ' *',
                style: TextStyle(color: canceledColor),
              )
            ],
          )
        else
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
                Expanded(
                  child: title(),
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
          searchController: searchController,
          themDonViCubit: widget.themDonViCubit,
        ),
      ).then((value) {
        if (value != null) {
          widget.cubit.nodeDonViThemCanBo = value;
          widget.onChange(value.value);
          setState(() {});
        }
      });
    } else {
      showDiaLogTablet<Node<DonViModel>>(
        context,
        title: S.current.chon_thanh_phan_tham_gia,
        child: TreeDonVi(
          searchController: searchController,
          themDonViCubit: widget.themDonViCubit,
        ),
        isBottomShow: true,
        funcBtnOk: () {
          Navigator.pop(context, widget.themDonViCubit.selectNodeOnlyValue);
        },
      ).then((value) {
        if (value != null) {
          widget.cubit.nodeDonViThemCanBo = value;
          widget.onChange(value.value);
          setState(() {});
        }
      });
    }
  }

  Widget title() {
    if (widget.cubit.nodeDonViThemCanBo == null) {
      return Text(
        widget.hintText ?? S.current.chon_don_vi_phong_ban,
        style: textNormal(titleItemEdit.withOpacity(0.5), 14.0.textScale()),
      );
    } else {
      final Node<DonViModel> nodeDonVi = widget.cubit.nodeDonViThemCanBo!;
      String text = '';
      if (nodeDonVi.children.isEmpty) {
        text = nodeDonVi.value.name;
      }
      text = '${nodeDonVi.value.name} (${nodeDonVi.children.length})';
      return Text(
        text,
        style: textNormal(textTitle, 14.0.textScale()),
      );
    }
  }
}

class TreeDonVi extends StatelessWidget {
  final ThemDonViCubit themDonViCubit;
  final TextEditingController? searchController;

  const TreeDonVi({
    Key? key,
    required this.themDonViCubit,
    this.searchController,
  }) : super(key: key);

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
            controller: searchController,
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
                onClickLeft: () {
                  Navigator.pop(context);
                },
                onClickRight: () {
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
