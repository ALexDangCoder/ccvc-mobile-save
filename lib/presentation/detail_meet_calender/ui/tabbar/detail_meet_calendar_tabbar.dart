import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/thanh_phan_tham_gia_widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget.dart';
import 'package:flutter/material.dart';

class DetailMeetCalendarTabar extends StatefulWidget {
  const DetailMeetCalendarTabar({Key? key}) : super(key: key);

  @override
  _DetailMeetCalendarTabarState createState() =>
      _DetailMeetCalendarTabarState();
}

class _DetailMeetCalendarTabarState extends State<DetailMeetCalendarTabar> {
  var _controller = TabController(vsync: AnimatedListState(), length: 7);

  @override
  void initState() {
    _controller = TabController(vsync: AnimatedListState(), length: 7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,

        bottom: TabBar(
          controller: _controller,
          indicatorColor: indicatorColor,
          unselectedLabelColor: unselectLabelColor,
          labelColor: indicatorColor,
          isScrollable: true,
          tabs: [
            Tab(
              child: Text(
                S.current.cong_tac_chuan_bi,
              ),
            ),
            Tab(
              child: Text(
                S.current.thanh_phan_tham_gia,
              ),
            ),
            Tab(
              child: Text(
                S.current.tai_lieu,
              ),
            ),
            Tab(
              child: Text(
                S.current.phat_bieu,
              ),
            ),
            Tab(
              child: Text(
                S.current.bieu_quyet,
              ),
            ),
            Tab(
              child: Text(
                S.current.ket_luan_hop,
              ),
            ),
            Tab(
              child: Text(
                S.current.y_kien_cuop_hop,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CongTacChuanBiWidget(),
          MoiNguoiThamGiaWidget(),
          TaiLieuWidget(),
          PhatBieuWidget(),
          BieuQuyetWidget(),
          KetLuanHopWidget(),
          YKienCuocHopWidget(),
        ],
      ),
    );
  }
}
