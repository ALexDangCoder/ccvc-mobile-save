import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/cong_tac_chuan_bi_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/chuong_trinh_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/y_kien_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/sua_lich_hop_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/thong_tin_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/boc_bang_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/moi_nguoi_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/phan_cong_thu_ky.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_boc_bang_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thu_hoi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/radio_option_dialog.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DetailMeetCalenderTablet extends StatefulWidget {
  final String id;

  const DetailMeetCalenderTablet({Key? key, required this.id})
      : super(key: key);

  @override
  State<DetailMeetCalenderTablet> createState() =>
      _DetailMeetCalenderTabletState();
}

class _DetailMeetCalenderTabletState extends State<DetailMeetCalenderTablet>
    with SingleTickerProviderStateMixin {
  late DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
  late TabController _controller;

  @override
  void initState() {
    cubit.idCuocHop = widget.id;
    cubit.initDataChiTiet(isInitState: true);
    _controller = TabController(vsync: this, length: 9);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: BaseAppBar(
        title: S.current.chi_tiet_lich_hop,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: MenuSelectWidget(
              listSelect: [
                CellPopPupMenu(
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
                      showTablet: true,
                    );
                  },
                ),
                CellPopPupMenu(
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
                      showTablet: true,
                    );
                  },
                ),
                CellPopPupMenu(
                  urlImage: ImageAssets.icEditBlue,
                  text: S.current.sua_lich,
                  onTap: () {
                    if (cubit.getChiTietLichHopModel.typeRepeat == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SuaLichHopTabletScreen(
                            chiTietHop: cubit.getChiTietLichHopModel,
                          ),
                        ),
                      ).then((value) {
                        if (value == null) {
                          return;
                        }
                        if (value) {
                          cubit.initDataChiTiet();
                          cubit.callApiCongTacChuanBi();
                        }
                      });
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) => RadioOptionDialog(
                        title: S.current.sua_lich_hop,
                        textRadioBelow: S.current.chi_lich_hien_tai,
                        textRadioAbove: S.current.tu_hien_tai_ve_sau,
                        imageUrl: ImageAssets.img_sua_lich,
                      ),
                    ).then((value) {
                      if (value == null) {
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SuaLichHopTabletScreen(
                            chiTietHop: cubit.getChiTietLichHopModel,
                            isMulti: value,
                          ),
                        ),
                      ).then((value) {
                        if (value == null) {
                          return;
                        }
                        if (value) {
                          cubit.initDataChiTiet();
                          cubit.callApiCongTacChuanBi();
                        }
                      });
                    });
                  },
                ),
                CellPopPupMenu(
                  urlImage: ImageAssets.icThuHoi,
                  text: S.current.thu_hoi,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      maxHeight: 280,
                      title: S.current.thu_hoi_lich,
                      child: ThuHoiLichWidget(
                        cubit: cubit,
                        id: widget.id,
                      ),
                      isBottomShow: false,
                      funcBtnOk: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                CellPopPupMenu(
                  urlImage: ImageAssets.icPhanCongThuKy,
                  text: S.current.phan_cong_thu_ky,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      maxHeight: 280,
                      title: S.current.phan_cong_thu_ky,
                      child: PhanCongThuKyWidget(
                        cubit: cubit,
                        id: widget.id,
                      ),
                      isBottomShow: false,
                      funcBtnOk: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                CellPopPupMenu(
                  urlImage: ImageAssets.icTaoBocBang,
                  text: S.current.tao_boc_bang_cuoc_hop,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      maxHeight: 280,
                      title: S.current.tao_boc_bang_cuoc_hop,
                      child: const TaoBocBangWidget(),
                      isBottomShow: false,
                      funcBtnOk: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, right: 16.0, left: 16.0),
        child: DefaultTabController(
          length: 9,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: ExpandGroup(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          border:
                              Border.all(color: borderColor.withOpacity(0.5)),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 10,
                                color: shadowContainerColor.withOpacity(0.05))
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ThongTinCuocHopWidget(
                                cubit: cubit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ];
            },
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
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: backgroundColorApp,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    border: Border.all(color: borderColor.withOpacity(0.5)),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                          color: shadowContainerColor.withOpacity(0.05))
                    ],
                  ),
                  child: StickyHeader(
                    overlapHeaders: true,
                    header: TabBar(
                      controller: _controller,
                      unselectedLabelStyle: textNormalCustom(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      indicatorColor: indicatorColor,
                      unselectedLabelColor: colorA2AEBD,
                      labelColor: indicatorColor,
                      labelStyle: textNormalCustom(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            S.current.cong_tac_chuan_bi,
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.current.chuong_trinh_hop,
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.current.thanh_phan_tham_gia,
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.current.tai_lieu,
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.current.phat_bieu,
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.current.bieu_quyet,
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.current.ket_luan_hop,
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.current.y_kien_cuop_hop,
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.current.boc_bang,
                          ),
                        ),
                      ],
                    ),
                    content: TabBarView(
                      controller: _controller,
                      children: [
                        CongTacChuanBiWidget(
                          cubit: cubit,
                        ),
                        ChuongTrinhHopWidget(
                          cubit: cubit,
                        ),
                        ThanhPhanThamGiaWidget(
                          cubit: cubit,
                        ),
                        TaiLieuWidget(
                          cubit: cubit,
                        ),
                        PhatBieuWidget(
                          cubit: cubit,
                        ),
                        BieuQuyetWidget(
                          cubit: cubit,
                        ),
                        KetLuanHopWidget(cubit: cubit),
                        YKienCuocHopWidget(
                          cubit: cubit,
                        ),
                        BocBangWidget(
                          cubit: cubit,
                          context: context,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
