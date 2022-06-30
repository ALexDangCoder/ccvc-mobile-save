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
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_state.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/widgets/can_bo_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/widgets/select_don_vi.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemCanBoWidget extends StatefulWidget {
  final Function(List<DonViModel>) onChange;
  final ThanhPhanThamGiaCubit cubit;
  final bool needCheckTrung;
  final ThemCanBoCubit themCanBoCubit;

  const ThemCanBoWidget({
    Key? key,
    required this.onChange,
    required this.cubit,
    this.needCheckTrung = false,
    required this.themCanBoCubit,
  }) : super(key: key);

  @override
  State<ThemCanBoWidget> createState() => _ThemDonViScreenState();
}

class _ThemDonViScreenState extends State<ThemCanBoWidget> {
  final ThemDonViCubit themDonViCubit = ThemDonViCubit();
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
            themDonViCubit: themDonViCubit,
            cubit: widget.cubit,
            needCheckTrung: widget.needCheckTrung,
            themCanBoCubit: widget.themCanBoCubit,
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
          themDonViCubit: themDonViCubit,
          cubit: widget.cubit,
          needCheckTrung: widget.needCheckTrung,
          themCanBoCubit: widget.themCanBoCubit,
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
  final bool needCheckTrung;
  final bool removeButton;
  final ThemCanBoCubit themCanBoCubit;
  final ThemDonViCubit themDonViCubit;

  const ThemCanBoScreen({
    Key? key,
    required this.cubit,
    required this.needCheckTrung,
    this.removeButton = false,
    required this.themCanBoCubit,
    required this.themDonViCubit,
  }) : super(key: key);

  @override
  _ThemCanBoScreenState createState() => _ThemCanBoScreenState();
}

class _ThemCanBoScreenState extends State<ThemCanBoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final List<DonViModel> listSelectCanBo = [];

    for (var element in widget.themCanBoCubit.listSelectCanBo) {
      if (widget.cubit.listPeople.map((e) => e.id).contains(element.id)) {
        listSelectCanBo.add(element);
      }
    }
    widget.themCanBoCubit.listSelectCanBo = listSelectCanBo;
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
              widget.themCanBoCubit.getCanBo(value);
            },
            themDonViCubit: widget.themDonViCubit,
          ),
          SizedBox(
            height: 20.0.textScale(space: 4),
          ),
          Text(
            S.current.danh_sach_don_vi_tham_gia,
            style: textNormal(textTitle, 16),
          ),
          spaceH16,
          BaseSearchBar(
            hintText: S.current.nhap_ten_can_bo,
            onChange: (value) {
              widget.themCanBoCubit.search(value);
            },
          ),
          spaceH16,
          Expanded(
            child: BlocBuilder<ThemCanBoCubit, ThemCanBoState>(
              bloc: widget.themCanBoCubit,
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is Loading,
                  color: Colors.transparent,
                  progressIndicator: const CupertinoLoading(),
                  child: StreamBuilder<List<DonViModel>>(
                    stream: widget.themCanBoCubit.getCanbo,
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
                                  onCheckBox: (value) async {
                                    if (value && widget.needCheckTrung) {
                                      await widget.themCanBoCubit
                                          .checkLichTrung(
                                        donViId: result.donViId,
                                        canBoId: result.canBoId,
                                        dateEnd: widget.cubit.dateEnd,
                                        dateStart: widget.cubit.dateStart,
                                        timeEnd: widget.cubit.timeEnd,
                                        timeStart: widget.cubit.timeStart,
                                      )
                                          .then((res) {
                                        if (res) {
                                          showDiaLog(
                                            context,
                                            title: S.current.lich_trung,
                                            textContent: S.current
                                                .ban_co_muon_tiep_tuc_khong,
                                            icon: ImageAssets.svgAssets(
                                                ImageAssets.ic_trung_hop),
                                            btnRightTxt: S.current.dong_y,
                                            btnLeftTxt: S.current.khong,
                                            isCenterTitle: true,
                                            funcBtnRight: () {
                                              widget.themCanBoCubit.selectCanBo(
                                                result,
                                                isCheck: value,
                                              );
                                              setState(() {});
                                            },
                                          );
                                        } else {
                                          widget.themCanBoCubit.selectCanBo(
                                            result,
                                            isCheck: value,
                                          );
                                          setState(() {});
                                        }
                                      });
                                      return;
                                    }
                                    if (widget.cubit.listPeople.indexWhere(
                                            (element) =>
                                                element.id == result.id) ==
                                        -1) {
                                      widget.themCanBoCubit.selectCanBo(
                                        result,
                                        isCheck: value,
                                      );
                                    }
                                  },
                                  canBoModel: result,
                                  themCanBoCubit: widget.themCanBoCubit,
                                  cubit: widget.cubit,
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
          if (widget.removeButton)
            Container()
          else
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
                    Navigator.pop(
                      context,
                      widget.themCanBoCubit.listSelectCanBo,
                    );
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
                        Navigator.pop(
                          context,
                          widget.themCanBoCubit.listSelectCanBo,
                        );
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
                  : backgroundColorApp,
            ),
          ),
        ),
      ),
    );
  }
}
