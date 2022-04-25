import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/chuong_trinh_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/y_kien_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/moi_nguoi_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/phan_cong_thu_ky.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/sua_lich_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_boc_bang_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thong_tin_lien_he_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thu_hoi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
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
  late DetailMeetCalenderCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = DetailMeetCalenderCubit();
    cubit.id = widget.id;
    cubit.initData(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ImageAssets.icBack),
        ),
        title: S.current.chi_tiet_lich_hop,
        actions: [
          MenuSelectWidget(
            listSelect: [
              QData(
                urlImage: ImageAssets.icHuy,
                text: S.current.huy_lich_hop,
                onTap: () {
                  showDiaLog(
                    context,
                    textContent: S.current.ban_chan_chan_huy_lich_nay,
                    btnLeftTxt: S.current.khong,
                    funcBtnRight: () {
                      cubit.huyChiTietLichHop(widget.id);
                      Navigator.pop(context);
                    },
                    title: S.current.huy_lich,
                    btnRightTxt: S.current.dong_y,
                    icon: SvgPicture.asset(ImageAssets.icHuyLich),
                  );
                },
              ),
              QData(
                urlImage: ImageAssets.ic_delete_do,
                text: S.current.xoa_lich,
                onTap: () {
                  showDiaLog(
                    context,
                    textContent: S.current.xoa_chi_tiet_lich_hop,
                    btnLeftTxt: S.current.khong,
                    funcBtnRight: () {
                      cubit.deleteChiTietLichHop(widget.id);
                      Navigator.pop(context);
                    },
                    title: S.current.khong,
                    btnRightTxt: S.current.dong_y,
                    icon: SvgPicture.asset(ImageAssets.icHuyLich),
                  );
                },
              ),
              QData(
                urlImage: ImageAssets.icEditBlue,
                text: S.current.sua_lich,
                onTap: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.sua_lich_hop,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: SuaLichHopWidget(
                        cubit: cubit,
                      ),
                    ),
                  );
                },
              ),
              QData(
                urlImage: ImageAssets.icThuHoi,
                text: S.current.thu_hoi,
                onTap: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.thu_hoi_lich,
                    child: const ThuHoiLichWidget(),
                  );
                },
              ),
              QData(
                urlImage: ImageAssets.icPhanCongThuKy,
                text: S.current.phan_cong_thu_ky,
                onTap: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.phan_cong_thu_ky,
                    child: PhanCongThuKyWidget(
                      cubit: cubit,
                      id: widget.id,
                    ),
                  );
                },
              ),
              QData(
                urlImage: ImageAssets.icTaoBocBang,
                text: S.current.tao_boc_bang_cuoc_hop,
                onTap: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.tao_boc_bang_cuoc_hop,
                    child: const TaoBocBangWidget(),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: ProviderWidget<DetailMeetCalenderCubit>(
        cubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: cubit.stateStream,
          child: DetailMeetCalendarInherited(
            cubit: cubit,
            child: ExpandGroup(
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.initData(id: widget.id);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      StreamBuilder<ChiTietLichHopModel>(
                        stream: cubit.chiTietLichLamViecSubject,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
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
                                  Text(
                                    data.title,
                                    style: textNormalCustom(
                                      color: titleCalenderWork,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: data
                                    .valueData()
                                    .map(
                                      (e) => Container(
                                        margin: const EdgeInsets.only(top: 16),
                                        child: RowDataWidget(
                                          urlIcon: e.urlIcon,
                                          text: e.text,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              spaceH16,
                              ThongTinLienHeWidget(
                                thongTinTxt: data.chuTriModel.dauMoiLienHe,
                                sdtTxt: data.chuTriModel.soDienThoai,
                              )
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: CongTacChuanBiWidget(
                          cubit: cubit,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ChuongTrinhHopWidget(
                          id: widget.id,
                          cubit: cubit,
                        ),
                      ),
                      ThanhPhanThamGiaWidget(
                        cubit: cubit,
                      ),
                      TaiLieuWidget(
                        cubit: cubit,
                      ),
                      PhatBieuWidget(
                        cubit: cubit,
                        id: widget.id,
                      ),
                      BieuQuyetWidget(id: widget.id),
                      KetLuanHopWidget(
                        cubit: cubit,
                        id: widget.id,
                      ),
                      YKienCuocHopWidget(
                        id: widget.id,
                        cubit: cubit,
                      )
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

class DetailMeetCalendarInherited extends InheritedWidget {
  DetailMeetCalenderCubit cubit;

  DetailMeetCalendarInherited(
      {Key? key, required this.cubit, required Widget child})
      : super(key: key, child: child);

  static DetailMeetCalendarInherited of(BuildContext context) {
    final DetailMeetCalendarInherited? result = context
        .dependOnInheritedWidgetOfExactType<DetailMeetCalendarInherited>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
