import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/main_nhiem_vu/main_nhiem_vu_tablet.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/tong_hop_nhiem_vu_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/tong_hop_nhiem_vu_cell.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/nhiem_vu_widget.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class SummaryOfTaskTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const SummaryOfTaskTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<SummaryOfTaskTabletWidget> createState() => _SummaryOfTaskWidgetState();
}

class _SummaryOfTaskWidgetState extends State<SummaryOfTaskTabletWidget> {
  late HomeCubit cubit;
  final TongHopNhiemVuCubit _nhiemVuCubit = TongHopNhiemVuCubit();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nhiemVuCubit.getDataTongHopNhiemVu();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _nhiemVuCubit.getDataTongHopNhiemVu();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.summary_of_tasks,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      isUnit: true,
      selectKeyDialog: _nhiemVuCubit,
      dialogSelect: StreamBuilder(
          stream: _nhiemVuCubit.selectKeyDialog,
          builder: (context, snapshot) {
            return DialogSettingWidget(
              type: widget.homeItemType,
              listSelectKey: [
                DialogData(
                  onSelect: (value, _, __) {
                    _nhiemVuCubit.selectDonVi(
                      selectKey: value,
                    );
                  },
                  title: S.current.nhiem_vu,
                  initValue: _nhiemVuCubit.selectKeyDonVi,
                  key: [
                    SelectKey.CA_NHAN,
                    SelectKey.DON_VI,
                  ],
                ),
              ],
            );
          }),
      padding: EdgeInsets.zero,
      child: LoadingOnly(
        stream: _nhiemVuCubit.stateStream,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 22),
          child: StreamBuilder<DocumentDashboardModel>(
            stream: _nhiemVuCubit.getTonghopNhiemVu,
            builder: (context, snapshot) {
              final data = snapshot.data ?? DocumentDashboardModel();

              return TongHopNhiemVuCell(
                childs: [
                  GestureDetector(
                    onTap: (){
                      _nhiemVuCubit.clickScreen(TongHopNhiemVuType.choPhanXuLy);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => MainNhiemVuTablet(
                            isCaNhanScreen: _nhiemVuCubit.isCaNhan,
                            maTrangThai: _nhiemVuCubit.mangTrangThai,
                          ),
                        ),
                      );
                    },
                    child: NhiemVuWidget(
                      title: S.current.cho_phan_xu_ly,
                      urlIcon: ImageAssets.icNhiemVuDangThucHien,
                      value: data.soLuongChoPhanXuLy.toString(),
                      type: TongHopNhiemVuType.choPhanXuLy,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _nhiemVuCubit.clickScreen(TongHopNhiemVuType.chuaThucHien);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => MainNhiemVuTablet(
                            isCaNhanScreen: _nhiemVuCubit.isCaNhan,
                            maTrangThai: _nhiemVuCubit.mangTrangThai,
                          ),
                        ),
                      );
                    },
                    child: NhiemVuWidget(
                      title: S.current.chua_thuc_hien,
                      urlIcon: ImageAssets.icDangThucHienQuaHan,
                      value: data.soLuongChuaThucHien.toString(),
                      type: TongHopNhiemVuType.chuaThucHien,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _nhiemVuCubit
                          .clickScreen(TongHopNhiemVuType.dangThucHien);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => MainNhiemVuTablet(
                            isCaNhanScreen: _nhiemVuCubit.isCaNhan,
                            maTrangThai: _nhiemVuCubit.mangTrangThai,
                          ),
                        ),
                      );
                    },
                    child: NhiemVuWidget(
                      title: S.current.dang_thuc_hien,
                      urlIcon: ImageAssets.icDangThucHienTrongHan,
                      value: data.soLuongDangThucHien.toString(),
                      type: TongHopNhiemVuType.dangThucHien,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _nhiemVuCubit
                          .clickScreen(TongHopNhiemVuType.hoanThanhNhiemVu);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => MainNhiemVuTablet(
                            isCaNhanScreen: _nhiemVuCubit.isCaNhan,
                            maTrangThai: _nhiemVuCubit.mangTrangThai,
                          ),
                        ),
                      );
                    },
                    child: NhiemVuWidget(
                      title: S.current.hoan_thanh_nhiem_vu,
                      urlIcon: ImageAssets.icHoanThanhNhiemVu,
                      value: data.soLuongHoanThanhNhiemVu.toString(),
                      type: TongHopNhiemVuType.hoanThanhNhiemVu,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
