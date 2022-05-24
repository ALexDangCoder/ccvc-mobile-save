import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_di_mobile.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/common_infor_mobile.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget_tablet.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class QLVBScreenTablet extends StatefulWidget {
  const QLVBScreenTablet({Key? key}) : super(key: key);

  @override
  _QLVBScreenTabletState createState() => _QLVBScreenTabletState();
}

class _QLVBScreenTabletState extends State<QLVBScreenTablet>
    with SingleTickerProviderStateMixin {
  QLVBCCubit qlvbCubit = QLVBCCubit();
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();
  late TabController controller;
  late ScrollController scrollController;
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    qlvbCubit.initTimeRange();
    super.initState();
    qlvbCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.thong_tin_chung,
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('1', ''),
        stream: qlvbCubit.stateStream,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              FilterDateTimeWidgetTablet(
              initStartDate: DateTime.parse(qlvbCubit.startDate),
                context: context,
                onChooseDateFilter: (startDate, endDate) {
                  qlvbCubit.startDate = startDate.formatApi;
                  qlvbCubit.endDate = endDate.formatApi;
                  qlvbCubit.dataVBDen();
                  qlvbCubit.dataVBDi();
                  qlvbCubit.listDataDanhSachVBDen();
                  qlvbCubit.listDataDanhSachVBDi();
                },
                controller: textcontroller,
                onChange: (text) {
                  qlvbCubit.debouncer.run(() {
                    setState(() {});
                    qlvbCubit.keySearch = text;
                    qlvbCubit.listDataDanhSachVBDen();
                    qlvbCubit.listDataDanhSachVBDi();
                  });
                },
              ),
              Container(
                color: bgQLVBTablet,
                height: 50,
                child: TabBar(
                  unselectedLabelStyle: titleAppbar(fontSize: 16),
                  unselectedLabelColor: AqiColor,
                  labelColor: AppTheme.getInstance().colorField(),
                  labelStyle: titleText(fontSize: 16),
                  indicatorColor: AppTheme.getInstance().colorField(),
                  tabs: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(S.current.danh_sach_van_ban_den),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(S.current.danh_sach_van_ban_di),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    documentIn(),
                    documentOut(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget documentIn() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: ExpandOnlyWidget(
                initExpand: true,
                header: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  child: Text(
                    S.current.word_processing_state,
                    style: textNormalCustom(
                      color: textTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                child: StreamBuilder<DocumentDashboardModel>(
                  stream: qlvbCubit.getVbDen,
                  builder: (context, snapshot) {
                    final dataVBDen = snapshot.data ?? DocumentDashboardModel();
                    return CommonInformationMobile(
                      chartData: qlvbCubit.chartDataVbDen,
                      documentDashboardModel: dataVBDen,
                      onPieTap: (value) {
                        qlvbCubit.documentInStatusCode = value;
                        qlvbCubit.listDataDanhSachVBDen();
                      },
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.danh_sach_van_ban_den,
                  style: textNormalCustom(
                    fontSize: 16,
                    color: textDropDownColor,
                  ),
                ),
              ],
            ),
            StreamBuilder<List<VanBanModel>>(
              stream: qlvbCubit.getDanhSachVbDen,
              builder: (context, snapshot) {
                final List<VanBanModel> listData = snapshot.data ?? [];
                return listData.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         ChiTietVanBanDenMobile(
                              //           processId: listData[index].iD ?? '',
                              //           taskId: listData[index].taskId ?? '',
                              //         ),
                              //   ),
                              // );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: 16,
                                top: (index == 0) ? 16 : 0,
                              ),
                              child: ContainerInfoWidget(
                                title:
                                    listData[index].trichYeu?.parseHtml() ?? '',
                                listData: [
                                  InfoData(
                                    key: S.current.so_ky_hieu,
                                    value: listData[index].number ?? '',
                                    urlIcon: ImageAssets.icInfo,
                                  ),
                                  InfoData(
                                    key: S.current.noi_gui,
                                    value: listData[index].sender ?? '',
                                    urlIcon: ImageAssets.icLocation,
                                  ),
                                ],
                                status: getNameFromStatus(
                                    listData[index].statusCode ?? -1),
                                colorStatus: getColorFromStatus(
                                    listData[index].statusCode ?? -1),
                              ),
                            ),
                          );
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.all(16),
                        child: NodataWidget(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget documentOut() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpandOnlyWidget(
              initExpand: true,
              header: Container(
                alignment: Alignment.centerLeft,
                color: Colors.transparent,
                child: Text(
                  S.current.word_processing_state,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              child: StreamBuilder<DocumentDashboardModel>(
                stream: qlvbCubit.getVbDi,
                builder: (context, snapshot) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: CommonInformationMobile(
                      chartData: qlvbCubit.chartDataVbDi,
                      onPieTap: (value) {},
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.danh_sach_van_ban_di,
                      style: textNormalCustom(
                        fontSize: 16,
                        color: textDropDownColor,
                      ),
                    ),
                  ],
                ),
                StreamBuilder<List<VanBanModel>>(
                  stream: qlvbCubit.getDanhSachVbDi,
                  builder: (context, snapshot) {
                    final List<VanBanModel> listData = snapshot.data ?? [];
                    return listData.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: 16,
                                  top: (index == 0) ? 16 : 0,
                                ),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChiTietVanBanDiMobile(
                                          id: listData[index].iD ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  child: ContainerInfoWidget(
                                    title:
                                        listData[index].trichYeu?.parseHtml() ??
                                            '',
                                    listData: [
                                      InfoData(
                                        key: S.current.dv_soan_thao,
                                        value:
                                            listData[index].donViSoanThao ?? '',
                                        urlIcon: ImageAssets.icLocation,
                                      ),
                                      InfoData(
                                        key: S.current.nguoi_soan_thao,
                                        value:
                                            listData[index].nguoiSoanThao ?? '',
                                        urlIcon: ImageAssets.imgAcount,
                                      ),
                                    ],
                                    status: listData[index].doKhan ?? '',
                                    colorStatus: getColorFromPriorityCode(
                                      listData[index].priorityCode ?? '',
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.all(16), child: NodataWidget());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
