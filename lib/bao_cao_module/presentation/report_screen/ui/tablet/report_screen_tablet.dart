import 'package:ccvc_mobile/bao_cao_module/config/base/base_state.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/tablet/widget/report_filter_tablet.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/tablet/widget/report_list_tablet.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_report_share_favorite.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/mobile/base_app_bar_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportScreenTablet extends StatefulWidget {
  final String? title;

  const ReportScreenTablet({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  _ReportScreenTabletState createState() => _ReportScreenTabletState();
}

class _ReportScreenTabletState extends State<ReportScreenTablet> {
  late ReportListCubit cubit;
  late TextEditingController _searchController;

  @override
  void initState() {
    cubit = ReportListCubit();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      title: widget.title,
      retry: () {
        cubit.getAppID();
      },
      error: AppException(
        S.current.error,
        S.current.something_went_wrong,
      ),
      textEmpty: S.current.list_empty,
      stream: cubit.stateStream,
      child: StreamBuilder<bool>(
        stream: cubit.isStatusSearch,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: widgetAppbar(snapshot.data ?? false),
            body: snapshot.data ?? false ? body() : bodySearch(),
          );
        },
      ),
    );
  }

  Widget body() {
    return RefreshIndicator(
      onRefresh: () async {
        await cubit.getListReport();
      },
      child: Column(
        children: [
          reportLine(left: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ReportFilterTablet(
                          cubit: cubit,
                        ),
                      );
                    },
                    child: StreamBuilder<String>(
                      stream: cubit.textFilter,
                      builder: (context, snapshot) {
                        return RichText(
                          text: TextSpan(
                            children: <WidgetSpan>[
                              WidgetSpan(
                                child: Text(
                                  snapshot.data ?? '',
                                  style: textNormalCustom(
                                    fontSize: 14.0,
                                    color: infoColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                  child: SvgPicture.asset(
                                    ImageAssets.icDropDown,
                                    color: AppTheme.getInstance()
                                        .unselectedLabelColor(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: StreamBuilder<bool>(
                    stream: cubit.isListView,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.isListViewInit = true;
                              cubit.isListView.sink.add(cubit.isListViewInit);
                            },
                            child: SvgPicture.asset(
                              ImageAssets.icGridView,
                              color: snapshot.data ?? cubit.isListViewInit
                                  ? AppTheme.getInstance().colorField()
                                  : AppTheme.getInstance()
                                      .unselectedLabelColor(),
                            ),
                          ),
                          spaceW16,
                          GestureDetector(
                            onTap: () {
                              cubit.isListViewInit = false;
                              cubit.isListView.sink.add(cubit.isListViewInit);
                            },
                            child: SvgPicture.asset(
                              ImageAssets.icListHopMobile,
                              color: !(snapshot.data ?? cubit.isListViewInit)
                                  ? AppTheme.getInstance().colorField()
                                  : AppTheme.getInstance()
                                      .unselectedLabelColor(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<bool>(
            stream: cubit.isListView,
            builder: (context, snapshot) {
              final isListView = snapshot.data ?? cubit.isListViewInit;
              return Expanded(
                child: BlocBuilder<ReportListCubit, BaseState>(
                  bloc: cubit,
                  builder: (BuildContext context, Object? state) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (cubit.listReportFavorite?.isNotEmpty ?? false)
                            Column(
                              children: [
                                titleBaoCao(S.current.yeu_thich),
                                spaceH16,
                                ReportListTablet(
                                  scrollPhysics:
                                      const NeverScrollableScrollPhysics(),
                                  isListView: isListView,
                                  listReport: cubit.listReportFavorite,
                                  cubit: cubit,
                                  idFolder: cubit.folderId,
                                ),
                              ],
                            ),
                          if (state is CompletedLoadMore)
                            titleBaoCao(S.current.all),
                          spaceH16,
                          if (state is CompletedLoadMore)
                            ReportListTablet(
                              idFolder: cubit.folderId,
                              listReport: cubit.listReport,
                              isListView: isListView,
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                              cubit: cubit,
                            )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget textBoxFilter({
    required String title,
    required bool isChose,
    required Function(String) function,
  }) {
    return GestureDetector(
      onTap: () => function(title),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color:
              isChose ? AppTheme.getInstance().statusColor() : cellColorborder,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Text(
          title,
          style: textNormalCustom(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: isChose ? null : AppTheme.getInstance().titleColor(),
          ),
        ),
      ),
    );
  }

  Widget bodySearch() {
    return Column(
      children: [
        spaceH16,
        StreamBuilder<String>(
          stream: cubit.textFilterBox,
          builder: (context, snapshot) {
            final text = snapshot.data;
            return Row(
              children: [
                spaceW16,
                textBoxFilter(
                  title: S.current.all,
                  isChose: text == S.current.all,
                  function: (value) {
                    cubit.filterBox(value);
                  },
                ),
                spaceW16,
                textBoxFilter(
                  title: S.current.bac_cao,
                  isChose: text == S.current.bac_cao,
                  function: (value) {
                    cubit.filterBox(value);
                  },
                ),
                spaceW16,
                textBoxFilter(
                  title: S.current.thu_muc,
                  isChose: text == S.current.thu_muc,
                  function: (value) {
                    cubit.filterBox(value);
                  },
                ),
              ],
            );
          },
        ),
        spaceH16,
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.getListReport(
                isSearch: true,
              );
            },
            child: BlocBuilder(
              bloc: cubit,
              builder: (BuildContext context, Object? state) {
                return cubit.listReportSearch != null
                    ? cubit.listReportSearch?.isNotEmpty ?? false
                        ? ReportListTablet(
                            isSearch: true,
                            idFolder: cubit.folderId,
                            listReport: cubit.listReportSearch,
                            isListView: cubit.isListView.value,
                            cubit: cubit,
                          )
                        : noData()
                    : const SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    );
  }

  BaseAppBarMobile widgetAppbar(
    bool isSearch,
  ) {
    return BaseAppBarMobile(
      title: isSearch ? S.current.bac_cao : '',
      leadingIcon: widget.title?.isNotEmpty ?? false
          ? IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: SvgPicture.asset(
                ImageAssets.icBack,
              ),
            )
          : null,
      actions: [
        if (isSearch)
          GestureDetector(
            onTap: () {
              cubit.clickIconSearch();
            },
            child: Container(
              padding: const EdgeInsets.only(
                top: 16,
                right: 16,
                bottom: 16,
              ),
              child: SvgPicture.asset(
                ImageAssets.icSearchPAKN,
                color: AppTheme.getInstance().unselectedLabelColor(),
              ),
            ),
          )
        else
          Container(
            height: 40,
            padding: const EdgeInsets.only(
              top: 2.5,
            ),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: cellColorborder,
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<String>(
              stream: cubit.textSearch,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    cubit.searchReport(value);
                  },
                  decoration: InputDecoration(
                    counterStyle: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    hintStyle: textNormalCustom(
                      color: AppTheme.getInstance().unselectedLabelColor(),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: S.current.nhap_tu_khoa_tim_kiem,
                    prefixIcon: GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        cubit.clearSearch();
                      },
                      child: SizedBox(
                        width: 48,
                        child: SvgPicture.asset(
                          ImageAssets.icBack,
                          color: AppTheme.getInstance().unselectedLabelColor(),
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: 20,
                      minWidth: 20,
                      maxHeight: 48,
                      maxWidth: 48,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minHeight: snapshot.data?.isNotEmpty ?? false ? 16 : 20,
                      minWidth: snapshot.data?.isNotEmpty ?? false ? 16 : 20,
                      maxHeight: 48,
                      maxWidth: 48,
                    ),
                    suffixIcon: SizedBox(
                      width: 48,
                      child: GestureDetector(
                        onTap: () {
                          if (snapshot.data?.isNotEmpty ?? false) {
                            _searchController.text = '';
                            cubit.textSearch.add('');
                            cubit.getListReport(
                              isSearch: true,
                            );
                          }
                        },
                        child: SvgPicture.asset(
                          snapshot.data?.isNotEmpty ?? false
                              ? ImageAssets.icClose
                              : ImageAssets.icSearchPAKN,
                          color: AppTheme.getInstance().unselectedLabelColor(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget titleBaoCao(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
          top: 2,
        ),
        child: Text(
          title,
          style: textNormalCustom(
            fontSize: 14.0,
            color: infoColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

Widget noData() {
  return Center(
    child: Column(
      children: [
        const SizedBox(
          height: 30.0,
        ),
        SvgPicture.asset(
          ImageAssets.icNoDataNhiemVu,
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          S.current.khong_co_du_lieu,
          style: textNormalCustom(
            fontSize: 16.0.textScale(space: 4.0),
            color: grayChart,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    ),
  );
}
