import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/phat_bieu_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/dang_ky_phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/state_phat_bieu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import 'cell_phat_bieu_widget.dart';

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
            buttonPhatBieu(cubit: widget.cubit, id: widget.cubit.idCuocHop)
          ],
        ),
      ),
    );
  }
}

Widget buttonStatePhatBieu(
    {required DetailMeetCalenderCubit cubit, bool? isHorizontal}) {
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

Widget buttonPhatBieu({
  required DetailMeetCalenderCubit cubit,
  required String id,
}) {
  return SizedBox(
    child: StreamBuilder<int>(
      stream: cubit.typeStatus,
      builder: (context, snapshot) {
        final data = snapshot.data ?? 0;
        if (data == CHODUYET) {
          return Padding(
            padding: EdgeInsets.only(
              right: isMobile() ? 150 : 250,
              left: isMobile() ? 0 : 250,
            ),
            child: DoubleButtonBottom(
              title1: S.current.huy_duyet,
              title2: S.current.duyet,
              onPressed1: () {
                cubit.duyetOrHuyDuyetPhatBieu(
                  lichHopId: id,
                  type: 2,
                );
              },
              onPressed2: () {
                cubit.duyetOrHuyDuyetPhatBieu(
                  lichHopId: id,
                  type: 1,
                );
              },
            ),
          );
        } else if (data == DADUYET) {
          return Padding(
            padding: EdgeInsets.only(
              right: isMobile() ? 250 : 350,
              left: isMobile() ? 0 : 350,
            ),
            child: ButtonCustomBottom(
              title: S.current.huy_duyet,
              onPressed: () {
                cubit.duyetOrHuyDuyetPhatBieu(
                  lichHopId: id,
                  type: 1,
                );
              },
              isColorBlue: false,
            ),
          );
        } else if (data == HUYDUYET) {
          return Padding(
            padding: EdgeInsets.only(
              right: isMobile() ? 250 : 350,
              left: isMobile() ? 0 : 350,
            ),
            child: ButtonCustomBottom(
              title: S.current.duyet,
              onPressed: () {
                cubit.duyetOrHuyDuyetPhatBieu(
                  lichHopId: id,
                  type: 2,
                );
              },
              isColorBlue: true,
            ),
          );
        } else {
          return isMobile()
              ? IconWithTiltleWidget(
                  icon: ImageAssets.icMic,
                  title: S.current.dang_ky_phat_bieu,
                  onPress: () {
                    showBottomSheetCustom(
                      context,
                      title: S.current.dang_ky_phat_bieu,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height*0.8,
                        ),
                        child: DangKyPhatBieuWidget(
                          cubit: cubit,
                          id: id,
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox();
        }
      },
    ),
  );
}
