import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/widgets/select_don_vi_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/widgets/tree_widget.dart';
import 'package:flutter/material.dart';

class ThemDonViWidget extends StatefulWidget {
  final Function(List<Node<DonViModel>>) onChange;
  final List<DonViModel> listSelectNode;

  final ThanhPhanThamGiaCubit cubit;
  const ThemDonViWidget({
    Key? key,
    required this.onChange,
    this.listSelectNode = const [],
    required this.cubit,
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
    widget.cubit.getTreeDonVi.listen((event) {

      _themDonViCubit.getTreeDonVi(event);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _themDonViCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        showSelect();
      },
      text: S.current.them_don_vi,
      urlIcon: ImageAssets.icThemDonVi,
    );
  }

  void showSelect() {
    _themDonViCubit.initSelectNode(widget.listSelectNode);
    if (APP_DEVICE == DeviceType.MOBILE) {
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
    } else {
      showDiaLogTablet(
        context,
        title: S.current.chon_thanh_phan_tham_gia,
        child: TreeDonVi(
          themDonViCubit: _themDonViCubit,
        ),
        isBottomShow: true,
        funcBtnOk: () {
          Navigator.pop(context, _themDonViCubit.selectNode);
        },
      ).then((value) {
        if (value != null) {
          widget.onChange(value);
        }
        _themDonViCubit.onSearch('');
      });
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
          SelectSearchDonViWidget(
            themDonViCubit: themDonViCubit,
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
                title2: S.current.them,
                onPressed1: () {
                  Navigator.pop(context);
                },
                onPressed2: () {
                  Navigator.pop(context, themDonViCubit.selectNode);
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
