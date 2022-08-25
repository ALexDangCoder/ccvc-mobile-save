import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/phat_bieu_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cell_phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/phat_bieu_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/state_phat_bieu_widget.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';

class PhatBieuWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const PhatBieuWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _PhatBieuWidgetState createState() => _PhatBieuWidgetState();
}

class _PhatBieuWidgetState extends State<PhatBieuWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        onchange: (vl) {
          if (vl && isMobile()) {
            widget.cubit.callApiPhatBieu();
          }
        },
        title: S.current.phat_bieu,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    /// list phat bieu cung voi button duyet
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
                            return const NodataWidget(height: 100,);
                          }
                        },
                      ),
                    ),
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
      ),
      tabletScreen: PhatBieuWidgetTablet(
        cubit: widget.cubit,
      ),
    );
  }
}
