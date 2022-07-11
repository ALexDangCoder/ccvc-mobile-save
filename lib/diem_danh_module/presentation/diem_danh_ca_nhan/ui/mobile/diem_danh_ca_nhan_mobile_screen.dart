import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/widget/calendar_cham_cong.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/widget/change_date_time_widget.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_diem_danh_ca_nhan.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/menu/diem_danh_menu_mobile.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/widget_item_thong_ke.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiemDanhCaNhanMobileScreen extends StatefulWidget {
  final DiemDanhCubit cubit;

  const DiemDanhCaNhanMobileScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _DiemDanhCaNhanMobileScreenState createState() =>
      _DiemDanhCaNhanMobileScreenState();
}

class _DiemDanhCaNhanMobileScreenState
    extends State<DiemDanhCaNhanMobileScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.diem_danh_ca_nhan,
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
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: widget.cubit.stateStream,
        child: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: Column(
              children: [
                ChangeDateTimeWidget(
                  onChange: (DateTime value) {},
                  cubit: widget.cubit, endYear: 2025,
                ),
                thongKeWiget(),
                const CalendarChamCong(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget thongKeWiget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 26.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorE2E8F0),
          borderRadius: BorderRadius.circular(6.0),
          color: colorFFFFFF,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ExpandOnlyWidget(
          paddingSize: 8,
          isPaddingIcon: true,
          initExpand: true,
          header: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16.0,
              ),
              child: Row(
                children: [
                  Text(
                    S.current.thong_ke,
                    style: textNormalCustom(
                      color: color3D5586,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: StreamBuilder<ThongKeDiemDanhCaNhanModel>(
            stream: widget.cubit.thongKeSubject,
            builder: (context, snapshot) {
              final data = snapshot.data;
              return WidgetItemThongKe(
                thongKeDiemDanhCaNhanModel:
                    data ?? ThongKeDiemDanhCaNhanModel(),
              );
            },
          ),
        ),
      ),
    );
  }
}
