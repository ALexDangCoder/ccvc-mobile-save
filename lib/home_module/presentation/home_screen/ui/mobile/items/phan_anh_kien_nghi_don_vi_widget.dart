
import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/tinh_hinh_y_kien_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/text/views/loading_only.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';

class PhanAnhKienNghiDonViWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const PhanAnhKienNghiDonViWidget({
    required this.homeItemType,
    Key? key,
  }) : super(key: key);

  @override
  State<PhanAnhKienNghiDonViWidget> createState() =>
      _PhanAnhKienNghiDonViWidgetState();
}

class _PhanAnhKienNghiDonViWidgetState
    extends State<PhanAnhKienNghiDonViWidget> {
  late HomeCubit cubit;
  final TinhHinhXuLyYKienCubit _phanAnhKienNghiCubit = TinhHinhXuLyYKienCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phanAnhKienNghiCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        // _vanBanDonViCubit.getDocument();
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phanAnhKienNghiCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ContainerBackgroundWidget(
        minHeight: 0,
        isShowSubTitle: false,
        title: S.current.phan_anh_kien_nghi_don_vi,
        onTapIcon: () {
          // cubit.showDialog(widget.homeItemType);
        },
        selectKeyDialog: _phanAnhKienNghiCubit,
        child: LoadingOnly(
          stream: _phanAnhKienNghiCubit.stateStream,
          child: StreamBuilder<List<TinhHinhYKienModel>>(
              stream: _phanAnhKienNghiCubit.getTinhHinhXuLy,
              builder: (context, snapshot) {
                final data = snapshot.data ?? <TinhHinhYKienModel>[];
                if (data.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: NodataWidget(),
                  );
                }
                return statusBarWidget(
                  List.generate(
                    data.length,
                    (index) => ChartData(
                      data[index].status,
                      data[index].soLuong.toDouble(),
                      TinhHinhYKienModel.listColor[index],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget statusBarWidget(List<ChartData> listData) {
    final data = listData.map((e) => e.value).toList();
    final total = data.reduce((a, b) => a + b);
    final listDataGirdView = [];
    listDataGirdView.addAll(listData);
    listDataGirdView.insert(0, listDataGirdView.removeAt(1));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: backgroundRowColor,
          height: 40,
          width: double.maxFinite,
          child: Row(
            children: [
              ...List.generate(2, (index) {
                final data = listData[index];
                return data.value == 0
                    ? const SizedBox()
                    : Expanded(
                        flex: data.value.toInt(),
                        child: Container(
                          color: data.color,
                          child: Center(
                            child: Text(
                              data.value.toInt().toString(),
                              style: textNormal(
                                backgroundColorApp,
                                14.0.textScale(),
                              ),
                            ),
                          ),
                        ),
                      );
              }),
              Expanded(
                flex: (total - (listData[0].value + listData[1].value)).toInt(),
                child: const SizedBox(),
              ),
              // Expanded(child: child)
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 40,
          color: backgroundRowColor,
          child: Row(
            children: [
              if (listData[2].value == 0)
                const SizedBox()
              else
                Expanded(
                  flex: listData[2].value.toInt(),
                  child: Container(
                    color: listData[2].color,
                    child: Center(
                      child: Text(
                        listData[2].value.toInt().toString(),
                        style: textNormal(
                          backgroundColorApp,
                          14.0.textScale(),
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: (total - (listData[2].value)).toInt(),
                child: const SizedBox(),
              ),
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 9,
          mainAxisSpacing: 10.0.textScale(space: 4),
          crossAxisSpacing: 10,
          children: List.generate(listDataGirdView.length, (index) {
            final result = listDataGirdView[index];
            // ignore: avoid_unnecessary_containers
            return GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: result.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        '${result.title} (${result.value.toInt()})',
                        style: textNormal(
                          infoColor,
                          14.0.textScale(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
