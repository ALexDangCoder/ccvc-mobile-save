import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/widget_item_lich_hop.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class LichHopTheoDanhSachNgayTablet extends StatefulWidget {
  final LichHopCubit cubit;

  const LichHopTheoDanhSachNgayTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<LichHopTheoDanhSachNgayTablet> createState() =>
      _LichHopTheoDanhSachNgayTabletState();
}

class _LichHopTheoDanhSachNgayTabletState
    extends State<LichHopTheoDanhSachNgayTablet> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.cubit.page < widget.cubit.totalPage) {
          widget.cubit.page = widget.cubit.page + 1;
          widget.cubit.postDanhSachLichHop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<DanhSachLichHopModel>(
              stream: widget.cubit.danhSachLichHopStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? DanhSachLichHopModel.empty();

                return Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: data.items?.length ?? 0,
                    itemBuilder: (context, index) {
                      return WidgetItemLichHop(
                        ontap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailMeetCalenderTablet(
                                id: data.items?[index].id ?? '',
                              ),
                            ),
                          );
                        },
                        title: data.items?[index].title ?? '',
                        dateTimeFrom: DateTime.parse(
                          data.items?[index].dateTimeFrom ?? '',
                        ).toStringWithAMPM,
                        dateTimeTo: DateTime.parse(
                          data.items?[index].dateTimeTo ?? '',
                        ).toStringWithAMPM,
                        urlImage: urlImage,
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
