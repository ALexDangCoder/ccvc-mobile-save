import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/tab_widget_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/thanh_phan_tham_gia_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cell_thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class ThanhPhanThamGiaWidgetTablet extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const ThanhPhanThamGiaWidgetTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThanhPhanThamGiaWidgetTabletState createState() =>
      _ThanhPhanThamGiaWidgetTabletState();
}

class _ThanhPhanThamGiaWidgetTabletState
    extends State<ThanhPhanThamGiaWidgetTablet> {
  final thanhPhanThamGiaCubit = ThanhPhanThamGiaHopCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!isMobile()) {
      thanhPhanThamGiaCubit.idCuocHop = widget.cubit.idCuocHop;
      thanhPhanThamGiaCubit.detailMeetCalenderCubit = widget.cubit;
      thanhPhanThamGiaCubit.callApiThanhPhanThamGia();
      _refreshPhanCongThuKy();
      fetchData();
    }
    _handleEventBus();
  }
  void _handleEventBus (){
    eventBus.on<ReloadMeetingDetail>().listen((event) {
      if (event.tabReload.contains(TabWidgetDetailMeet.THANH_PHAN_THAM_GIA)){
        fetchData();
      }
    });
  }
  void _refreshPhanCongThuKy() {
    eventBus.on<RefreshPhanCongThuKi>().listen((event) {
      thanhPhanThamGiaCubit.callApiThanhPhanThamGia(isShowMessage: true);
    });
  }

  void fetchData(){
    thanhPhanThamGiaCubit.idCuocHop = widget.cubit.idCuocHop;
    thanhPhanThamGiaCubit.detailMeetCalenderCubit = widget.cubit;
    thanhPhanThamGiaCubit.callApiThanhPhanThamGia();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    thanhPhanThamGiaCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          if (widget.cubit.isBtnMoiNguoiThamGia())IconWithTiltleWidget(
            icon: ImageAssets.ic_addUser,
            title: S.current.moi_nguoi_tham_gia,
            onPress: () {
              showDiaLogTablet(
                context,
                title: S.current.them_thanh_phan_tham_gia,
                child: ThemThanhPhanThamGiaWidget(
                  cubit: thanhPhanThamGiaCubit,
                ),
                isBottomShow: false,
                funcBtnOk: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          if (widget.cubit.isChuTri() || widget.cubit.isThuKy())Row(
            children: [
              Flexible(
                child: IconWithTiltleWidget(
                  icon: ImageAssets.ic_diemDanh,
                  title: S.current.diem_danh,
                  onPress: () {
                    if (thanhPhanThamGiaCubit.diemDanhIds.isEmpty) {
                      MessageConfig.show(
                        title: S.current.ban_chua_chon_nguoi_diem_danh,
                        messState: MessState.error,
                      );
                      return;
                    }
                    showDiaLog(
                      context,
                      title: S.current.diem_danh,
                      icon: SvgPicture.asset(ImageAssets.icDiemDanh),
                      btnLeftTxt: S.current.khong,
                      btnRightTxt: S.current.dong_y,
                      textContent: S.current.conten_diem_danh,
                      funcBtnRight: () {
                        thanhPhanThamGiaCubit.postDiemDanh();
                      },
                    );
                  },
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 16),
          BaseSearchBar(
            hintText: S.current.tim_kiem_can_bo,
            onChange: (value) {
              thanhPhanThamGiaCubit.search(value);
            },
          ),
          StreamBuilder<List<CanBoModel>>(
            stream: widget.cubit.thanhPhanThamGia.stream,
            builder: (context, snapshot) {
              final _list = snapshot.data ?? [];
              if (_list.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(left: 13.5, top: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder<bool>(
                        stream: widget.cubit.checkBoxCheckAllTPTG.stream,
                        builder: (context, snapshot) {
                          return CustomCheckBox(
                            title: '',
                            isCheck: snapshot.data ?? false,
                            onChange: (value) {
                              widget.cubit.check = !widget.cubit.check;
                              widget.cubit.checkAll();
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      AutoSizeText(
                        S.current.chon_tat_ca,
                        style: textNormalCustom(
                          fontSize: 16,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          spaceH16,
          StreamBuilder<List<CanBoModel>>(
            stream: thanhPhanThamGiaCubit.thanhPhanThamGia,
            builder: (context, snapshot) {
              final _list = snapshot.data ?? [];
              if (_list.isNotEmpty) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return CellThanhPhanThamGia(
                      cubit: thanhPhanThamGiaCubit,
                      infoModel: _list[index],
                      diemDanh:
                          widget.cubit.isChuTri() || widget.cubit.isThuKy(),
                      ontap: () {
                        thanhPhanThamGiaCubit
                            .postHuyDiemDanh(_list[index].id ?? '');
                      },
                    );
                  },
                );
              } else {
                return const SizedBox(
                  height: 200,
                  child: NodataWidget(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
