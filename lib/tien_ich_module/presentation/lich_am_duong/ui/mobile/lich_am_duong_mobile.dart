import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/bloc/lichh_am_duong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/gio_hoang_dao_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/lich_am_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/calendar/table_calendar/table_calendar_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/show_buttom_sheet/show_bottom_date_picker.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LichAmDuongMobile extends StatefulWidget {
  const LichAmDuongMobile({Key? key}) : super(key: key);

  @override
  _LichAmDuongMobileState createState() => _LichAmDuongMobileState();
}

class _LichAmDuongMobileState extends State<LichAmDuongMobile> {
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
      appBar: BaseAppBar(
        actions: [
          IconButton(
            onPressed: () {
              CupertinoRoundedDatePickerWidget.show(
                context,
                minimumYear: 1990,
                maximumYear: 2060,
                initialDate: DateTime.now(),
                onTap: (dateTime) async {
                  await cubit.getLichAmDuong(dateTime.formatApiDDMMYYYY);
                  cubit.selectTime = dateTime;
                  cubit.changeDateTimeSubject.add(dateTime);
                  Navigator.pop(context);
                },
              );
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
                          const SizedBox(
                            height: 100,
                          ),
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
                    onChange: (DateTime start, DateTime end, selectDay) {
                      cubit.startDate = start.formatApiDDMMYYYY;
                      cubit.getLichAmDuong(cubit.startDate);
                      cubit.selectTime = selectDay;
                    },
                    onChangeRange: (DateTime? start, DateTime? end,
                        DateTime? focusedDay) {},
                    selectDay: (day) => cubit.selectDay(day),
                    cubit: cubit,
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
