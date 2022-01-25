import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_widget/widgets/select_don_vi_widget.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_widget/widgets/tree_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemDonViWidget extends StatefulWidget {
  final Function(List<Node<DonViModel>>) onChange;
  final List<Node<DonViModel>> listSelectNode;
  const ThemDonViWidget({
    Key? key,
    required this.onChange,
    this.listSelectNode = const [],
  }) : super(key: key);

  @override
  State<ThemDonViWidget> createState() => _ThemDonViScreenState();
}

class _ThemDonViScreenState extends State<ThemDonViWidget> {
  final ThemDonViCubit _themDonViCubit = ThemDonViCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _themDonViCubit.getTreeDonVi();
    });
  }

  @override
  void didUpdateWidget(covariant ThemDonViWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _themDonViCubit.initSelectNode(widget.listSelectNode);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _themDonViCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheetCustom<List<Node<DonViModel>>>(
          context,
          title: S.current.chon_thanh_phan_tham_gia,
          child: TreeDonVi(
            themDonViCubit: _themDonViCubit,
          ),
        ).then((value) {
          if (value != null) {
            widget.onChange(value);
          }
          _themDonViCubit.onSearch('');
        });
      },
      child: Container(
        width: 136,
        padding: const EdgeInsets.only(right: 18, left: 12, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: buttonColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(ImageAssets.icThemDonVi),
            const SizedBox(
              width: 8,
            ),
            Text(
              S.current.them_don_vi,
              style: textNormalCustom(color: labelColor, fontSize: 14),
            )
          ],
        ),
      ),
    );
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
          const SizedBox(
            height: 20,
          ),
          SelectSearchDonViWidget(
            themDonViCubit: themDonViCubit,
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.danh_sach_don_vi_tham_gia,
                  style: textNormal(textTitle, 16),
                ),
                const SizedBox(
                  height: 22,
                ),
                Expanded(
                  child: StreamBuilder<List<Node<DonViModel>>>(
                    stream: themDonViCubit.getTree,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? <Node<DonViModel>>[];
                      if (data.isNotEmpty) {
                        return SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            children: List.generate(
                              data.length,
                              (index) => TreeViewWidget(
                                themDonViCubit: themDonViCubit,
                                node: data[index],
                              ),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children:const [
                          NodataWidget()
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.them,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                Navigator.pop(context, themDonViCubit.selectNode);
              },
            ),
          )
        ],
      ),
    );
  }
}
