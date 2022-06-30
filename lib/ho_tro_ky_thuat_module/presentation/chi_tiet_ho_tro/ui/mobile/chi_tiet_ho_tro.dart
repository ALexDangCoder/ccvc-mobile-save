import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/cubit/chi_tiet_ho_tro_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/widget/cap_nhat_tinh_hinh_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/widget/danh_gia_yeu_cau_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChiTietHoTroMobile extends StatefulWidget {
  const ChiTietHoTroMobile({Key? key, required this.idHoTro}) : super(key: key);
  final String idHoTro;

  @override
  _ChiTietHoTroMobileState createState() => _ChiTietHoTroMobileState();
}

class _ChiTietHoTroMobileState extends State<ChiTietHoTroMobile> {
  late ChiTietHoTroCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = ChiTietHoTroCubit();
    cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.chi_tiet_yeu_cau_ho_tro,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
      ),
      body: BlocBuilder<ChiTietHoTroCubit, ChiTietHoTroState>(
        bloc: cubit,
        builder: (context, state) {
          return StateStreamLayout(
            stream: cubit.stateStream,
            error: AppException(S.current.something_went_wrong, ''),
            retry: () {},
            textEmpty: '',
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceH12,
                      title(S.current.thong_tin_yeu_cau),
                      spaceH16,
                      rowItem(S.current.don_vi, 'Trung tâm tin học'),
                      spaceH10,
                      rowItem(
                          S.current.nguoi_yeu_cau, 'Nguyễn Văn A - Trưởng phòng'),
                      spaceH10,
                      rowItem(S.current.so_dien_thoai_lien_he, '0964950763'),
                      spaceH10,
                      rowItem(S.current.ten_thiet_bi, 'Cung cấp thiết bị làm việc'),
                      spaceH10,
                      rowItem(S.current.ngay_yeu_cau, '25/05/2022 | 10:59:00'),
                      spaceH10,
                      rowItem(S.current.mo_ta_su_co,
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                      spaceH10,
                      rowItem(S.current.dia_chi,
                          'Số 302, Toà E, Khu vực 69 Nguyễn Thái Học'),
                      spaceH10,
                      loaiSuCo(['Tất cả', 'sự cố máy tính', 'Sự cố hệ thống']),
                      spaceH20,
                      title(S.current.ket_qua_xu_ly),
                      spaceH16,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              S.current.trang_thai_xu_ly,
                              style: textNormalCustom(
                                color: color667793,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          spaceW12,
                          Expanded(
                            flex: 3,
                            child: 'DANG_THUC_HIEN'.getStatusNV().getStatus(),
                          ),
                        ],
                      ),
                      spaceH10,
                      rowItem(S.current.ket_qua_xu_ly, 'Nguyễn Văn A'),
                      spaceH10,
                      rowItem(S.current.nguoi_xu_ly, 'Nguyễn Văn A'),
                      spaceH10,
                      rowItem(
                          S.current.ngay_hoan_thanh, '25/05/2022 | 10:59:00 SA'),
                      spaceH10,
                      rowItem(S.current.nhan_xet, 'Hoàn thành tốt'),
                      spaceH20,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                    ),
                    height: 63.h,
                    color: Colors.white,
                    child: DoubleButtonBottom(
                      title1: S.current.dong,
                      title2: S.current.cap_nhat_thxl,
                      onPressed1: () {},
                      onPressed2: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (_) {
                            return CapNhatTinhHinhHoTro();
                          },
                        );
                      },
                      noPadding: true,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget title(String title) {
    return Text(
      title,
      style: textNormalCustom(
        color: color3D5586,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

Widget loaiSuCo(List<String> list) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          S.current.loai_su_co,
          style: textNormalCustom(
            color: color667793,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      spaceW12,
      Expanded(
        flex: 3,
        child: Wrap(
          spacing: 10.w, // gap between adjacent chips
          runSpacing: 10.h, // gap between lines
          children: list
              .map(
                (e) => Container(
                  decoration: BoxDecoration(
                    color: colorDBDFEF.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      8.0.w,
                    ),
                    child: Text(
                      '≠$e',
                      style: textNormalCustom(
                        color: color3D5586,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}

Widget rowItem(String title, String? value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          title,
          style: textNormalCustom(
            color: color667793,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      spaceW12,
      Expanded(
        flex: 3,
        child: Text(
          value ?? '',
          style: textNormalCustom(
            color: color3D5586,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

Widget statusTrangThaiXuLy({required String name, required Color background}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0.textScale(),
          vertical: 4.0.textScale(),
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          name,
          style: textNormalCustom(
            color: Colors.white,
            fontSize: 12.0.textScale(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

enum StatusHoTro {
  DANG_CHO_XU_LY,
  DA_XU_LY,
  DANG_THUC_HIEN,
  THU_HOI,
  DA_HOAN_THANH,
  CHO_PHAN_XU_LY,
  TRA_LAI,
  NONE,
}

extension StatusChiTietNV on StatusHoTro {
  Widget getStatus() {
    switch (this) {
      case StatusHoTro.DANG_CHO_XU_LY:
        return statusTrangThaiXuLy(
          name: S.current.qua_han,
          background: statusCalenderRed,
        );
      case StatusHoTro.DANG_THUC_HIEN:
        return statusTrangThaiXuLy(
          name: S.current.dang_thuc_hien,
          background: blueNhatChart,
        );
      case StatusHoTro.THU_HOI:
        return statusTrangThaiXuLy(
          name: S.current.thu_hoi,
          background: yellowColor,
        );
      case StatusHoTro.DA_HOAN_THANH:
        return statusTrangThaiXuLy(
          name: S.current.da_hoan_thanh,
          background: daXuLyColor,
        );
      case StatusHoTro.CHO_PHAN_XU_LY:
        return statusTrangThaiXuLy(
          name: S.current.cho_phan_xu_ly,
          background: color5A8DEE,
        );
      case StatusHoTro.TRA_LAI:
        return statusTrangThaiXuLy(
          name: S.current.tra_lai,
          background: statusCalenderRed,
        );
      case StatusHoTro.NONE:
        return const SizedBox();
      case StatusHoTro.DA_XU_LY:
        return const SizedBox();
    }
  }
}

extension GetStatusNV on String {
  StatusHoTro getStatusNV() {
    switch (this) {
      case 'DANG_THUC_HIEN':
      case 'Đang thực hiện':
        return StatusHoTro.DANG_THUC_HIEN;
      case 'THU_HOI':
        return StatusHoTro.THU_HOI;
      case 'Đã hoàn thành':
      case 'DA_HOAN_THANH':
        return StatusHoTro.DA_HOAN_THANH;
      case 'CHO_PHAN_XU_LY':
        return StatusHoTro.CHO_PHAN_XU_LY;
      case 'TRA_LAI':
        return StatusHoTro.TRA_LAI;
      default:
        return StatusHoTro.TRA_LAI;
    }
  }
}
