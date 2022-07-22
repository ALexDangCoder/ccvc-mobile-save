import 'dart:io';

import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_phien_hop_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:intl/intl.dart';

///Chương Trình họp
extension ChuongTrinhHop on DetailMeetCalenderCubit {
  Future<void> getListPhienHop(String id) async {
    final result = await hopRp.getDanhSachPhienHop(id);
    result.when(
      success: (res) {
        danhSachChuongTrinhHop.sink.add(res);
      },
      error: (error) {},
    );
  }

  Future<void> getDanhSachCuCanBoHop(
    ThanhPhanThamGiaCubit cubitThanhPhanTG,
  ) async {
    showLoading();
    final result = await hopRp.getDanhSachNguoiChuTriPhienHop(idCuocHop);
    result.when(
      success: (res) {
        listTPTG = res
            .map(
              (e) => DonViModel(
                id: e.id ?? '',
                donViId: e.donViId ?? '',
                tenDonVi: e.tenDonVi ?? '',
                canBoId: e.canBoId ?? '',
                noidung: e.ghiChu ?? '',
                tenCanBo: e.tenCanBo ?? '',
                tenCoQuan: e.tenCoQuan ?? '',
              ),
            )
            .toList();

        final List<NguoiChutriModel> data = [];

        final donViId =
            HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '';

        final NguoiChutriModel chuTri = res.firstWhere(
          (element) => element.donViId == donViId && element.canBoId == null,
          orElse: () => NguoiChutriModel(),
        );
        data.add(chuTri);

        /// cu can bo
        data.addAll(res.where((element) => element.parentId == chuTri.id));

        listCuCanBoSubject.add(data);

        cubitThanhPhanTG.listCanBo.clear();

        final List<DonViModel> listCanBo = data
            .map(
              (e) => DonViModel(
                id: e.id ?? '',
                donViId: e.donViId ?? '',
                tenDonVi: e.tenDonVi ?? '',
                canBoId: e.canBoId ?? '',
                noidung: e.ghiChu ?? '',
                tenCanBo: e.tenCanBo ?? '',
                tenCoQuan: e.tenCoQuan ?? '',
              ),
            )
            .toList();
        cubitThanhPhanTG.listCanBoDuocChon = listCanBo;
        cubitThanhPhanTG.listCanBoThamGia.add(listCanBo);
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> getDanhSachCanBoHop(String id) async {
    final result = await hopRp.getDanhSachNguoiChuTriPhienHop(id);
    result.when(
      success: (res) {
        final donViId =
            HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '';
        final idCuCanBo = res
            .firstWhere(
              (element) => element.donViId == donViId,
              orElse: () => NguoiChutriModel(),
            )
            .id;
        idDanhSachCanBo = idCuCanBo ?? '';

        ///cu can bo di thay
        final canBoId = HiveLocal.getDataUser()?.userId;
        final idCanBo = res.firstWhere(
          (element) => element.canBoId == canBoId,
          orElse: () => NguoiChutriModel(),
        );
        final parentCanBo = DonViModel(
          id: idCanBo.id ?? '',
          name: idCanBo.hoTen ?? '',
          tenCanBo: idCanBo.tenCanBo ?? '',
          chucVu: idCanBo.chucVu ?? '',
          canBoId: idCanBo.canBoId ?? '',
          donViId: idCanBo.donViId ?? '',
          tenCoQuan: idCanBo.tenCoQuan ?? '',
        );
        donViModel = parentCanBo;

        /// lay con cua can bo
        final canBoDiThay = res.where(
          (element) => element.parentId == idCanBo.id,
        );
        final listCanBoMoi = canBoDiThay
            .map(
              (e) => DonViModel(
                id: e.id ?? '',
                name: e.hoTen ?? '',
                tenCanBo: e.tenCanBo ?? '',
                chucVu: e.chucVu ?? '',
                canBoId: e.canBoId ?? '',
                donViId: e.donViId ?? '',
                tenCoQuan: e.tenCoQuan ?? '',
              ),
            )
            .toList();
        listDataCanBo = listCanBoMoi;
        listDonViModel.sink.add(listDataCanBo);
        idCanBoDiThay = idCanBo.id ?? '';
      },
      error: (error) {},
    );
  }

  Future<void> themPhienHop({
    required String id,
    required TaoPhienHopRequest taoPhienHopRequest,
  }) async {
    final result = await hopRp.themPhienHop(
      id,
      [taoPhienHopRequest],
    );
    result.when(
      success: (res) {
        getListPhienHop(id);
      },
      error: (error) {},
    );
  }

  Future<void> suaChuongTrinhHop({
    required String id,
    required String lichHopId,
    required String tieuDe,
    required String thoiGianBatDau,
    required String thoiGianKetThuc,
    required String canBoId,
    required String donViId,
    required String noiDung,
    required String? hoTen,
    required bool isMultipe,
    required List<File>? file,
  }) async {
    showLoading();

    final result = await hopRp.suaChuongTrinhHop(
      id,
      lichHopId,
      tieuDe,
      thoiGianBatDau,
      thoiGianKetThuc,
      canBoId,
      donViId,
      noiDung,
      hoTen ?? '',
      isMultipe,
      file ?? [],
    );

    result.when(
      success: (value) {
        MessageConfig.show(
          title: S.current.sua_thanh_cong,
        );
        showContent();
      },
      error: (error) {
        if (error is TimeoutException || error is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.sua_that_bai,
            messState: MessState.error,
          );
        }
      },
    );
  }

  Future<bool> xoaChuongTrinhHop({
    required String id,
  }) async {
    showLoading();
    bool isCheck = true;
    final result = await hopRp.xoaChuongTrinhHop(id);
    result.when(
      success: (value) {
        MessageConfig.show(
          title: S.current.xoa_thanh_cong,
        );
        isCheck = true;
        showContent();
      },
      error: (error) {
        if (error is TimeoutException || error is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.xoa_that_bai,
            messState: MessState.error,
          );
        }
        isCheck = false;
      },
    );
    return isCheck;
  }

  TimerData subStringTime(String time) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final dateTime = dateFormat.parse(time);
    return TimerData(hour: dateTime.hour, minutes: dateTime.minute);
  }

