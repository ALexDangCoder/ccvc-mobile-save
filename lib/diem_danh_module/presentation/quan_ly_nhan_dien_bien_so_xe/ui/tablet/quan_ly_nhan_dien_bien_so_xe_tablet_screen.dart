import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/menu/diem_danh_menu_tablet.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/ui/mobile/dang_ky_thong_tin_xe_moi_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/item_loai_xe.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/widget_cap_nhat_thong_tin_dang_ky_xe.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuanLyNhanDienBienSoXeTabletScreen extends StatefulWidget {
  DiemDanhCubit cubit;

  QuanLyNhanDienBienSoXeTabletScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _QuanLyNhanDienBienSoXeTabletScreenState createState() =>
      _QuanLyNhanDienBienSoXeTabletScreenState();
}

class _QuanLyNhanDienBienSoXeTabletScreenState
    extends State<QuanLyNhanDienBienSoXeTabletScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.cubit.nhanDienbienSoxeSubject,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == true) {
          return Scaffold(
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
                      screen: DiemDanhMenuTablet(
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
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: colorE2E8F0),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 2,
                            spreadRadius: 2,
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.imgBienSoXe),
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
                      titleXeMay: widget.cubit.xeMay??'',
                      titleBienKiemSoat: widget.cubit.bienKiemSoat??'',
                      titleLoaiSoHuu: widget.cubit.loaiSoHuu??'',
                    ),
                    spaceH24,
                    DoubleButtonBottom(
                      title1: S.current.chinh_sua,
                      title2: S.current.xoa,
                      onPressed1: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.cap_nhat_tong_tin_dang_ky_xe,
                          child: Container(
                            padding: EdgeInsets.zero,
                            child: WidgetCapNhatThingTinDangKyXe(
                              cubit: widget.cubit,
                            ),
                          ),
                        );
                      },
                      onPressed2: () {
                        showDiaLog(
                          context,
                          title: S.current.xoa_nhan_bien_so_xe,
                          icon: SvgPicture.asset(
                            ImageAssets.icXoaNhanhDienBienSoXe,
                          ),
                          btnLeftTxt: S.current.khong,
                          btnRightTxt: S.current.dong_y,
                          funcBtnRight: () {},
                          showTablet: false,
                          textContent:
                              S.current.ban_co_muon_xoa_nhan_dien_bien_so_xe,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppTheme.getInstance().colorField(),
              child: SvgPicture.asset(ImageAssets.icVectorFloatAction),
            ),
          );
        } else {
          return Scaffold(
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
                      screen: DiemDanhMenuTablet(
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
            body: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 590.0,
                  child: Column(
                    children: [
                      spaceH60,
                      SvgPicture.asset(
                        ImageAssets.imgDangKyXeSvg,
                      ),
                      spaceH48,
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
                                       DangKyThongTinXeMoi(cubit: widget.cubit),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
