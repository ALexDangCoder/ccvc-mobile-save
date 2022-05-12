import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_den_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_di_mobile.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/mobile/incoming_document_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/mobile/incoming_document_screen_dashboard.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/menu/van_ban_menu_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/common_infor_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QLVBMobileScreen extends StatefulWidget {
  const QLVBMobileScreen({Key? key}) : super(key: key);

  @override
  _QLVBMobileScreenState createState() => _QLVBMobileScreenState();
}

class _QLVBMobileScreenState extends State<QLVBMobileScreen> {
  QLVBCCubit qlvbCubit = QLVBCCubit();

  @override
  void initState() {
    super.initState();
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
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    StreamBuilder<DocumentDashboardModel>(
                      stream: qlvbCubit.getVbDen,
                      builder: (context, snapshot) {
                        final dataVBDen =
                            snapshot.data ?? DocumentDashboardModel();
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: CommonInformationMobile(
                            qlvbcCubit: qlvbCubit,
                            documentDashboardModel: dataVBDen,
                            isVbDen: true,
                            title: S.current.document_incoming,
                            ontap: (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IncomingDocumentScreen(
                                    title: S.current.danh_sach_van_ban_den,
                                    type: TypeScreen.VAN_BAN_DEN,
                                    startDate: qlvbCubit.startDate,
                                    endDate: qlvbCubit.endDate,
                                    isDanhSachDaXuLy: value.isDanhSachDaXuLy(),
                                    maTrangThai: value.daHoanThanh(),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 6,
                      color: homeColor,
                    ),
                    StreamBuilder<DocumentDashboardModel>(
                      stream: qlvbCubit.getVbDi,
                      builder: (context, snapshot) {
                        final dataVBDi =
                            snapshot.data ?? DocumentDashboardModel();
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: CommonInformationMobile(
                            qlvbcCubit: qlvbCubit,
                            documentDashboardModel: dataVBDi,
                            isVbDen: false,
                            title: S.current.document_out_going,
                            ontap: (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      IncomingDocumentScreenDashBoard(
                                    title: S.current.danh_sach_van_ban_di,
                                    startDate: qlvbCubit.startDate,
                                    endDate: qlvbCubit.endDate,
                                    isDanhSachDaXuLy:
                                        value.getTrangThaiDaXuLy(value),
                                    isDanhSachChoTrinhKy:
                                        value.getTrangThaiChoTrinhKy(value),
                                    isDanhSachChoXuLy:
                                        value.getTrangThaiChoXuLy(value),
                                    trangThaiFilter: value.getTrangThaiNumber(),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 6,
                      color: homeColor,
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
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          IncomingDocumentScreen(
                                        title: S.current.danh_sach_van_ban_den,
                                        type: TypeScreen.VAN_BAN_DEN,
                                        startDate: qlvbCubit.startDate,
                                        endDate: qlvbCubit.endDate,
                                        maTrangThai: [],
                                      ),
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  ImageAssets.ic_next_color,
                                  color: AppTheme.getInstance().colorField(),
                                ),
                              )
                            ],
                          ),
                          StreamBuilder<List<VanBanModel>>(
                            stream: qlvbCubit.getDanhSachVbDen,
                            builder: (context, snapshot) {
                              final List<VanBanModel> listData =
                                  snapshot.data ?? [];
                              if (listData.isNotEmpty) {
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      listData.length < 3 ? listData.length : 3,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: IncomingDocumentCell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChiTietVanBanDenMobile(
                                                processId:
                                                    listData[index].iD ?? '',
                                                taskId:
                                                    listData[index].taskId ??
                                                        '',
                                              ),
                                            ),
                                          );
                                        },
                                        title: listData[index].loaiVanBan ?? '',
                                        dateTime: DateTime.parse(
                                          listData[index].ngayDen ?? '',
                                        ).toStringWithListFormat,
                                        userName:
                                            listData[index].nguoiSoanThao ?? '',
                                        status: listData[index].doKhan ?? '',
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 6,
                      color: homeColor,
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
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          IncomingDocumentScreen(
                                        title: S.current.danh_sach_van_ban_di,
                                        type: TypeScreen.VAN_BAN_DI,
                                        startDate: qlvbCubit.startDate,
                                        endDate: qlvbCubit.endDate,
                                        maTrangThai: [],
                                      ),
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  ImageAssets.ic_next_color,
                                  color: AppTheme.getInstance().colorField(),
                                ),
                              )
                            ],
                          ),
                          StreamBuilder<List<VanBanModel>>(
                            stream: qlvbCubit.getDanhSachVbDi,
                            builder: (context, snapshot) {
                              final List<VanBanModel> listData =
                                  snapshot.data ?? [];
                              if (listData.isNotEmpty) {
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      listData.length < 3 ? listData.length : 3,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: IncomingDocumentCell(
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
                                        title: listData[index].loaiVanBan ?? '',
                                        dateTime: DateTime.parse(
                                                listData[index].ngayDen ?? '')
                                            .toStringWithListFormat,
                                        userName:
                                            listData[index].nguoiSoanThao ?? '',
                                        status: listData[index].doKhan ?? '',
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