  String chonNgayStr(String date) {
    final DateFormat paserDate = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final paserDates = paserDate.parse(date).formatApiFix;
    return paserDates;
  }

  String plus(String? date, TimerData time) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd 00:00:00');
    final dateTime = dateFormat.parse(date ?? chonNgayStr(chonNgay));
    final times = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      time.hour,
      time.minutes,
    );
    return times.formatApiSuaPhienHop;
  }

  void getTimeHour({required TimerData startT, required TimerData endT}) {
    final int hourStart = startT.hour;
    final int minuteStart = startT.minutes;
    final int hourEnd = endT.hour;
    final int minuteEnd = endT.minutes;
    String hStart = hourStart.toString();
    String mStart = minuteStart.toString();
    String hEnd = hourEnd.toString();
    String mEnd = minuteEnd.toString();
    if (hourStart < 10) {
      hStart = '0$hStart';
    }
    if (minuteStart < 10) {
      mStart = '0$mStart';
    }
    if (hourEnd < 10) {
      hEnd = '0$hEnd';
    }
    if (minuteEnd < 10) {
      mEnd = '0$mEnd';
    }
    startTime = '$hStart:$mStart';
    endTime = '$hEnd:$mEnd';
  }

  Future<void> callApiChuongTrinhHop() async {
    showLoading();
    await getDanhSachCanBoHop(idCuocHop);
    await getDanhSachNguoiChuTriPhienHop(idCuocHop);
    await getListPhienHop(idCuocHop);
    showContent();
  }
}
