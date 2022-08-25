import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/confirm_officer_request.dart';
import 'package:ccvc_mobile/domain/model/calendar/officer_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/status_extention.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/btn_show_chinh_sua_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/widgets/bottom_sheet_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/show_bottom_sheet_ds_y_Kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/bottom_sheet_y_kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/widget/item_row.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/tablet/widget/thu_hoi_lich_lam_viec.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/cu_can_bo_di_thay_lich_lam_viec_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/cu_can_bo_lich_lam_viec_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/document_file.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/sua_lich_cong_tac_trong_nuoc/ui/tablet/edit_work_calendar_tablet.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/them_link_hop_dialog.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/tablet/create_calendar_work_tablet.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ChiTietLamViecTablet extends StatefulWidget {
  final String id;

  const ChiTietLamViecTablet({Key? key, this.id = ''}) : super(key: key);

  @override
  _ChiTietLamViecTabletState createState() => _ChiTietLamViecTabletState();
}

class _ChiTietLamViecTabletState extends State<ChiTietLamViecTablet> {
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();
  final ThanhPhanThamGiaCubit cubitThanhPhan = ThanhPhanThamGiaCubit();
  final ThemCanBoCubit themCanBoCubit = ThemCanBoCubit();
  final ThemDonViCubit themDonViCubit = ThemDonViCubit();

