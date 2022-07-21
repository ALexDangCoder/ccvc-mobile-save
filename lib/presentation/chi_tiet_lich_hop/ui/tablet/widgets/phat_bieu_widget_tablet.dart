import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dialog.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/phat_bieu_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cell_phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/dang_ky_phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/state_phat_bieu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/onButtonCustom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhatBieuWidgetTablet extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const PhatBieuWidgetTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _PhatBieuWidgetTabletState createState() => _PhatBieuWidgetTabletState();
}

class _PhatBieuWidgetTabletState extends State<PhatBieuWidgetTablet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!isMobile()) {
      widget.cubit.callApiPhatBieu();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: SingleChildScrollView(
        child: Column(
          children: [
            IconWithTiltleWidget(
              icon: ImageAssets.icMic,
              title: S.current.dang_ky_phat_bieu,
              onPress: () {
                showDiaLogTablet(
                  context,
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                  title: S.current.dang_ky_phat_bieu,
                  child: DangKyPhatBieuWidget(
                    cubit: widget.cubit,
                    id: widget.cubit.idCuocHop,
                  ),
                  isBottomShow: false,
                  funcBtnOk: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: buttonStatePhatBieu(cubit: widget.cubit),
            ),
            StreamBuilder<List<PhatBieuModel>>(
              stream: widget.cubit.streamPhatBieu,
              builder: (context, snapshot) {
                final list = snapshot.data ?? [];
                if (list.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CellPhatBieu(
                            infoModel: list[index],
                            cubit: widget.cubit,
                            index: index,
                            onChangeCheckBox: (vl) {
                              if (vl != true) {
                                widget.cubit.selectPhatBieu
                                    .add(list[index].id ?? '');
                              } else {
                                widget.cubit.selectPhatBieu
                                    .remove(list[index].id);
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const SizedBox(
                    height: 200,
                    child: NodataWidget(),
                  );
                }
              },
            ),
            PhatBieuChildWidget(
              cubit: widget.cubit,
              itemCenter: StreamBuilder<List<PhatBieuModel>>(
                stream: widget.cubit.streamPhatBieu,
                builder: (context, snapshot) {
                  final list = snapshot.data ?? [];
                  if (list.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CellPhatBieu(
                              infoModel: list[index],
                              cubit: widget.cubit,
                              index: index,
                              onChangeCheckBox: (value) {
                                if (value != true) {
                                  widget.cubit.selectPhatBieu
                                      .add(list[index].id ?? '');
                                } else {
                                  widget.cubit.selectPhatBieu
                                      .remove(list[index].id);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: NodataWidget(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buttonStatePhatBieu({
  required DetailMeetCalenderCubit cubit,
  bool? isHorizontal,
}) {
  return SizedBox(
    height: 50,
    child: StreamBuilder<int>(
      initialData: 0,
      stream: cubit.typeStatus,
      builder: (context, snapshot) {
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection:
              (isHorizontal ?? true) ? Axis.horizontal : Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.buttonStatePhatBieu.length,
          itemBuilder: (context, index) {
            final data = cubit.buttonStatePhatBieu;
            if (isHorizontal ?? true) {
              return Row(
                children: [
                  buttonPhone(
                    key: data[index].key ?? '',
                    value: data[index].value.toString(),
                    color: data[index].color ?? Colors.white,
                    backgroup: cubit.bgrColorButton(snapshot.data ?? 0),
                    ontap: () {
                      cubit.getValueStatus(index);
                      cubit.selectPhatBieu.clear();
                    },
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              );
            }
            return Column(
              children: [
                buttonPhone(
                  key: data[index].key ?? '',
                  value: data[index].value.toString(),
                  color: data[index].color ?? Colors.white,
                  backgroup: cubit.bgrColorButton(snapshot.data ?? 0),
                  ontap: () {
                    cubit.getValueStatus(index);
                    cubit.selectPhatBieu.clear();
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            );
          },
        );
      },
    ),
  );
}

class PhatBieuChildWidget extends StatelessWidget {
  final DetailMeetCalenderCubit cubit;
  final Widget itemCenter;

  const PhatBieuChildWidget({
    Key? key,
    required this.cubit,
    required this.itemCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: cubit.typeStatus,
      builder: (context, snapshot) {
        final data = snapshot.data ?? 0;
        return Column(
          children: [
            if (data == StatePhatBieu.danh_Sach_phat_bieu)
              IconWithTiltleWidget(
                icon: ImageAssets.icMic,
                title: S.current.dang_ky_phat_bieu,
                onPress: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.dang_ky_phat_bieu,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      child: DangKyPhatBieuWidget(
                        cubit: cubit,
                        id: cubit.idCuocHop,
                      ),
                    ),
                  );
                },
              ),

            /// item Center
            itemCenter,
            StreamBuilder<List<PhatBieuModel>>(
              stream: cubit.streamPhatBieu,
              builder: (_, snapshot) {
                final dataListPhatBieu = snapshot.data ?? [];
                if (dataListPhatBieu.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: buttonDuyet(data, cubit, context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buttonDuyet(
    int data,
    DetailMeetCalenderCubit cubit,
    BuildContext context,
  ) {
    switch (data) {
      case StatePhatBieu.cho_duyet:
        return Padding(
          padding: EdgeInsets.only(
            right: isMobile() ? 150 : 250,
            left: isMobile() ? 0 : 250,
          ),
          child: Row(
            children: [
              Expanded(child: buttomDuyetPb(context: context)),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: buttomHuyPb(text: S.current.huy_duyet, context: context),
              ),
            ],
          ),
        );
      case StatePhatBieu.da_duyet:
        return Padding(
          padding: EdgeInsets.only(
            right: isMobile() ? 250 : 350,
            left: isMobile() ? 0 : 350,
          ),
          child: buttomHuyPb(context: context),
        );
      case StatePhatBieu.huy_duyet:
        return Padding(
          padding: EdgeInsets.only(
            right: isMobile() ? 250 : 350,
            left: isMobile() ? 0 : 350,
          ),
          child: buttomDuyetPb(context: context),
        );
    }
    return const SizedBox();
  }

  Widget buttomHuyPb({String? text, required BuildContext context}) =>
      ButtonBottomCustom(
        textColor: statusCalenderRed,
        customColor: statusCalenderRed.withOpacity(0.15),
        text: text ?? S.current.huy_duyet,
        onPressed: () {
          showXacNhan(isDuyet: false, context: context);
        },
      );

  Widget buttomDuyetPb({String? text, required BuildContext context}) =>
      ButtonBottomCustom(
        textColor: itemWidgetUsing,
        customColor: itemWidgetUsing.withOpacity(0.15),
        text: text ?? S.current.duyet,
        onPressed: () {
          showXacNhan(isDuyet: true, context: context);
        },
      );

  void showXacNhan({
    required BuildContext context,
    required bool isDuyet,
  }) {
    if (cubit.selectPhatBieu.isEmpty) {
      final toast = FToast();
      toast.init(context);
      toast.removeCustomToast();
      toast.showToast(
        child: ShowToast(
          text: isDuyet
              ? S.current.ban_phai_tick_chon_bieu_quyet_muon_duyet
              : S.current.ban_phai_tick_chon_bieu_quyet_muon_huy_duyet,
        ),
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      showDiaLog(
        context,
        title: isDuyet ? S.current.duyet : S.current.huy_duyet,
        icon: isDuyet
            ? SvgPicture.asset(ImageAssets.icDiemDanh)
            : SvgPicture.asset(ImageAssets.icHuyDiemDanh),
        textContent:
            isDuyet ? S.current.duyet_phat_bieu : S.current.huy_duyet_phat_bieu,
        btnRightTxt: S.current.dong_y,
        btnLeftTxt: S.current.khong,
        funcBtnRight: () {
          cubit.duyetOrHuyDuyetPhatBieu(
            lichHopId: cubit.idCuocHop,
            type: isDuyet ? DUYET_TYPE : HUY_DUYET_TYPE,
          );
        },
      );
    }
  }
}
