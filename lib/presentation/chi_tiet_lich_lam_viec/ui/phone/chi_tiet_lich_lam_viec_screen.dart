import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/status_extention.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/btn_show_chinh_sua_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/widgets/bottom_sheet_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/show_bottom_sheet_ds_y_Kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/bottom_sheet_y_kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/widget/item_row.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/sua_lich_cong_tac_trong_nuoc/ui/phone/sua_lich_cong_tac_trong_nuoc_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/them_link_hop_dialog.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiTietLichLamViecScreen extends StatefulWidget {
  final String id;

  const ChiTietLichLamViecScreen({Key? key, this.id = ''}) : super(key: key);

  @override
  State<ChiTietLichLamViecScreen> createState() =>
      _ChiTietLichLamViecScreenState();
}

class _ChiTietLichLamViecScreenState extends State<ChiTietLichLamViecScreen> {
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();
  final TaoLichLamViecCubit cubit = TaoLichLamViecCubit();

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
        return StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {
            chiTietLichLamViecCubit.loadApi(widget.id);
          },
          error: AppException('', S.current.something_went_wrong),
          stream: chiTietLichLamViecCubit.stateStream,
          child: snapshot.data != null ?  Scaffold(
            appBar: BaseAppBar(
              title: S.current.chi_tiet_lich_lam_viec,
              actions: [
                MenuSelectWidget(
                  listSelect: [
                    CellPopPupMenu(
                      urlImage: ImageAssets.icHuy,
                      text: S.current.huy,
                      onTap: () {
                        showDiaLog(
                          context,
                          textContent: S.current.ban_chan_chan_huy_lich_nay,
                          btnLeftTxt: S.current.khong,
                          funcBtnRight: () async {
                            checkCancelDuplicateCal(
                              dataModel.isLichLap ?? false,
                            );
                          },
                          title: S.current.huy_lich,
                          btnRightTxt: S.current.dong_y,
                          icon: SvgPicture.asset(ImageAssets.icHuyLich),
                        );
                      },
                    ),
                    CellPopPupMenu(
                      urlImage: ImageAssets.icChartFocus,
                      text: S.current.bao_cao_ket_qua,
                      onTap: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.bao_cao_ket_qua,
                          child: BaoCaoBottomSheet(
                            scheduleId: widget.id,
                            cubit: BaoCaoKetQuaCubit(),
                            listTinhTrangBaoCao:
                                chiTietLichLamViecCubit.listTinhTrang,
                          ),
                        ).then((value) {
                          if (value is bool && value) {
                            chiTietLichLamViecCubit
                                .getDanhSachBaoCaoKetQua(widget.id);
                          }
                        });
                      },
                    ),
                    CellPopPupMenu(
                      urlImage: ImageAssets.icChoYKien,
                      text: S.current.cho_y_kien,
                      onTap: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.y_kien,
                          child: YKienBottomSheet(
                            id: widget.id,
                          ),
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
                        showBottomSheetCustom(
                          context,
                          title: '',
                          textOption: false,
                          child: SuaLichCongTacTrongNuocPhone(
                            cubit: chiTietLichLamViecCubit,
                            event: dataModel,
                          ),
                        ).then((value) {
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
            body: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: SingleChildScrollView(
                child: ExpandGroup(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            dataModel.title ?? '',
                            style: textNormalCustom(
                              color: textTitle,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      ItemRowChiTiet(
                        data: dataModel,
                        cubit: chiTietLichLamViecCubit,
                      ),
                      if ((dataModel.scheduleCoperatives ?? []).isNotEmpty)
                        listScheduleCooperatives(
                          dataModel.scheduleCoperatives ?? [],
                        )
                      else
                        const SizedBox.shrink(),
                      spaceH8,
                      BtnShowChinhSuaBaoCao(
                        chiTietLichLamViecCubit: chiTietLichLamViecCubit,
                      ),
                      DanhSachYKienButtom(
                        id: widget.id,
                        cubit: chiTietLichLamViecCubit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ) : const Scaffold(),
        );
      },
    );
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
