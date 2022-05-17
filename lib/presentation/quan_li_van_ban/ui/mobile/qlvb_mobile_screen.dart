import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_den_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_di_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/menu/van_ban_menu_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/common_infor_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QLVBMobileScreen extends StatefulWidget {
  const QLVBMobileScreen({Key? key}) : super(key: key);

  @override
  _QLVBMobileScreenState createState() => _QLVBMobileScreenState();
}

class _QLVBMobileScreenState extends State<QLVBMobileScreen>
    with TickerProviderStateMixin {
  QLVBCCubit qlvbCubit = QLVBCCubit();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    qlvbCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.thong_tin_van_ban,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ImageAssets.icBack),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.search,
              color: textBodyTime,
            ),
          ),
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: VanBanMenuMobile(
                  cubit: qlvbCubit,
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          ),
        ],
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: qlvbCubit.stateStream,
        child: Column(
          children: [
            FilterDateTimeWidget(
              context: context,
              isMobile: true,
              onChooseDateFilter: (startDate, endDate) {
                qlvbCubit.startDate = startDate.formatApi;
                qlvbCubit.endDate = endDate.formatApi;
                qlvbCubit.dataVBDen(
                  startDate: qlvbCubit.startDate,
                  endDate: qlvbCubit.endDate,
                );
                qlvbCubit.dataVBDi(
                  startDate: qlvbCubit.startDate,
                  endDate: qlvbCubit.endDate,
                );
                qlvbCubit.listDataDanhSachVBDen(
                    endDate: qlvbCubit.endDate, startDate: qlvbCubit.startDate);
                qlvbCubit.listDataDanhSachVBDi(
                    endDate: qlvbCubit.endDate, startDate: qlvbCubit.startDate);
              },
            ),
            spaceH20,
            tabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [documentInPage(), documentOutPage()],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgTag,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: radioFocusColor,
        ),
        labelColor: backgroundColorApp,
        unselectedLabelColor: radioFocusColor,
        tabs: [
          Tab(
            text: S.current.document_incoming,
          ),
          Tab(
            text: S.current.document_out_going,
          ),
        ],
      ),
    );
  }

  Widget documentInPage() {
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
                stream: qlvbCubit.getVbDen,
                builder: (context, snapshot) {
                  final dataVBDen = snapshot.data ?? DocumentDashboardModel();
                  return CommonInformationMobile(
                    qlvbcCubit: qlvbCubit,
                    documentDashboardModel: dataVBDen,
                    isVbDen: true,
                    ontap: (value) {},
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChiTietVanBanDenMobile(
                                        processId: listData[index].iD ?? '',
                                        taskId: listData[index].taskId ?? '',
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 16,
                                    top: (index == 0) ? 16 : 0,
                                  ),
                                  child: ContainerInfoWidget(
                                    title:
                                        listData[index].trichYeu?.parseHtml() ??
                                            '',
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
        ],
      ),
    );
  }

  Widget documentOutPage() {
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
                  final dataVBDi = snapshot.data ?? DocumentDashboardModel();
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: CommonInformationMobile(
                      qlvbcCubit: qlvbCubit,
                      documentDashboardModel: dataVBDi,
                      isVbDen: false,
                      ontap: (value) {},
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
