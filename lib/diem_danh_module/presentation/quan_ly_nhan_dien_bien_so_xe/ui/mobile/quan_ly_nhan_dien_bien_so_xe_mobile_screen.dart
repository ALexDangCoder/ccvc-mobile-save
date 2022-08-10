import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_bien_so_xe_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/menu/diem_danh_menu_mobile.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/ui/dang_ky_thong_tin_xe_moi_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/item_loai_xe.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/widget_cap_nhat_thong_tin_dang_ky_xe.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuanLyNhanDienBienSoXeMobileScreen extends StatefulWidget {
  DiemDanhCubit cubit;

  QuanLyNhanDienBienSoXeMobileScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _QuanLyNhanDienBienSoXeMobileScreenState createState() =>
      _QuanLyNhanDienBienSoXeMobileScreenState();
}

class _QuanLyNhanDienBienSoXeMobileScreenState
    extends State<QuanLyNhanDienBienSoXeMobileScreen> {
  @override
  void initState() {
    widget.cubit.getDanhSachBienSoXe();
    _handleEventBus();
    super.initState();
  }

  void _handleEventBus() {
    eventBus.on<ApiSuccessAttendance>().listen((event) {
      widget.cubit.getDanhSachBienSoXe();
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
      stream: widget.cubit.stateStream,
      child: ProviderWidget<DiemDanhCubit>(
        cubit: widget.cubit,
        child: StreamBuilder<List<ChiTietBienSoXeModel>>(
            key: UniqueKey(),
            stream: widget.cubit.danhSachBienSoXeSubject.stream,
            builder: (context, snapshotChiTiet) {
              final dataChiTiet = snapshotChiTiet.data ?? [];
              return StreamBuilder<bool>(
                stream: widget.cubit.nhanDienbienSoxeSubject,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  return snapshotChiTiet.data != null
                      ? data == true
                          ? Scaffold(
                              appBar: BaseAppBar(
                                title: S.current.quan_ly_nhan_dien_bien_so_xe,
                                leadingIcon: IconButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  icon: SvgPicture.asset(
                                    ImageAssets.icBack,
                                  ),
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      DrawerSlide.navigatorSlide(
                                        context: context,
                                        screen: DiemDanhMenuMobile(
                                          cubit: widget.cubit,
                                        ),
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                      ImageAssets.icMenuCalender,
                                    ),
                                  )
                                ],
                              ),
                              body: RefreshIndicator(
                                onRefresh: () async {
                                  await widget.cubit.getDanhSachBienSoXe();
                                },
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12.0,
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: dataChiTiet.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: colorE2E8F0),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.05),
                                                    blurRadius: 2,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${widget.cubit.getUrlImageBienSoXe(dataChiTiet[index].fileId)}'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            spaceH12,
                                            Text(
                                              S.current.giay_dang_ky_xe,
                                              style: textNormalCustom(
                                                color: color3D5586,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            spaceH20,
                                            ItemLoaiXe(
                                              titleXeMay: dataChiTiet[index]
                                                      .loaiXeMay
                                                      ?.loaiXe() ??
                                                  '',
                                              titleBienKiemSoat:
                                                  dataChiTiet[index]
                                                          .bienKiemSoat ??
                                                      '',
                                              titleLoaiSoHuu: dataChiTiet[index]
                                                      .loaiSoHuu
                                                      ?.loaiSoHuu() ??
                                                  '',
                                            ),
                                            spaceH24,
                                            DoubleButtonBottom(
                                              title1: S.current.chinh_sua,
                                              title2: S.current.xoa,
                                              onClickLeft: () {
                                                showBottomSheetCustom(
                                                  context,
                                                  title: S.current
                                                      .cap_nhat_tong_tin_dang_ky_xe,
                                                  child: Container(
                                                    padding: EdgeInsets.zero,
                                                    child:
                                                        WidgetCapNhatThongTinDangKyXe(
                                                      context: context,
                                                      cubit: widget.cubit,
                                                      chiTietBienSoXeModel:
                                                          dataChiTiet[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              onClickRight: () {
                                                showDiaLog(
                                                  context,
                                                  title: S.current
                                                      .xoa_nhan_bien_so_xe,
                                                  icon: SvgPicture.asset(
                                                    ImageAssets
                                                        .icXoaNhanhDienBienSoXe,
                                                  ),
                                                  btnLeftTxt: S.current.khong,
                                                  btnRightTxt: S.current.dong_y,
                                                  funcBtnRight: () async {
                                                    await widget.cubit
                                                        .xoaBienSoXe(
                                                      dataChiTiet[index].id ??
                                                          '',
                                                    )
                                                        .then((value) {
                                                      widget.cubit
                                                          .getDanhSachBienSoXe();
                                                    });
                                                  },
                                                  showTablet: false,
                                                  textContent: S.current
                                                      .ban_co_muon_xoa_nhan_dien_bien_so_xe,
                                                );
                                              },
                                            ),
                                            spaceH24,
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              floatingActionButton: FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DangKyThongTinXeMoi(
                                        cubit: widget.cubit,
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor:
                                    AppTheme.getInstance().colorField(),
                                child: SvgPicture.asset(
                                    ImageAssets.icVectorFloatAction),
                              ),
                            )
                          : Scaffold(
                              appBar: BaseAppBar(
                                title: S.current.dang_ky_xe_ra_vao_bo,
                                leadingIcon: IconButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  icon: SvgPicture.asset(
                                    ImageAssets.icBack,
                                  ),
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      DrawerSlide.navigatorSlide(
                                        context: context,
                                        screen: DiemDanhMenuMobile(
                                          cubit: widget.cubit,
                                        ),
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                      ImageAssets.icMenuCalender,
                                    ),
                                  )
                                ],
                              ),
                              body: Center(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      ImageAssets.imgDangKyXeSvg,
                                    ),
                                    SizedBox(
                                      width: 163,
                                      child: ButtonCustomBottom(
                                        title: S.current.dang_ky_xe_moi,
                                        isColorBlue: true,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DangKyThongTinXeMoi(
                                                cubit: widget.cubit,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                      : const Scaffold();
                },
              );
            }),
      ),
    );
  }
}
