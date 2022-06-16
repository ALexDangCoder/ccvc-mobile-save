import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/status_extention.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bottom_sheet_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/tablet/widgets/btn_show_bao_cao_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/bottom_sheet_y_kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/tablet/show_bottom_sheet_ds_y_Kien_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/widget/item_row.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/sua_lich_cong_tac_trong_nuoc/ui/tablet/sua_lich_cong_tac_trong_nuoc_tablet.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/them_link_hop_dialog.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChiTietLamViecTablet extends StatefulWidget {
  final String id;

  const ChiTietLamViecTablet({Key? key, this.id = ''}) : super(key: key);

  @override
  _ChiTietLamViecTabletState createState() => _ChiTietLamViecTabletState();
}

class _ChiTietLamViecTabletState extends State<ChiTietLamViecTablet> {
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();

  @override
  void initState() {
    super.initState();
    chiTietLichLamViecCubit.loadApi(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChiTietLichLamViecModel>(
        stream: chiTietLichLamViecCubit.chiTietLichLamViecStream,
        builder: (context, snapshot) {
          final dataModel = snapshot.data ?? ChiTietLichLamViecModel();
          return snapshot.data != null
              ? Scaffold(
                  backgroundColor: bgWidgets,
                  appBar: BaseAppBar(
                    title: S.current.chi_tiet_lich_lam_viec,
                    actions: [
                      MenuSelectWidget(
                        listSelect: [
                          CellPopPupMenu(
                            urlImage: ImageAssets.icHuy,
                            text: S.current.huy,
                            onTap: () {
                              checkCancelDuplicateCal(
                                dataModel.isLichLap ?? false,
                              );
                            },
                          ),
                          CellPopPupMenu(
                            urlImage: ImageAssets.icChartFocus,
                            text: S.current.bao_cao_ket_qua,
                            onTap: () {
                              // showBottomSheetCustom(
                              //   context,
                              //   title: S.current.bao_cao_ket_qua,
                              //   child: const BaoCaoBottomSheet(),
                              // );
                            },
                          ),
                          CellPopPupMenu(
                            urlImage: ImageAssets.icChoYKien,
                            text: S.current.cho_y_kien,
                            onTap: () {
                              showDiaLogTablet(
                                context,
                                title: S.current.cho_y_kien,
                                child: YKienBottomSheet(
                                  id: widget.id,
                                  isCheck: false,
                                ),
                                isBottomShow: false,
                                funcBtnOk: () {
                                  Navigator.pop(context);
                                },
                              ).then((value) {
                                if (value == true) {
                                  chiTietLichLamViecCubit.loadApi(widget.id);
                                } else if (value == null) {
                                  return;
                                }
                              });
                            },
                          ),
                          CellPopPupMenu(
                            urlImage: ImageAssets.icDelete,
                            text: S.current.xoa_lich,
                            onTap: () {
                              checkDeleteDuplicateCal(
                                dataModel.isLichLap ?? false,
                              );
                            },
                          ),
                          CellPopPupMenu(
                            urlImage: ImageAssets.icEditBlue,
                            text: S.current.sua_lich,
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SuaLichCongTacTrongNuocTablet(
                                    cubit: chiTietLichLamViecCubit,
                                    event: dataModel,
                                  ),
                                ),
                              )
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pop(context, true);
                                } else if (value == null) {
                                  return;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                    leadingIcon: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AqiColor,
                      ),
                    ),
                  ),
                  body: StateStreamLayout(
                    textEmpty: S.current.khong_co_du_lieu,
                    retry: () {},
                    error: AppException('', S.current.something_went_wrong),
                    stream: chiTietLichLamViecCubit.stateStream,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 28, left: 30, right: 30, bottom: 28),
                      margin: const EdgeInsets.only(
                          top: 28, left: 30, right: 30, bottom: 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: toDayColor.withOpacity(0.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: shadowContainerColor.withOpacity(0.05),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<ChiTietLichLamViecModel>(
                              stream: chiTietLichLamViecCubit
                                  .chiTietLichLamViecStream,
                              builder: (context, snapshot) {
                                final data =
                                    snapshot.data ?? ChiTietLichLamViecModel();
                                return snapshot.data != null
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.circle,
                                                size: 12,
                                                color: statusCalenderRed,
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                data.title ?? '',
                                                style: textNormalCustom(
                                                  color: textTitle,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          ItemRowChiTiet(
                                            data: data,
                                            cubit: chiTietLichLamViecCubit,
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 24),
                              child: BtnShowBaoCaoTablet(
                                cubit: chiTietLichLamViecCubit,
                              ),
                            ),
                            DanhSachYKienButtomTablet(
                              cubit: chiTietLichLamViecCubit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const Scaffold();
        });
  }

  void checkDeleteDuplicateCal(bool isDup) {
    if (isDup) {
      showDialog(
        context: context,
        builder: (context) => ThemLinkHopDialog(
          title: S.current.xoa_lich_lam_viec,
          isConfirm: false,
          imageUrl: ImageAssets.icDeleteLichHop,
          textConfirm: S.current.ban_co_muon_xoa_lich_lam_viec,
          textRadioAbove: S.current.chi_lich_nay,
          textRadioBelow: S.current.tu_lich_nay,
        ),
      ).then(
        (value) => chiTietLichLamViecCubit
            .deleteCalendarWork(widget.id, only: value)
            .then((_) => Navigator.pop(context, true)),
      );
    } else {
      showDiaLog(
        context,
        textContent: S.current.ban_co_muon_xoa_lich_lam_viec,
        btnLeftTxt: S.current.khong,
        funcBtnRight: () async {
          await chiTietLichLamViecCubit.deleteCalendarWork(widget.id).then(
                (_) => Navigator.pop(context, true),
              );
        },
        title: S.current.xoa_lich_lam_viec,
        btnRightTxt: S.current.dong_y,
        icon: SvgPicture.asset(
          ImageAssets.icDeleteLichHop,
        ),
      );
    }
  }
  void checkCancelDuplicateCal(bool isDup) {
    if (isDup) {
      showDialog(
        context: context,
        builder: (context) => ThemLinkHopDialog(
          title: S.current.huy_lich,
          isConfirm: false,
          imageUrl: ImageAssets.icHuyLich,
          textConfirm: S.current.ban_co_chac_muon_huy_lich,
          textRadioAbove: S.current.chi_lich_nay,
          textRadioBelow: S.current.tu_lich_nay,
        ),
      ).then(
            (value) => chiTietLichLamViecCubit
            .cancelCalendarWork(widget.id, isMulti: !value)
            .then((_) => Navigator.pop(context, true)),
      );
    } else {
      showDiaLog(
        context,
        textContent: S.current.ban_co_chac_muon_huy_lich,
        btnLeftTxt: S.current.khong,
        funcBtnRight: () async {
          await chiTietLichLamViecCubit.cancelCalendarWork(widget.id).then(
                (_) => Navigator.pop(context, true),
          );
        },
        title: S.current.huy_lich,
        btnRightTxt: S.current.dong_y,
        icon: SvgPicture.asset(
          ImageAssets.icHuyLich,
        ),
      );
    }
  }


  Widget listScheduleCooperatives(List<DonViModel> listCooperatives) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      shrinkWrap: true,
      itemCount: listCooperatives.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return itemScheduleCooperatives(listCooperatives[index]);
      },
    );
  }


  Widget itemScheduleCooperatives(DonViModel data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: borderItemCalender,
        ),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          rowTextData(data.tenDonVi, S.current.don_vi_phoi_hop),
          spaceH8,
          rowTextData(data.tenCanBo, S.current.nguoi_pho_hop),
          spaceH8,
          rowTextData(data.noidung, S.current.nd_cong_viec),
          spaceH8,
          Row(
            children: [
              SizedBox(
                width: 85,
                child: Text(
                  S.current.trang_thai,
                  style: titleStyleText,
                ),
              ),
              spaceW13,
              Container(
                decoration: BoxDecoration(
                  color: data.getColorStatus,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: Text(
                  data.getTextStatus,
                  style: textNormalCustom(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: backgroundColorApp,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row rowTextData(String value, String title) => Row(
    children: [
      SizedBox(
        width: 85,
        child: Text(
          title,
          style: titleStyleText,
        ),
      ),
      spaceW13,
      Expanded(
        child: Text(
          value,
          style: valueStyleText,
        ),
      )
    ],
  );

  TextStyle get titleStyleText => textNormalCustom(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: infoColor,
  );

  TextStyle get valueStyleText => textNormalCustom(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: titleCalenderWork,
  );

}
