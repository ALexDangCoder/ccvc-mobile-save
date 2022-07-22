import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/mobile/bao_cao_thong_ke_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_state.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/nhiem_vu_ca_nhan_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/nhiem_vu_don_vi_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNhieVuMobile extends StatefulWidget {
  final String maTrangThai;
  final bool isCaNhanScreen;

  const MainNhieVuMobile(
      {Key? key, this.maTrangThai = '', this.isCaNhanScreen = true})
      : super(key: key);

  @override
  _MainNhieVuMobileState createState() => _MainNhieVuMobileState();
}

class _MainNhieVuMobileState extends State<MainNhieVuMobile> {
  late final NhiemVuCubit cubit;
  late final DanhSachCubit danhSachCubit;
  late String title;

  @override
  void initState() {
    cubit = NhiemVuCubit();
    danhSachCubit = DanhSachCubit();
    if (widget.isCaNhanScreen) {
      cubit.emit(NhiemVuCaNhan());
    } else {
      cubit.emit(NhiemVuDonVi());
    }

    title = S.current.nhiem_vu_ca_nhan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NhiemVuCubit, NhiemVuState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is NhiemVuCaNhan) {
          title = S.current.nhiem_vu_ca_nhan;
        } else if (state is NhiemVuDonVi) {
          title = S.current.nhiem_vu_don_vi;
        } else {
          title = S.current.bao_cao_thong_ke;
        }

        return BlocBuilder<NhiemVuCubit, NhiemVuState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is NhiemVuCaNhan) {
              return NhiemVuCaNhanMobile(
                maTrangThai: widget.maTrangThai,
                isCheck: true,
                danhSachCubit: danhSachCubit,
                nhiemVuCubit: cubit,
              );
            } else if (state is NhiemVuDonVi) {
              return NhiemVuDonViMobile(
                maTrangThai: widget.maTrangThai,
                isCheck: false,
                danhSachCubit: danhSachCubit,
                nhiemVuCubit: cubit,
              );
            } else {
              return BaoCaoThongKeNhiemVuMobile(
                danhSachCubit: danhSachCubit,
                nhiemVuCubit: cubit,
              );
            }
          },
        );
      },
    );
  }
}
