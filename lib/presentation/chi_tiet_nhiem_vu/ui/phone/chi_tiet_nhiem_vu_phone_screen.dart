import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_header.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_don_doc.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/header_chi_tiet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_don_doc.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/van_ban_lien_quan_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/y_kien_nhiem_vu.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';

class ChiTietNhiemVuPhoneScreen extends StatefulWidget {
  const ChiTietNhiemVuPhoneScreen({Key? key}) : super(key: key);

  @override
  _ChiTietNhiemVuPhoneScreenState createState() =>
      _ChiTietNhiemVuPhoneScreenState();
}

class _ChiTietNhiemVuPhoneScreenState extends State<ChiTietNhiemVuPhoneScreen> {
  ChiTietNVCubit cubit = ChiTietNVCubit();

  @override
  void initState() {
    super.initState();
    cubit.initChiTietNV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: S.current.chi_tiet_nhiem_vu,
        leadingIcon: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const SizedBox(
            height: 15,
            width: 15,
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: textBodyTime,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<ChiTietNhiemVuHeader>(
              stream: cubit.chiTietHeaderStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? ChiTietNhiemVuHeader.empty();
                return HeaderChiTiet(
                  row: data.listRow(),
                );
              },
            ),
            StreamBuilder<VanBanLienQuanModel>(
              stream: cubit.vanBanLienQuanStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? VanBanLienQuanModel.empty();
                return VanBanLienQuanWidget(
                  dataModel: data,
                  cubit: cubit,
                );
              },
            ),
            StreamBuilder<List<DanhSachCongViecModel>>(
              stream: cubit.danhSachCongViecStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return DanhSachCongViecWidget(
                  dataModel: data,
                  cubit: cubit,
                );
              },
            ),
            StreamBuilder<List<LichSuPhanXuLyModel>>(
              stream: cubit.lichSuPhanXuLySubject,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return LichSuPhanXuLyWidget(
                  dataModel: data,
                  cubit: cubit,
                );
              },
            ),
            YKienNhiemVuWidget(
              cubit:cubit ,
            ),
            StreamBuilder<List<LichSuCapNhatTHTHModel>>(
              stream: cubit.lichSuCapNhatTHTHModelStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return LichSuCapNhatTHTHWidget(
                  dataModel: data,
                  cubit: cubit,
                );
              },
            ),
            StreamBuilder<List<LichSuTraLaiModel>>(
              stream: cubit.lichSuTraLaiStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return LichSuTraLaiWidget(
                  dataModel: data,
                  cubit: cubit,
                );
              },
            ),
            StreamBuilder<List<LichSuThuHoiModel>>(
              stream: cubit.lichSuThuHoiStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return LichSuThuHoiWidget(
                  dataModel: data,
                  cubit: cubit,
                );
              },
            ),
            StreamBuilder<List<LichSuDonDocModel>>(
              stream: cubit.lichSuDonDocStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return LichSuDonDocWidget(
                  dataModel: data,
                  cubit: cubit,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
