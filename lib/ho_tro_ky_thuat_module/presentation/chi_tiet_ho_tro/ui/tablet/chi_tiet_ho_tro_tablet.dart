import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/cubit/chi_tiet_ho_tro_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/tablet/cap_nhat_tinh_hinh_ho_tro_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/tablet/danh_gia_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChiTietHoTroTablet extends StatefulWidget {
  const ChiTietHoTroTablet({Key? key, required this.idHoTro}) : super(key: key);
  final String idHoTro;

  @override
  _ChiTietHoTroTabletState createState() => _ChiTietHoTroTabletState();
}

class _ChiTietHoTroTabletState extends State<ChiTietHoTroTablet> {
  late ChiTietHoTroCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ChiTietHoTroCubit();
    cubit.getSupportDetail(widget.idHoTro);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 1366),
      builder: () {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: BaseAppBar(
            backGroundColor: bgColor,
            title: S.current.chi_tiet_yeu_cau_ho_tro,
            leadingIcon: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: SvgPicture.asset(
                ImageAssets.icBack,
              ),
            ),
          ),
          body: BlocConsumer<ChiTietHoTroCubit, ChiTietHoTroState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is ChiTietHoTroLoading) {
                cubit.showLoading();
              }
              if (state is ChiTietHoTroSuccess) {
                if (state.completeType == CompleteType.SUCCESS) {
                  cubit.supportDetail =
                      state.supportDetail ?? cubit.supportDetail;
                  cubit.showContent();
                } else {
                  cubit.message = state.errorMess ?? '';
                  cubit.showError();
                }
              }
            },
            builder: (context, state) {
              return StateStreamLayout(
                stream: cubit.stateStream,
                error: AppException(
                  S.current.something_went_wrong,
                  cubit.message,
                ),
                retry: () {
                  cubit.getSupportDetail(widget.idHoTro);
                },
                textEmpty: '',
                child: (state is ChiTietHoTroSuccess)
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 24.w,
                              right: 24.w,
                              top: 24.h,
                              bottom: 24.h,
                            ),
                            padding: EdgeInsets.only(
                              left: 30.w,
                              right: 30.w,
                              top: 30.h,
                              bottom: 28.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r)),
                              border: Border.all(color: cellColorborder),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                spaceH12,
                                title(S.current.thong_tin_yeu_cau),
                                spaceH16,
                                rowItem(
                                  S.current.don_vi,
                                  cubit.supportDetail.donVi,
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.nguoi_yeu_cau,
                                  '${cubit.supportDetail.nguoiYeuCau ?? ''} - '
                                  '${cubit.supportDetail.chucVu ?? ''}',
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.so_dien_thoai_lien_he,
                                  cubit.supportDetail.soDienThoai,
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.ten_thiet_bi,
                                  cubit.supportDetail.tenThietBi,
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.ngay_yeu_cau,
                                  cubit.supportDetail.thoiGianYeuCau,
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.mo_ta_su_co,
                                  cubit.supportDetail.moTaSuCo,
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.dia_chi,
                                  cubit.supportDetail.diaChi,
                                ),
                                spaceH10,
                                loaiSuCo(
                                  cubit.supportDetail.danhSachSuCo ?? [],
                                ),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    spaceW12,
                                    Expanded(
                                      flex: 3,
                                      child:
                                          (cubit.supportDetail.codeTrangThai ??
                                                  '')
                                              .getStatusNV()
                                              .getStatus(),
                                    ),
                                  ],
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.ket_qua_xu_ly,
                                  cubit.supportDetail.ketQuaXuLy,
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.nguoi_xu_ly,
                                  cubit.supportDetail.nguoiXuLy,
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.ngay_hoan_thanh,
                                  cubit.supportDetail.ngayHoanThanh,
                                ),
                                spaceH10,
                                rowItem(
                                  S.current.nhan_xet,
                                  cubit.supportDetail.nhanXet,
                                ),
                                spaceH20,
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 352.w,
                              right: 352.w,
                            ),
                            child: DoubleButtonBottom(
                              onlyOneButton: cubit.checkOnlyButton(),
                              title1: S.current.dong,
                              title2: cubit.checkTitleButton()
                                  ? S.current.cap_nhat_thxl
                                  : S.current.danh_gia,
                              disableRightButton: !cubit.checkTitleButton() &&
                                  cubit.supportDetail.nhanXet.isNotEmpty,
                              onPressed1: () {
                                Navigator.pop(context);
                              },
                              onPressed2: () {
                                confirmUpdateTask();
                              },
                              isTablet: true,
                              noPadding: true,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        );
      },
    );
  }

  void confirmUpdateTask() {
    if (cubit.checkTitleButton()) {
      showDialog(
        context: context,
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: CapNhatTinhHinhHoTroTabLet(
                cubit: cubit,
              ),
            ),
          );
        },
      );
    } else {
      if ((cubit.supportDetail.codeTrangThai ==
                  ChiTietHoTroCubit.DA_HOAN_THANH ||
              cubit.supportDetail.codeTrangThai ==
                  ChiTietHoTroCubit.TU_CHOI_XU_LY) &&
          cubit.isNguoiYeuCau) {
        showDialog(
          context: context,
          builder: (_) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: DanhGiaYeuCauHoTroTabLet(
                  cubit: cubit,
                ),
              ),
            );
          },
        );
      } else {
        MessageConfig.show(
          title: S.current.chua_duoc_danh_gia,
          messState: MessState.error,
        );
      }
    }
  }

  Widget title(String title) {
    return Text(
      title,
      style: textNormalCustom(
        color: color3D5586,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

Widget loaiSuCo(List<SuCoHTKT> list) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          S.current.loai_su_co,
          style: textNormalCustom(
            color: color667793,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      spaceW12,
      Expanded(
        flex: 3,
        child: Wrap(
          spacing: 12, // gap between adjacent chips
          runSpacing: 12, // gap between lines
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
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: Text(
                      '≠${e.tenSuCo}',
                      style: textNormalCustom(
                        color: color3D5586,
                        fontSize: 16,
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
            fontSize: 16,
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
            fontSize: 16,
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
  DANG_XU_LY,
  DA_HOAN_THANH,
  TU_CHOI_XU_LY,
  NONE,
}

extension StatusChiTietNV on StatusHoTro {
  Widget getStatus() {
    switch (this) {
      case StatusHoTro.DANG_CHO_XU_LY:
        return statusTrangThaiXuLy(
          name: S.current.dang_cho_xu_ly,
          background: chuaThucHienColor,
        );
      case StatusHoTro.DANG_XU_LY:
        return statusTrangThaiXuLy(
          name: S.current.dang_xu_ly,
          background: blueNhatChart,
        );
      case StatusHoTro.DA_HOAN_THANH:
        return statusTrangThaiXuLy(
          name: S.current.da_hoan_thanh,
          background: daXuLyColor,
        );
      case StatusHoTro.TU_CHOI_XU_LY:
        return statusTrangThaiXuLy(
          name: S.current.tu_choi_xu_ly,
          background: specialPriceColor,
        );
      case StatusHoTro.NONE:
        return const SizedBox();
    }
  }
}

extension GetStatusNV on String {
  StatusHoTro getStatusNV() {
    switch (this) {
      case ChiTietHoTroCubit.CHUA_XU_LY:
        return StatusHoTro.DANG_CHO_XU_LY;
      case ChiTietHoTroCubit.DANG_XU_LY:
        return StatusHoTro.DANG_XU_LY;
      case ChiTietHoTroCubit.DA_HOAN_THANH:
        return StatusHoTro.DA_HOAN_THANH;
      case ChiTietHoTroCubit.TU_CHOI_XU_LY:
        return StatusHoTro.TU_CHOI_XU_LY;
      default:
        return StatusHoTro.NONE;
    }
  }
}
