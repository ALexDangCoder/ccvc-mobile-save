import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cell_phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/dang_ky_phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/state_phat_bieu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';

class PhatBieuWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final String id;

  const PhatBieuWidget({Key? key, required this.id, required this.cubit})
      : super(key: key);

  @override
  _PhatBieuWidgetState createState() => _PhatBieuWidgetState();
}

class _PhatBieuWidgetState extends State<PhatBieuWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectOnlyWidget(
      title: S.current.phat_bieu,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  SizedBox(
                    child: StreamBuilder<int>(
                      stream: widget.cubit.typeStatus,
                      builder: (context, snapshot) {
                        if (widget.cubit.typeStatus.value == CHODUYET) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 150),
                            child: DoubleButtonBottom(
                              title1: S.current.huy_duyet,
                              title2: S.current.duyet,
                              onPressed1: () {
                                Navigator.pop(context);
                              },
                              onPressed2: () {},
                            ),
                          );
                        } else if (widget.cubit.typeStatus.value == DADUYET) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 250),
                            child: ButtonCustomBottom(
                              title: S.current.huy_duyet,
                              onPressed: () {
                                widget.cubit.getDanhSachPhatBieuLichHop(
                                  DADUYET,
                                  widget.id,
                                );
                                setState(() {});
                              },
                              isColorBlue: false,
                            ),
                          );
                        } else if (widget.cubit.typeStatus.value == HUYDUYET) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 250),
                            child: ButtonCustomBottom(
                              title: S.current.duyet,
                              onPressed: () {},
                              isColorBlue: true,
                            ),
                          );
                        } else {
                          return IconWithTiltleWidget(
                            icon: ImageAssets.icMic,
                            title: S.current.dang_ky_phat_bieu,
                            onPress: () {
                              showBottomSheetCustom(
                                context,
                                title: S.current.dang_ky_phat_bieu,
                                child: DangKyPhatBieuWidget(
                                  cubit: widget.cubit,
                                  id: widget.id,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  StreamBuilder<List<PhatBieuModel>>(
                    initialData: widget.cubit.listPhatBieu,
                    stream: widget.cubit.streamPhatBieu,
                    builder: (context, snapshot) {
                      final _list = snapshot.data ?? [];
                      if (_list.isNotEmpty) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _list.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CellPhatBieu(
                                  infoModel: _list[index],
                                  cubit: widget.cubit,
                                  index: index,
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
                  )
                ],
              ),
            ),
            StreamBuilder<int>(
              stream: widget.cubit.typeStatus,
              builder: (context, snapshot) {
                return StatePhatBieuWidget(cubit: widget.cubit);
              },
            ),
          ],
        ),
      ),
    );
  }
}
