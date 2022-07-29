import 'dart:core';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/y_kien_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/chuong_trinh_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/moi_nguoi_tham_gia_widget.dart';
import 'package:flutter/cupertino.dart';

enum TabWidgetDetailMeet {
  CONG_TAC_CHUAN_BI,
  CHUONG_TRINH_HOP,
  THANH_PHAN_THAM_GIA,
  TAI_LIEU,
  PHAT_BIEU,
  BIEU_QUYET,
  KET_LUAN_HOP,
  Y_KIEN_HOP
}

extension TabWidgetDetail on TabWidgetDetailMeet {
  String getName() {
    switch (this) {
      case TabWidgetDetailMeet.CONG_TAC_CHUAN_BI:
        return S.current.cong_tac_chuan_bi;
      case TabWidgetDetailMeet.CHUONG_TRINH_HOP:
        return S.current.chuong_trinh_hop;
      case TabWidgetDetailMeet.THANH_PHAN_THAM_GIA:
        return S.current.thanh_phan_tham_gia;
      case TabWidgetDetailMeet.TAI_LIEU:
        return S.current.tai_lieu;
      case TabWidgetDetailMeet.PHAT_BIEU:
        return S.current.phat_bieu;
      case TabWidgetDetailMeet.BIEU_QUYET:
        return S.current.bieu_quyet;
      case TabWidgetDetailMeet.KET_LUAN_HOP:
        return S.current.ket_luan_hop;
      case TabWidgetDetailMeet.Y_KIEN_HOP:
        return S.current.y_kien_cuop_hop;
    }
  }

  Widget getWidget(DetailMeetCalenderCubit cubit) {
    switch (this) {
      case TabWidgetDetailMeet.CONG_TAC_CHUAN_BI:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CongTacChuanBiWidget(
            cubit: cubit,
          ),
        );
      case TabWidgetDetailMeet.CHUONG_TRINH_HOP:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ChuongTrinhHopWidget(
            cubit: cubit,
          ),
        );
      case TabWidgetDetailMeet.THANH_PHAN_THAM_GIA:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ThanhPhanThamGiaWidget(
            cubit: cubit,
          ),
        );
      case TabWidgetDetailMeet.TAI_LIEU:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TaiLieuWidget(
            cubit: cubit,
          ),
        );
      case TabWidgetDetailMeet.PHAT_BIEU:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: PhatBieuWidget(
            cubit: cubit,
          ),
        );
      case TabWidgetDetailMeet.BIEU_QUYET:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BieuQuyetWidget(
            cubit: cubit,
          ),
        );
      case TabWidgetDetailMeet.KET_LUAN_HOP:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: KetLuanHopWidget(
            cubit: cubit,
          ),
        );
      case TabWidgetDetailMeet.Y_KIEN_HOP:
        return YKienCuocHopWidget(
          cubit: cubit,
        );
    }
  }
}