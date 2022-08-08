import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/bloc/lichh_am_duong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/tablet/widget/gio_hoang_dao_widget_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/tablet/widget/text_lich_am_hom_nay.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/lich/cupertino_rounded_date.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/calendar/table_calendar/table_calendar_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LichAmDuongTablet extends StatefulWidget {
  const LichAmDuongTablet({Key? key}) : super(key: key);

  @override
  _LichAmDuongTabletState createState() => _LichAmDuongTabletState();
}

class _LichAmDuongTabletState extends State<LichAmDuongTablet> {
  late LichAmDuongCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = LichAmDuongCubit();
    cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: BaseAppBar(
        actions: const [],
        title: S.current.lich_am_duong,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: StreamBuilder<LichAmDuong>(
                stream: cubit.lichAmDuongStream,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 400,
                              decoration: BoxDecoration(
                                color: backgroundColorApp,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                  color: borderColor.withOpacity(0.5),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: shadowContainerColor.withOpacity(
                                      0.05,
                                    ),
                                    offset: const Offset(0, 4),
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                      ),
                                      child: StreamBuilder<DateTime>(
                                        stream:
                                            cubit.changeDateTimeSubject.stream,
                                        builder: (context, snapshot) {
                                          return TableCalendarWidget(
                                            onTap: (_) {
                                              CupertinoRoundedDatePickerWidgetDialogAmDuong
                                                  .show(
                                                context,
                                                minimumYear: 1990,
                                                maximumYear: 2060,
                                                initialDate: snapshot.data ??
                                                    DateTime.now(),
                                                onTap: (dateTime) async {
                                                  final nav =
                                                      Navigator.of(context);
                                                  await cubit.getLichAmDuong(
                                                    dateTime.formatApiDDMMYYYY,
                                                  );
                                                  cubit.selectTime = dateTime;
                                                  cubit.changeDateTimeSubject
                                                      .sink
                                                      .add(dateTime);
                                                  cubit.dateTimeSubject.sink
                                                      .add(dateTime);
                                                  nav.pop();
                                                },
                                                textStyle: tokenDetailAmount(
                                                  color: titleCalenderWork,
                                                  fontSize: 12,
                                                ),
                                                cubit: cubit,
                                              );
                                            },
                                            onChange: (
                                              DateTime start,
                                              DateTime end,
                                              selectDay,
                                            ) {
                                              cubit.startDate =
                                                  start.formatApiDDMMYYYY;
                                              cubit.getLichAmDuong(
                                                cubit.startDate,
                                              );
                                              cubit.dateTimeSubject.sink
                                                  .add(start);
                                              cubit.selectTime = selectDay;
                                            },
                                            tablet: true,
                                            isCalendar: false,
                                            isFomatMonth: false,
                                            onChangeRange: (
                                              DateTime? start,
                                              DateTime? end,
                                              DateTime? focusedDay,
                                            ) {},
                                            initDateTime:
                                                snapshot.data ?? DateTime.now(),
                                            selectDay: (DateTime day) =>
                                                cubit.selectDay(day),
                                            cubit: cubit,
                                            isCheckLunar: true,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 28.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 400,
                              decoration: BoxDecoration(
                                color: backgroundColorApp,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                  color: borderColor.withOpacity(0.5),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        shadowContainerColor.withOpacity(0.05),
                                    offset: const Offset(0, 4),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: borderColor.withOpacity(0.5),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppTheme.getInstance()
                                                    .colorField(),
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: borderColor
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              child: TextLichAmHomNay(
                                                color: backgroundColorApp,
                                                fontSize: 16.0,
                                                title:
                                                    '${S.current.am_lich_hom_nay_ngay} ${DateTime.parse(
                                                  snapshot.data?.ngayAmLich
                                                          ?.solarDate ??
                                                      DateTime.now().toString(),
                                                ).toStringWithListFormat}',
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: linkColor
                                                            .withOpacity(0.1),
                                                        border: Border.all(
                                                          width: 0.5,
                                                          color: borderColor
                                                              .withOpacity(0.5),
                                                        )),
                                                    child: TextLichAmHomNay(
                                                      color: titleColor,
                                                      title:
                                                          S.current.duong_lich,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: linkColor
                                                          .withOpacity(0.1),
                                                      border: Border.all(
                                                        width: 0.5,
                                                        color: borderColor
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                    child: TextLichAmHomNay(
                                                      title: S.current.am_lich,
                                                      color: titleColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 0.5,
                                                        color: borderColor
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        TextLichAmHomNay(
                                                          color:
                                                              unselectedLabelColor,
                                                          title: snapshot
                                                                  .data?.thu ??
                                                              '',
                                                        ),
                                                        TextLichAmHomNay(
                                                          color: titleColor,
                                                          fontSize: 70,
                                                          title: DateTime.parse(
                                                            snapshot
                                                                    .data
                                                                    ?.ngayAmLich
                                                                    ?.solarDate ??
                                                                DateTime.now()
                                                                    .toString(),
                                                          ).toStringDay,
                                                        ),
                                                        TextLichAmHomNay(
                                                          color:
                                                              unselectedLabelColor,
                                                          title: DateTime.parse(
                                                            snapshot
                                                                    .data
                                                                    ?.ngayAmLich
                                                                    ?.solarDate ??
                                                                DateTime.now()
                                                                    .toString(),
                                                          ).toStringMonthYear,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 0.5,
                                                        color: borderColor
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        TextLichAmHomNay(
                                                          color:
                                                              unselectedLabelColor,
                                                          title:
                                                              '${S.current.ngay}: ${snapshot.data?.ngayAmLich?.dayName ?? ''}',
                                                        ),
                                                        TextLichAmHomNay(
                                                          color: titleColor,
                                                          fontSize: 70,
                                                          title:
                                                              '${snapshot.data?.ngayAmLich?.day ?? ''}',
                                                        ),
                                                        TextLichAmHomNay(
                                                          color:
                                                              unselectedLabelColor,
                                                          title:
                                                              '${S.current.thang} '
                                                              '${snapshot.data?.ngayAmLich?.month ?? ''}'
                                                              ' ${S.current.nam}'
                                                              ' ${snapshot.data?.ngayAmLich?.year ?? ''}',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 24.0,
                                      ),
                                      Table(
                                        border: TableBorder.all(
                                          color: borderColor.withOpacity(0.5),
                                        ),
                                        children: [
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color: linkColor.withOpacity(0.1),
                                            ),
                                            children: [
                                              TextLichAmHomNay(
                                                color: titleColor,
                                                title: S.current.ngay,
                                              ),
                                              TextLichAmHomNay(
                                                title: S.current.thang,
                                                color: titleColor,
                                              ),
                                              TextLichAmHomNay(
                                                color: titleColor,
                                                title: S.current.nam,
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TextLichAmHomNay(
                                                title: snapshot.data?.ngayAmLich
                                                        ?.dayName ??
                                                    '',
                                              ),
                                              TextLichAmHomNay(
                                                title: snapshot.data?.ngayAmLich
                                                        ?.monthLongName ??
                                                    '',
                                              ),
                                              TextLichAmHomNay(
                                                title: snapshot.data?.ngayAmLich
                                                        ?.yearName ??
                                                    '',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border:
                              Border.all(color: borderColor.withOpacity(0.5)),
                          boxShadow: [
                            BoxShadow(
                              color: shadowContainerColor.withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24, top: 24),
                              child: Text(
                                '${S.current.tong_quan_ngay_am_lich}'
                                ' ${snapshot.data?.ngayAmLich?.day}/'
                                ' ${snapshot.data?.ngayAmLich?.month}/'
                                ' ${snapshot.data?.ngayAmLich?.year}',
                                style: textNormalCustom(
                                  color: titleColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            GioHoangDaoWidgetTablet(
                              listGioHoangDao: snapshot.data?.gioHoangDao ?? [],
                              sao: snapshot.data?.nguHanh?.sao ?? '',
                              truc: snapshot.data?.nguHanh?.truc ?? '',
                              hanh: snapshot.data?.nguHanh?.hanh ?? '',
                              ngayAmLichStr: snapshot.data?.ngayAmLicgStr ?? '',
                              tietKhi: snapshot.data?.tietKhi ?? '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
