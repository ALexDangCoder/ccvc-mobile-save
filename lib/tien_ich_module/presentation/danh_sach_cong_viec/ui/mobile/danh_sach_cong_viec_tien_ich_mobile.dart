import 'package:ccvc_mobile/bao_cao_module/widget/dialog/loading_loadmore.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/app_bar_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/list_widget_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DanhSachCongViecTienIchMobile extends StatefulWidget {
  const DanhSachCongViecTienIchMobile({Key? key}) : super(key: key);

  @override
  _DanhSachCongViecTienIchMobileState createState() =>
      _DanhSachCongViecTienIchMobileState();
}

class _DanhSachCongViecTienIchMobileState
    extends State<DanhSachCongViecTienIchMobile> {
  DanhSachCongViecTienIchCubit cubit = DanhSachCongViecTienIchCubit();
  String textSearch = '';
  int pageSize = 10;
  bool isInRefresh = false;
  BehaviorSubject<bool> inLoadmore = BehaviorSubject.seeded(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.initialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDSCV(cubit: cubit, context: context),
      floatingActionButton: buttonThemCongViec(cubit: cubit, context: context),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: cubit.stateStream,
        child: ProviderWidget<DanhSachCongViecTienIchCubit>(
          cubit: cubit,

          /// to load more
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              inLoadmore.sink.add(true);
              if (!isInRefresh &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                cubit.waitToDelay(
                  actionNeedDelay: () {
                    cubit.callAPITheoFilter(
                      isLoadmore: true,
                      textSearch: textSearch,
                      pageIndex: ++cubit.countLoadMore,
                    );
                  },
                  timeSecond: 1,
                );
              }
              inLoadmore.sink.add(false);
              return true;
            },

            /// to refersh
            child: RefreshIndicator(
              onRefresh: () async {
                isInRefresh = true;
                inLoadmore.sink.add(false);
                await cubit.waitToDelay(
                  actionNeedDelay: () {
                    cubit.callAPITheoFilter(
                      textSearch: textSearch,
                      pageIndex: 1,
                      pageSize: 10,
                    );
                    isInRefresh = false;
                  },
                  timeSecond: 1,
                );
                cubit.countLoadMore = 1;
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const AlwaysScrollableScrollPhysics(),
                child: StreamBuilder<String>(
                  stream: cubit.statusDSCV.stream,
                  builder: (context, snapshotType) {
                    final dataType = snapshotType.data ?? '';
                    return Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            searchWidgetDscv(
                              cubit: cubit,
                              textSearch: (value) {
                                textSearch = value;
                              },
                            ),

                            /// list up
                            if (dataType == DSCVScreen.CVCB ||
                                dataType == DSCVScreen.CVQT ||
                                dataType == DSCVScreen.DG ||
                                dataType == DSCVScreen.NCVM ||
                                dataType == DSCVScreen.DBX)
                              StreamBuilder<List<TodoDSCVModel>>(
                                stream: cubit.listDSCVStream.stream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data
                                          ?.where(
                                            (element) =>
                                                dataType != DSCVScreen.DBX
                                                    ? element.isTicked == false
                                                    : element.inUsed == false,
                                          )
                                          .toList() ??
                                      [];
                                  if (data.isNotEmpty) {
                                    return Column(
                                      children: [
                                        if (dataType == DSCVScreen.CVCB ||
                                            dataType == DSCVScreen.DBX ||
                                            dataType == DSCVScreen.NCVM)
                                          textTitle(
                                            S.current.gan_cho_toi,
                                            data.length,
                                          ),
                                        ListUpDSCV(
                                          data: data,
                                          cubit: cubit,
                                          dataType: dataType,
                                        ),
                                      ],
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 30,
                                    ),
                                    child: Column(
                                      children: [
                                        if (dataType == DSCVScreen.CVCB ||
                                            dataType == DSCVScreen.DBX ||
                                            dataType == DSCVScreen.NCVM)
                                          textTitle(
                                            S.current.gan_cho_toi,
                                            data.length,
                                          ),
                                        const NodataWidget(),
                                      ],
                                    ),
                                  );
                                },
                              ),

                            /// list down
                            if (dataType == DSCVScreen.CVCB ||
                                dataType == DSCVScreen.DHT ||
                                dataType == DSCVScreen.DBX ||
                                dataType == DSCVScreen.NCVM)
                              StreamBuilder<List<TodoDSCVModel>>(
                                stream: cubit.listDSCVStream.stream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data
                                          ?.where(
                                            (element) =>
                                                element.isTicked == true,
                                          )
                                          .toList() ??
                                      [];
                                  if (data.isNotEmpty) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (dataType == DSCVScreen.CVCB ||
                                            dataType == DSCVScreen.DBX ||
                                            dataType == DSCVScreen.NCVM)
                                          textTitle(
                                            S.current.da_hoan_thanh,
                                            data.length,
                                          ),
                                        ListDownDSCV(
                                          data: data,
                                          dataType: dataType,
                                          cubit: cubit,
                                        ),
                                      ],
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: Column(
                                      children: [
                                        if (dataType == DSCVScreen.CVCB ||
                                            dataType == DSCVScreen.DBX ||
                                            dataType == DSCVScreen.NCVM)
                                          textTitle(
                                            S.current.da_hoan_thanh,
                                            data.length,
                                          ),
                                        const NodataWidget(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                        Positioned(
                          bottom: 20,
                          child: StreamBuilder<bool>(
                            stream: inLoadmore,
                            builder: (context, snapshot) {
                              if (snapshot.data ?? false) {
                                return LoadingItem();
                              }
                              return const SizedBox();
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textTitle(String text, int count) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Text(
              text,
              style: textNormalCustom(
                fontSize: 14,
                color: infoColor,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppTheme.getInstance().colorField(),
              ),
              alignment: Alignment.center,
              child: Text(
                count.toString(),
                style: textNormalCustom(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0.textScale(),
                ),
              ),
            ),
          ],
        ),
      );
}
