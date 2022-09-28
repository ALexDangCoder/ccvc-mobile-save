import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/bloc/lichh_am_duong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/gio_hoang_dao_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/lich/date_picker_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/lich_am_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/button_bottom.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/calendar/table_calendar/table_calendar_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';

class LichAmDuongMobile extends StatefulWidget {
  const LichAmDuongMobile({Key? key}) : super(key: key);

  @override
  _LichAmDuongMobileState createState() => _LichAmDuongMobileState();
}

class _LichAmDuongMobileState extends State<LichAmDuongMobile> {
  late LichAmDuongCubit cubit;
  bool isCheckOnTap = true;

  @override
  void initState() {
    super.initState();
    cubit = LichAmDuongCubit();
    cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        isCheckTabBar: true,
        actions: [
          IconButton(
            onPressed: () {
              isCheckOnTap = !isCheckOnTap;
              setState(() {});
            },
            icon: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: SvgPicture.asset(
                ImageAssets.icIconMenuLichAmDuong,
              ),
            ),
          ),
        ],
        title: S.current.lich_am_duong,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            showBottomSheetCustom(
              context,
              title: S.current.today,
              colorTitle: AppTheme.getInstance().colorField(),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: StreamBuilder<DateTime>(
                      stream: cubit.changeDateTimeSubject.stream,
                      builder: (context, snapshot) {
                        return FlutterRoundedCupertinoDatePickerWidgetAmDuong(
                          minimumYear: 1900,
                          maximumYear: 2099,
                          onDateTimeChanged: (value) {
                            //cubit.time = value;
                          },
                          onChangeSolar: (date, flag) {
                            final solar = LunarSolarConverter.lunarToSolar(
                              Lunar(
                                lunarDay: date.day,
                                lunarMonth: date.month,
                                lunarYear: date.year,
                              ),
                            );
                            cubit.time = flag
                                ? DateTime(
                                    solar.solarYear ?? 1900,
                                    solar.solarMonth ?? 1,
                                    solar.solarDay ?? 1,
                                  )
                                : date;
                          },
                          textStyleDate: textNormalCustom(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: color3D5586,
                          ),
                          initialDateTime: snapshot.data ?? DateTime.now(),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 32,
                    ),
                    child: ButtonBottom(
                      onPressed: () async {
                        final nav = Navigator.of(context);
                        await cubit.getLichAmDuong(
                          cubit.time.formatApiDDMMYYYY,
                        );
                        cubit.selectTime = cubit.time;
                        cubit.changeDateTimeSubject.sink.add(cubit.time);
                        nav.pop();
                      },
                      text: S.current.chon_ngay,
                    ),
                  )
                ],
              ),
            );
          },
          child: StreamBuilder<LichAmDuong>(
            stream: cubit.lichAmDuongStream,
            builder: (context, snap) {
              final date = snap.data?.ngayAmLich?.solarDate ?? DateTime.now();
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${S.current.thang} '
                    '${DateTime.parse(date.toString()).formatApiMMYYYY} ',
                    style: textNormalCustom(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: textTitle,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: ProviderWidget<LichAmDuongCubit>(
        cubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: cubit.stateStream,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: StreamBuilder<LichAmDuong>(
                    stream: cubit.lichAmDuongStream,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spaceH140,
                          LichAmWidget(
                            ngayAmLich:
                                snapshot.data?.ngayAmLich ?? NgayAmLich(),
                            thu: snapshot.data?.thu ?? '',
                            ngayAmLichStr: snapshot.data?.ngayAmLicgStr ?? '',
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          GioHoangDaoWidget(
                            listGioHoangDao: snapshot.data?.gioHoangDao ?? [],
                            sao: snapshot.data?.nguHanh?.sao ?? '',
                            truc: snapshot.data?.nguHanh?.truc ?? '',
                            hanh: snapshot.data?.nguHanh?.hanh ?? '',
                          ),
                          Row(
                            children: [
                              Text(
                                '${S.current.tiet_khi}:',
                                style: textNormalCustom(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: AqiColor,
                                ),
                              ),
                              spaceW3,
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: titleLichAm(
                                  '${snapshot.data?.tietKhi}',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: color3D5586,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              StreamBuilder<DateTime>(
                stream: cubit.changeDateTimeSubject.stream,
                builder: (context, snapshot) {
                  return TableCalendarWidget(
                    isFomatMonth: isCheckOnTap,
                    onChange: (DateTime start, DateTime end, selectDay) {
                      cubit.startDate = start.formatApiDDMMYYYY;
                      cubit.getLichAmDuong(cubit.startDate);
                      cubit.selectTime = selectDay;
                    },
                    onChangeRange: (
                      DateTime? start,
                      DateTime? end,
                      DateTime? focusedDay,
                    ) {},
                    initDateTime: snapshot.data ?? DateTime.now(),
                    selectDay: (day) => cubit.selectDay(day),
                    cubit: cubit,
                    isCheckLunar: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
