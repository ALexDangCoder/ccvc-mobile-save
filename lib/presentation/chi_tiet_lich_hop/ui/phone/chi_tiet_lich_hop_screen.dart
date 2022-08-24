import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/tab_widget_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/permission_type.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/status_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tham_gia_cuoc_hop_button.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thong_tin_lien_he_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailMeetCalenderScreen extends StatefulWidget {
  final String id;

  const DetailMeetCalenderScreen({Key? key, required this.id})
      : super(key: key);

  @override
  State<DetailMeetCalenderScreen> createState() =>
      _DetailMeetCalenderScreenState();
}

class _DetailMeetCalenderScreenState extends State<DetailMeetCalenderScreen> {
  DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
  final ThanhPhanThamGiaCubit _cubitThanhPhan = ThanhPhanThamGiaCubit();
  final ThemCanBoCubit themCanBoCubit = ThemCanBoCubit();
  final ThemDonViCubit themDonViCubit = ThemDonViCubit();

  @override
  void initState() {
    super.initState();
    cubit.idCuocHop = widget.id;
    cubit.getListPhienHop(cubit.idCuocHop);
    _cubitThanhPhan.getTree();
    cubit
        .initDataChiTiet(needCheckPermission: true)
        .then((value) => setState(() {}));
    _refreshThanhPhanThamGia();
  }

