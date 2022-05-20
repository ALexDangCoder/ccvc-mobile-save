import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/cupertino_loading.dart';
import 'package:ccvc_mobile/widgets/dialog/modal_progress_hud.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_state.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/widgets/can_bo_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/widgets/select_don_vi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemCanBoWidget extends StatefulWidget {
  final Function(List<DonViModel>) onChange;
  final ThanhPhanThamGiaCubit cubit;
  const ThemCanBoWidget({
    Key? key,
    required this.onChange,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThemCanBoWidget> createState() => _ThemDonViScreenState();
}

class _ThemDonViScreenState extends State<ThemCanBoWidget> {
  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        selectButton();
      },
      text: S.current.them_can_bo,
      urlIcon: ImageAssets.icThemCanBo,
    );
  }

  void selectButton() {
    if (isMobile()) {
      showBottomSheetCustom<List<DonViModel>>(
        context,
        title: S.current.chon_thanh_phan_tham_gia,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ThemCanBoScreen(
            cubit: widget.cubit,
          ),
        ),
      ).then((value) {
        if (value != null) {
          widget.onChange(value);
        }
      });
    } else {
      showDiaLogTablet(
        context,
        title: S.current.chon_thanh_phan_tham_gia,
        child: ThemCanBoScreen(
          cubit: widget.cubit,
        ),
        isBottomShow: false,
        funcBtnOk: () {},
        maxHeight: 841,
      ).then((value) {
        if (value != null) {
          widget.onChange(value);
        }
      });
    }
  }
}

class ThemCanBoScreen extends StatefulWidget {
  final ThanhPhanThamGiaCubit cubit;
  const ThemCanBoScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _ThemCanBoScreenState createState() => _ThemCanBoScreenState();
}

class _ThemCanBoScreenState extends State<ThemCanBoScreen> {
  final ThemCanBoCubit _themCanBoCubit = ThemCanBoCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _themCanBoCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0.textScale(space: 4),
          ),
          SelectDonVi(
            cubit: widget.cubit,
            onChange: (value) {
              _themCanBoCubit.getCanBo(value);
            },
          ),
          SizedBox(
            height: 20.0.textScale(space: 4),
          ),
          Text(
            S.current.danh_sach_don_vi_tham_gia,
            style: textNormal(color3D5586, 16),
          ),
          spaceH16,
          BaseSearchBar(
            hintText: S.current.nhap_ten_don_vi_phong_ban,
            onChange: (value) {
              _themCanBoCubit.search(value);
            },
          ),
          spaceH16,
          Expanded(
            child: BlocBuilder<ThemCanBoCubit, ThemCanBoState>(
              bloc: _themCanBoCubit,
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is Loading,
                  color: Colors.transparent,
                  progressIndicator: const CupertinoLoading(),
                  child: StreamBuilder<List<DonViModel>>(
                    stream: _themCanBoCubit.getCanbo,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? <DonViModel>[];
                      if (data.isNotEmpty) {
                        return ListView(
                          keyboardDismissBehavior: isMobile()
                              ? ScrollViewKeyboardDismissBehavior.onDrag
                              : ScrollViewKeyboardDismissBehavior.manual,
                          children: List.generate(
                            data.length,
                            (index) {
                              final result = data[index];
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: index == 0 ? 0 : 16),
                                child: CanBoWidget(
                                  onCheckBox: (value) {
                                    _themCanBoCubit.selectCanBo(
                                      result,
                                      isCheck: value,
                                    );
                                  },
                                  canBoModel: result,
                                  themCanBoCubit: _themCanBoCubit,
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Column(
                        children: const [
                          SizedBox(
                            height: 30,
                          ),
                          NodataWidget(),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: screenDevice(
              mobileScreen: DoubleButtonBottom(
                title1: S.current.dong,
                title2: S.current.them,
                onPressed1: () {
                  Navigator.pop(context);
                },
                onPressed2: () {
                  Navigator.pop(context, _themCanBoCubit.listSelectCanBo);
                },
              ),
              tabletScreen: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: S.current.dong,
                  ),
                  spaceW20,
                  button(
                    onTap: () {
                      Navigator.pop(context, _themCanBoCubit.listSelectCanBo);
                    },
                    title: S.current.them,
                    isLeft: false,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget button({
    required Function onTap,
    required String title,
    bool isLeft = true,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 44,
        width: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isLeft
              ? AppTheme.getInstance().colorSelect().withOpacity(0.1)
              : AppTheme.getInstance().colorSelect(),
        ),
        child: Center(
          child: Text(
            title,
            style: textNormalCustom(
              fontSize: 16,
              color: isLeft
                  ? AppTheme.getInstance().colorSelect()
                  : colorFFFFFF,
            ),
          ),
        ),
      ),
    );
  }
}