  @override
  void initState() {
    super.initState();
    chiTietLichLamViecCubit.loadApi(widget.id);
    cubitThanhPhan.getTree();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException('', S.current.something_went_wrong),
      stream: chiTietLichLamViecCubit.stateStream,
      child: StreamBuilder<ChiTietLichLamViecModel>(
        stream: chiTietLichLamViecCubit.chiTietLichLamViecStream,
        builder: (context, snapshot) {
          final dataModel = snapshot.data ?? ChiTietLichLamViecModel();
          chiTietLichLamViecCubit.checkXoa(dataModel);
          chiTietLichLamViecCubit.nguoiDuocMoi(dataModel);
          chiTietLichLamViecCubit.canBoChuTri(dataModel);
          chiTietLichLamViecCubit.nguoiTaoId(dataModel);
          List<CellPopPupMenu> listAction = [];
          if (dataModel.status != EnumScheduleStatus.Cancel &&
              !chiTietLichLamViecCubit.checkMenuLichThuHoi(dataModel)) {
            listAction = [
              ///huy
              if (chiTietLichLamViecCubit.checkChoSuaLich(dataModel))
                CellPopPupMenu(
                  urlImage: ImageAssets.icHuy,
                  text: S.current.huy,
                  onTap: () {
                    checkCancelDuplicateCal(
                      dataModel.isLichLap ?? false,
                    );
                  },
                ),

              ///bao cao ket qua
              if (chiTietLichLamViecCubit.checkChoBaoCaoKetQua(dataModel))
                CellPopPupMenu(
                  urlImage: ImageAssets.icChartFocus,
                  text: S.current.bao_cao_ket_qua,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      title: S.current.bao_cao_ket_qua,
                      child: BaoCaoBottomSheet(
                        scheduleId: widget.id,
                        cubit: BaoCaoKetQuaCubit(),
                        listTinhTrangBaoCao:
                            chiTietLichLamViecCubit.listTinhTrang,
                      ),
                      isBottomShow: false,
                      funcBtnOk: () {
                        Navigator.pop(context);
                      },
                    ).then((value) {
                      if (value is bool && value) {
                        chiTietLichLamViecCubit
                            .getDanhSachBaoCaoKetQua(widget.id);
                      }
                    });
                  },
                ),

              ///cho y kien
              if (chiTietLichLamViecCubit.checkChoYKien(dataModel))
                CellPopPupMenu(
                  urlImage: ImageAssets.icChoYKien,
                  text: S.current.cho_y_kien,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      title: S.current.y_kien,
                      child: YKienBottomSheet(
                        isTablet: true,
                        id: widget.id,
                        isCheck: false,
                        isCalendarWork: true,
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

              ///xoa lich
              if (chiTietLichLamViecCubit.checkChoxoa(dataModel))
                CellPopPupMenu(
                  urlImage: ImageAssets.icDelete,
                  text: S.current.xoa_lich,
                  onTap: () {
                    checkDeleteDuplicateCal(
                      dataModel.isLichLap ?? false,
                    );
                  },
                ),

              ///thu hoi lich
              if (chiTietLichLamViecCubit.checkChoThuHoi(dataModel))
                CellPopPupMenu(
                  urlImage: ImageAssets.icRecall,
                  text: S.current.thu_hoi,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      maxHeight: 280,
                      title: S.current.thu_hoi_lich,
                      child: RecallCalendar(
                        cubit: chiTietLichLamViecCubit,
                        callback: () {
                          checkRecallDuplicateCal(
                            dataModel.isLichLap ?? false,
                          );
                        },
                      ),
                      isBottomShow: false,
                      funcBtnOk: () {},
                    );
                  },
                ),

              ///sua lich
              if (chiTietLichLamViecCubit.checkChoSuaLich(dataModel))
                CellPopPupMenu(
                  urlImage: ImageAssets.icEditBlue,
                  text: S.current.sua_lich,
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => EditWorkCalendarTablet(
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

              ///Xac nhan lai
              if (chiTietLichLamViecCubit.checkChoXacNhanLai(dataModel))
                CellPopPupMenu(
                  urlImage: ImageAssets.icXacNhanLai,
                  text: S.current.xac_nhan_lai,
                  onTap: () {
                    showDiaLog(
                      context,
                      showTablet: true,
                      btnLeftTxt: S.current.khong,
                      funcBtnRight: () {
                        chiTietLichLamViecCubit
                            .confirmOfficerOrDismissconfirmOfficer(
                          ConfirmOfficerRequest(
                            lichId: dataModel.id,
                            isThamGia: true,
                            lyDo: '',
                          ),
                        )
                            .then((value) {
                          if (value) {
                            MessageConfig.show(
                              title: '${S.current.xac_nhan_lai}'
                                  ' ${S.current.thanh_cong.toLowerCase()}',
                            );
                            eventBus.fire(RefreshCalendar());
                            Get.back(result: true);
                          } else {
                            MessageConfig.show(
                              messState: MessState.error,
                              title: ' ${S.current.xac_nhan_lai}'
                                  ' ${S.current.that_bai.toLowerCase()}',
                            );
                          }
                        });
                      },
                      title: S.current.xac_nhan_lai,
                      btnRightTxt: S.current.dong_y,
                      icon: SvgPicture.asset(ImageAssets.img_tham_gia),
                      textContent: S.current.confirm_tham_gia,
                    );
                  },
                ),
              if (chiTietLichLamViecCubit.checkChoHuyXacNhan(dataModel))

                ///Huy xac nhan
                CellPopPupMenu(
                  urlImage: ImageAssets.icHuy,
                  text: S.current.huy_xac_nhan,
                  onTap: () {
                    showDiaLog(
                      context,
                      showTablet: true,
                      btnLeftTxt: S.current.khong,
                      funcBtnRight: () {
                        chiTietLichLamViecCubit
                            .confirmOfficerOrDismissconfirmOfficer(
                          ConfirmOfficerRequest(
                            lichId: dataModel.id,
                            isThamGia: false,
                            lyDo: '',
                          ),
                        )
                            .then((value) {
                          if (value) {
                            MessageConfig.show(
                              title: '${S.current.huy}'
                                  ' ${S.current.xac_nhan.toLowerCase()}'
                                  ' ${S.current.thanh_cong.toLowerCase()}',
                            );
                            eventBus.fire(RefreshCalendar());
                            Get.back(result: true);
                          } else {
                            MessageConfig.show(
                              messState: MessState.error,
                              title: '${S.current.huy}'
                                  ' ${S.current.xac_nhan.toLowerCase()}'
                                  ' ${S.current.that_bai.toLowerCase()}',
                            );
                          }
                        });
                      },
                      title: '${S.current.huy}'
                          ' ${S.current.xac_nhan.toLowerCase()}',
                      btnRightTxt: S.current.dong_y,
                      icon: SvgPicture.asset(ImageAssets.img_tham_gia),
                      textContent: S.current.confirm_huy_tham_gia,
                    );
                  },
                ),

              /// Cu can bo di thay
              if (chiTietLichLamViecCubit.checkChoCuCanBoDiThay(dataModel))
                CellPopPupMenu(
                  urlImage: ImageAssets.icCuCanBoDiThay,
                  text: S.current.cu_can_bo_di_thay,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      title: S.current.cu_can_bo_di_thay,
                      child: CuCanBoDiThayLichLamViecWidget(
                        themCanBoCubit: themCanBoCubit,
                        cubit: chiTietLichLamViecCubit,
                        cubitThanhPhanTG: cubitThanhPhan,
                        themDonViCubit: themDonViCubit,
                      ),
                      isBottomShow: false,
                      funcBtnOk: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              if (chiTietLichLamViecCubit.checkChoCuCanBo(dataModel))
                //cu can bo
                CellPopPupMenu(
                  urlImage: ImageAssets.icCuCanBo,
                  text: S.current.cu_can_bo,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      title: S.current.cu_can_bo,
                      child: CuCanBoLichLamViecWidget(
                        themCanBoCubit: themCanBoCubit,
                        cubit: chiTietLichLamViecCubit,
                        cubitThanhPhanTG: cubitThanhPhan,
                        themDonViCubit: themDonViCubit,
                      ),
                      isBottomShow: false,
                      funcBtnOk: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                )
            ];
          }
          final isThuHoiOrHuy = chiTietLichLamViecCubit.isLichHuy(dataModel) ||
              chiTietLichLamViecCubit.isLichThuHoi(dataModel);
          final showDetail = chiTietLichLamViecCubit.showDetail(dataModel);
          return snapshot.data != null
              ? dataModel.id != null
                  ? Scaffold(
                      backgroundColor: bgWidgets,
                      appBar: BaseAppBar(
                        title: S.current.chi_tiet_lich_lam_viec,
                        actions: listAction.isNotEmpty && !isThuHoiOrHuy
                            ? [
                                MenuSelectWidget(
                                  listSelect: listAction,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ]
                            : null,
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
                        padding: const EdgeInsets.only(
                          top: 28,
                          left: 30,
                          right: 30,
                          bottom: 28,
                        ),
                        margin: const EdgeInsets.only(
                          top: 28,
                          left: 30,
                          right: 30,
                          bottom: 28,
                        ),
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
                          child: ExpandGroup(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
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
                                              Expanded(
                                                child: Text(
                                                  dataModel.title ?? '',
                                                  style: textNormalCustom(
                                                    color: textTitle,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          ItemRowChiTiet(
                                            data: dataModel,
                                            cubit: chiTietLichLamViecCubit,
                                          ),
                                        ],
                                      ),
                                      spaceH16,
                                      if (showDetail)
                                        BtnShowChinhSuaBaoCao(
                                          chiTietLichLamViecCubit:
                                              chiTietLichLamViecCubit,
                                          dataModel: dataModel,
                                        ),
                                      if (showDetail)
                                        DanhSachYKienButtom(
                                          dataModel: dataModel,
                                          isTablet: true,
                                          id: widget.id,
                                          cubit: chiTietLichLamViecCubit,
                                        ),
                                      spaceH12,
                                      StreamBuilder<bool>(
                                          stream: chiTietLichLamViecCubit
                                              .showButtonApprove,
                                          builder: (context, snapshot) {
                                            final data = snapshot.data ?? false;
                                            return Visibility(
                                              visible: data,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: bottomButtonWidget(
                                                      background:
                                                          AppTheme.getInstance()
                                                              .colorField()
                                                              .withOpacity(0.1),
                                                      title: S.current.tu_choi,
                                                      onTap: () {
                                                        chiTietLichLamViecCubit
                                                            .confirmOfficer(
                                                          ConfirmOfficerRequest(
                                                            lichId:
                                                                dataModel.id,
                                                            isThamGia: false,
                                                            lyDo: '',
                                                          ),
                                                        )
                                                            .then((value) {
                                                          chiTietLichLamViecCubit
                                                              .loadApi(
                                                            widget.id,
                                                          );
                                                        });
                                                      },
                                                      textColor:
                                                          AppTheme.getInstance()
                                                              .colorField(),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Expanded(
                                                    child: bottomButtonWidget(
                                                      background:
                                                          AppTheme.getInstance()
                                                              .colorField(),
                                                      title: S.current.tham_du,
                                                      onTap: () {
                                                        chiTietLichLamViecCubit
                                                            .confirmOfficer(
                                                          ConfirmOfficerRequest(
                                                            lichId:
                                                                dataModel.id,
                                                            isThamGia: true,
                                                            lyDo: '',
                                                          ),
                                                        )
                                                            .then((value) {
                                                          chiTietLichLamViecCubit
                                                              .loadApi(
                                                                  widget.id);
                                                        });
                                                      },
                                                      textColor: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                      if (chiTietLichLamViecCubit
                                              .checkChoHuyXacNhan(dataModel) &&
                                          dataModel.status !=
                                              EnumScheduleStatus.Cancel &&
                                          !chiTietLichLamViecCubit
                                              .checkMenuLichThuHoi(dataModel))
                                        bottomButtonWidget(
                                          background: statusCalenderRed,
                                          title: S.current.huy_xac_nhan,
                                          onTap: () {
                                            showDiaLog(
                                              context,
                                              showTablet: true,
                                              btnLeftTxt: S.current.khong,
                                              funcBtnRight: () {
                                                chiTietLichLamViecCubit
                                                    .confirmOfficerOrDismissconfirmOfficer(
                                                  ConfirmOfficerRequest(
                                                    lichId: dataModel.id,
                                                    isThamGia: false,
                                                    lyDo: '',
                                                  ),
                                                )
                                                    .then((value) {
                                                  if (value) {
                                                    MessageConfig.show(
                                                      title: '${S.current.huy}'
                                                          ' ${S.current.xac_nhan.toLowerCase()}'
                                                          ' ${S.current.thanh_cong.toLowerCase()}',
                                                    );
                                                    eventBus.fire(
                                                        RefreshCalendar());
                                                    Get.back(result: true);
                                                  } else {
                                                    MessageConfig.show(
                                                      messState:
                                                          MessState.error,
                                                      title: '${S.current.huy}'
                                                          ' ${S.current.xac_nhan.toLowerCase()}'
                                                          ' ${S.current.that_bai.toLowerCase()}',
                                                    );
                                                  }
                                                });
                                              },
                                              title: '${S.current.huy}'
                                                  ' ${S.current.xac_nhan.toLowerCase()}',
                                              btnRightTxt: S.current.dong_y,
                                              icon: SvgPicture.asset(
                                                  ImageAssets.img_tham_gia),
                                              textContent: S
                                                  .current.confirm_huy_tham_gia,
                                            );
                                          },
                                          textColor: Colors.white,
                                        ),
                                      if (chiTietLichLamViecCubit
                                              .checkChoXacNhanLai(dataModel) &&
                                          dataModel.status !=
                                              EnumScheduleStatus.Cancel &&
                                          !chiTietLichLamViecCubit
                                              .checkMenuLichThuHoi(dataModel))
                                        bottomButtonWidget(
                                          background: itemWidgetUsing,
                                          title: S.current.xac_nhan_lai,
                                          onTap: () {
                                            showDiaLog(
                                              context,
                                              showTablet: true,
                                              btnLeftTxt: S.current.khong,
                                              funcBtnRight: () {
                                                chiTietLichLamViecCubit
                                                    .confirmOfficerOrDismissconfirmOfficer(
                                                  ConfirmOfficerRequest(
                                                    lichId: dataModel.id,
                                                    isThamGia: true,
                                                    lyDo: '',
                                                  ),
                                                )
                                                    .then((value) {
                                                  if (value) {
                                                    MessageConfig.show(
                                                      title:
                                                          '${S.current.xac_nhan_lai}'
                                                          ' ${S.current.thanh_cong.toLowerCase()}',
                                                    );
                                                    eventBus.fire(
                                                        RefreshCalendar());
                                                    Get.back(result: true);
                                                  } else {
                                                    MessageConfig.show(
                                                      messState:
                                                          MessState.error,
                                                      title:
                                                          ' ${S.current.xac_nhan_lai}'
                                                          ' ${S.current.that_bai.toLowerCase()}',
                                                    );
                                                  }
                                                });
                                              },
                                              title: S.current.xac_nhan_lai,
                                              btnRightTxt: S.current.dong_y,
                                              icon: SvgPicture.asset(
                                                  ImageAssets.img_tham_gia),
                                              textContent:
                                                  S.current.confirm_tham_gia,
                                            );
                                          },
                                          textColor: Colors.white,
                                        ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      if (showDetail) ...[
                                        listScheduleCooperatives(),
                                        StreamBuilder<ChiTietLichLamViecModel>(
                                          stream: chiTietLichLamViecCubit
                                              .chiTietLichLamViecStream,
                                          builder: (context, snapshot) {
                                            final data =
                                                snapshot.data?.files ?? [];
                                            return DocumentFile(
                                              files: data,
                                            );
                                          },
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Scaffold(
                      appBar: BaseAppBar(
                        title: S.current.chi_tiet_lich_lam_viec,
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
                      body: Center(
                        child: Text(
                          S.current.no_data,
                          style: textNormalCustom(
                            fontSize: 14.0.textScale(),
                            color: AppTheme.getInstance().colorField(),
                          ),
                        ),
                      ),
                    )
              : const Scaffold();
        },
      ),
    );
  }

  void checkRecallDuplicateCal(bool isDup) {
    showDialog(
      context: context,
      builder: (context) => ThemLinkHopDialog(
        title: S.current.thu_hoi_lich,
        isConfirm: false,
        isShowRadio: isDup,
        imageUrl: ImageAssets.icThuHoi,
        textConfirm: S.current.ban_co_chac_muon_thu_hoi_lich,
        textRadioAbove: S.current.chi_thu_hoi_lich_nay,
        textRadioBelow: S.current.tu_lich_nay,
        onConfirm: (value) {
          chiTietLichLamViecCubit.recallCalendar(isMulti: !(value ?? true));
        },
      ),
    );
  }

  void checkDeleteDuplicateCal(bool isDup) {
    showDialog(
      context: context,
      builder: (context) => ThemLinkHopDialog(
        title: S.current.xoa_lich_lam_viec,
        isConfirm: false,
        isShowRadio: isDup,
        imageUrl: ImageAssets.icDeleteLichHop,
        textConfirm: S.current.ban_co_muon_xoa_lich_lam_viec,
        textRadioAbove: S.current.chi_xoa_lich_nay,
        textRadioBelow: S.current.tu_lich_nay,
        onConfirm: (value) {
          chiTietLichLamViecCubit.deleteCalendarWork(
            widget.id,
            only: value,
          );
        },
      ),
    );
  }

  void checkCancelDuplicateCal(bool isDup) {
    showDialog(
      context: context,
      builder: (context) => ThemLinkHopDialog(
        title: S.current.huy_lich,
        isConfirm: false,
        imageUrl: ImageAssets.icHuyLich,
        textConfirm: S.current.ban_co_chac_muon_huy_lich,
        textRadioAbove: S.current.chi_huy_lich_nay,
        textRadioBelow: S.current.tu_lich_nay,
        isShowRadio: isDup,
        onConfirm: (value) {
          chiTietLichLamViecCubit.cancelCalendarWork(
            widget.id,
            isMulti: !(value ?? true),
          );
        },
      ),
    );
  }

  Widget listScheduleCooperatives() {
    return ExpandOnlyWidget(
      header: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          S.current.thanh_phan_tham_gia,
          style: textNormalCustom(
            color: titleColumn,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: StreamBuilder<List<Officer>>(
        stream: chiTietLichLamViecCubit.listOfficer.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return const NodataWidget(
              height: 50,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(
              left: 24,
            ),
            shrinkWrap: true,
            itemCount: data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return itemScheduleCooperatives(data[index]);
            },
          );
        },
      ),
    );
  }

  Widget itemScheduleCooperatives(Officer data) {
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
          rowTextData(data.tenDonVi ?? '', S.current.don_vi_phoi_hop),
          spaceH8,
          rowTextData(data.hoTen ?? '', S.current.nguoi_phoi_hop),
          spaceH8,
          rowTextData(data.taskContent ?? '', S.current.nd_cong_viec),
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