  void _refreshThanhPhanThamGia() {
    eventBus.on<RefreshThanhPhanThamGia>().listen((event) {
      cubit.getDanhSachNguoiChuTriPhienHop(id: cubit.idCuocHop);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException(
        S.current.error,
        S.current.error,
      ),
      stream: cubit.stateStream,
      child: Scaffold(
        appBar: appbarChiTietHop(
          cubit,
          context,
          _cubitThanhPhan,
          themCanBoCubit,
          themDonViCubit,
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, cubit.needRefreshMainMeeting);
            return true;
          },
          child: ProviderWidget<DetailMeetCalenderCubit>(
            cubit: cubit,
            child: ExpandGroup(
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.initDataChiTiet();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: StreamBuilder<ChiTietLichHopModel>(
                          stream: cubit.chiTietLichHopSubject.stream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox();
                            }
                            final data = snapshot.data ?? ChiTietLichHopModel();
                            return Column(
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
                                    Expanded(
                                      child: Text(
                                        data.title,
                                        style: textNormalCustom(
                                          color: titleCalenderWork,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: data.valueData().map(
                                    (element) {
                                      if (element is HopTrucTuyenRow) {
                                        return ThamGiaCuocHopWidget(
                                          link: element.link,
                                        );
                                      }
                                      return Container(
                                        margin: const EdgeInsets.only(top: 16),
                                        child: RowDataWidget(
                                          urlIcon: element.urlIcon,
                                          text: element.text,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                                spaceH16,
                                StatusWidget(
                                  status: data.getStatus,
                                ),
                                spaceH16,
                                ThongTinLienHeWidget(
                                  thongTinTxt: data.chuTriModel.dauMoiLienHe,
                                  sdtTxt: data.chuTriModel.soDienThoai,
                                  dsDiemCau: data.dsDiemCau ?? [],
                                  thuMoiFiles: data.fileDinhKemWithDecode ?? [],
                                )
                              ],
                            );
                          },
                        ),
                      ),

                      /// list item drop down
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.getListWidgetDetailSubject.length,
                        itemBuilder: (context, index) {
                          return cubit.getListWidgetDetailSubject[index]
                              .getWidget(cubit);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: StreamBuilder<List<PERMISSION_DETAIL>>(
                          stream: cubit.listButtonSubject.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            if (data.contains(
                                  PERMISSION_DETAIL.XAC_NHAN_THAM_GIA,
                                ) &&
                                data.contains(
                                  PERMISSION_DETAIL.TU_CHOI_THAM_GIA,
                                ) &&
                                !cubit.trangThaiHuy() &&
                                !cubit.trangThaiThuHoi()) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: DoubleButtonBottom(
                                  title1: S.current.tu_choi,
                                  title2: S.current.tham_du,
                                  onClickRight: () {
                                    showDiaLog(
                                      context,
                                      btnLeftTxt: S.current.khong,
                                      funcBtnRight: () {
                                        cubit
                                            .confirmThamGiaHop(
                                          lichHopId:
                                              cubit.getChiTietLichHopModel.id,
                                          isThamGia: true,
                                        )
                                            .then((value) {
                                          if (value) {
                                            MessageConfig.show(
                                              title:
                                                  '${S.current.xac_nhan_tham_gia}'
                                                  ' ${S.current.thanh_cong.toLowerCase()}',
                                            );
                                            cubit.initDataChiTiet(
                                              needCheckPermission: true,
                                            );
                                          } else {
                                            MessageConfig.show(
                                              messState: MessState.error,
                                              title:
                                                  '${S.current.xac_nhan_tham_gia}'
                                                  ' ${S.current.that_bai.toLowerCase()}',
                                            );
                                          }
                                        });
                                      },
                                      title: S.current.xac_nhan_tham_gia,
                                      btnRightTxt: S.current.dong_y,
                                      icon: SvgPicture.asset(
                                        ImageAssets.img_tham_gia,
                                      ),
                                      textContent: S.current.confirm_tham_gia,
                                    );
                                  },
                                  onClickLeft: () {
                                    showDiaLog(
                                      context,
                                      btnLeftTxt: S.current.khong,
                                      funcBtnRight: () {
                                        cubit
                                            .confirmThamGiaHop(
                                          lichHopId:
                                              cubit.getChiTietLichHopModel.id,
                                          isThamGia: false,
                                        )
                                            .then((value) {
                                          if (value) {
                                            MessageConfig.show(
                                              title:
                                                  '${S.current.tu_choi_tham_gia} '
                                                  '${S.current.thanh_cong.toLowerCase()}',
                                            );
                                            cubit.initDataChiTiet(
                                              needCheckPermission: true,
                                            );
                                          } else {
                                            MessageConfig.show(
                                              messState: MessState.error,
                                              title:
                                                  '${S.current.tu_choi_tham_gia}'
                                                  ' ${S.current.that_bai.toLowerCase()}',
                                            );
                                          }
                                        });
                                      },
                                      title: S.current.tu_choi_tham_gia,
                                      btnRightTxt: S.current.dong_y,
                                      icon: SvgPicture.asset(
                                          ImageAssets.img_tu_choi_tham_gia),
                                      textContent:
                                          S.current.confirm_tu_choi_tham_gia,
                                    );
                                  },
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemListKetThuc({
    required String icon,
    required String name,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColorApp,
        width: 170,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: SvgPicture.asset(icon)),
            SizedBox(
              width: 10.0.textScale(),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: textNormalCustom(
                      color: textTitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0.textScale(),
                    ),
                  ),
                  SizedBox(
                    height: 14.0.textScale(),
                  ),
                  Container(
                    height: 1,
                    color: borderColor.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: 14.0.textScale(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///for phone and tab
PreferredSizeWidget appbarChiTietHop(
  DetailMeetCalenderCubit cubit,
  BuildContext context,
  ThanhPhanThamGiaCubit thanhPhanThamGiaCubit,
  ThemCanBoCubit themCanBoCubit,
  ThemDonViCubit themDonViCubit,
) {
  return BaseAppBar(
    title: S.current.chi_tiet_lich_hop,
    leadingIcon: IconButton(
      onPressed: () {
        Navigator.pop(context, cubit.needRefreshMainMeeting);
      },
      icon: SvgPicture.asset(
        ImageAssets.icBack,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: StreamBuilder<List<PERMISSION_DETAIL>>(
          stream: cubit.listButtonSubject.stream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [];
            final isHuyOrThuHoi =
                cubit.trangThaiHuy() || cubit.trangThaiThuHoi();
            if (!isHuyOrThuHoi && data.isNotEmpty) {
              return MenuSelectWidget(
                listSelect: data
                    .map(
                      (e) => e.getMenuLichHop(
                        context,
                        cubit,
                        thanhPhanThamGiaCubit,
                        themCanBoCubit,
                        themDonViCubit,
                      ),
                    )
                    .toList(),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      )
    ],
  );
}
