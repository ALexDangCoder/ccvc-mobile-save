import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/sinh_nhat_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/event_widget.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class SinhNhatWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const SinhNhatWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _EventOfDayWidgetState createState() => _EventOfDayWidgetState();
}

class _EventOfDayWidgetState extends State<SinhNhatWidget> {
  final SinhNhatCubit sinhNhatCubit = SinhNhatCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sinhNhatCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        sinhNhatCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      minHeight: 350,
      title: S.current.birthday,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      padding: EdgeInsets.zero,
      selectKeyDialog: sinhNhatCubit,
      dialogSelect: StreamBuilder(
          stream: sinhNhatCubit.selectKeyDialog,
          builder: (context, snapshot) {
            return DialogSettingWidget(
              type: widget.homeItemType,
              listSelectKey: <DialogData>[
                DialogData(
                  onSelect: (value, startDate, endDate) {
                    sinhNhatCubit.selectDate(
                        selectKey: value,
                        startDate: startDate,
                        endDate: endDate);
                  },
                  initValue: sinhNhatCubit.selectKeyTime,
                  title: S.current.time,
                  startDate: sinhNhatCubit.startDate,
                  endDate: sinhNhatCubit.endDate,
                )
              ],
            );
          }),
      child: LoadingOnly(
        stream: sinhNhatCubit.stateStream,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<List<SinhNhatUserModel>>(
                stream: sinhNhatCubit.getSinhNhat,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? <SinhNhatUserModel>[];
                  if (data.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: NodataWidget(),
                    );
                  }
                  return Column(
                    children: List.generate(
                      data.length,
                      (index) {
                        final result = data[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: EventWidget(
                            onTap: () {},
                            title: result.title(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Text(
                      S.current.tin_buon,
                      style: textNormalCustom(color: specialPriceColor),
                    ),
                    spaceW16,
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (index, context) {
                          return Row(
                            children: [
                              spaceH20,
                              Container(
                                height: 6,
                                width: 6,
                                decoration: const BoxDecoration(
                                  color: titleColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              spaceW8,
                              Text(
                                S.current.tin_buon,
                                style: textNormalCustom(color: titleColor),
                              ),
                              spaceW16,
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
