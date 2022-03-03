import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/widget_item_lich_hop.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DanhSachLichHop extends StatefulWidget {
  final LichHopCubit cubit;

  const DanhSachLichHop({Key? key, required this.cubit}) : super(key: key);

  @override
  _DanhSachLichHopState createState() => _DanhSachLichHopState();
}

class _DanhSachLichHopState extends State<DanhSachLichHop> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.cubit.currentTime,
            style: textNormalCustom(color: textBodyTime),
          ),
        ),
        Expanded(
          child: StreamBuilder<DanhSachLichHopModel>(
            stream: widget.cubit.danhSachLichHopStream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? DanhSachLichHopModel.empty();

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: data.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return WidgetItemLichHop(
                      ontap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailMeetCalenderScreen(
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
            },
          ),
        ),
      ],
    );
  }
}
