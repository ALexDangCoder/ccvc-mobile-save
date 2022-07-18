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
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
  late CalendarController _controller;
  late DateTime _tmpMonth;
  final _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _tmpMonth = DateTime(_now.year, _now.month);
    _controller.addPropertyChangedListener((properties) {
      if (properties == DISPLAY_DATE) {
        final DateTime currentMonth = DateTime(
          _controller.displayDate?.year ?? _now.year,
          _controller.displayDate?.month ?? _now.month,
        );
        _tmpMonth = currentMonth;
        widget.cubit.getDataDayWage(dateTime: currentMonth);
        widget.cubit.currentMonthSink.add(currentMonth);
      }
    });
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
        retry: () {
          widget.cubit.getDataDayWage(dateTime: _tmpMonth);
        },
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: widget.cubit.stateStream,
        child: RefreshIndicator(
          onRefresh: () async {
            await widget.cubit.getDataDayWage(dateTime: _tmpMonth);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<DateTime>(
                  stream: widget.cubit.currentMonthStream,
                  builder: (context, snapshot) {
                    final currentMonth = snapshot.data;
                    return ChangeDateTimeWidget(
                      onChange: (DateTime value) {
                        widget.cubit.getDataDayWage(dateTime: value);
                        widget.cubit.currentMonthSink.add(value);
                        _controller.displayDate =
                            DateTime(value.year, value.month);
                        _tmpMonth = value;
                      },
                      currentMonth: currentMonth,
                      cubit: widget.cubit,
                      endYear: widget.cubit.endYear,
                      startYear: widget.cubit.startYear,
                    );
                  },
                ),
                thongKeWiget(),
                spaceH16,
                CalendarChamCong(
                  cubit: widget.cubit,
                  controller: _controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget thongKeWiget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
