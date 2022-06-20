import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_gridview.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_list.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/report_list.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/report_filter.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/mobile/base_app_bar_mobile.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportScreenMobile extends StatefulWidget {
  const ReportScreenMobile({Key? key}) : super(key: key);

  @override
  _ReportScreenMobileState createState() => _ReportScreenMobileState();
}

class _ReportScreenMobileState extends State<ReportScreenMobile> {
  late ReportListCubit cubit;
  late TextEditingController _searchController;

  @override
  void initState() {
    cubit = ReportListCubit();
    _searchController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: cubit.isStatusSearch,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: widgetAppbar(snapshot.data ?? false),
          body: snapshot.data ?? false ? body() : bodySearch(),
        );
      },
    );
  }

  Widget body() {
    return RefreshIndicator(
      onRefresh: () async {
        await cubit.getListReport();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ReportFilter(
                        cubit: cubit,
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      StreamBuilder<String>(
                        stream: cubit.textFilter,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data ?? '',
                            style: textNormalCustom(
                              fontSize: 14.0,
                              color: infoColor,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: SvgPicture.asset(
                          ImageAssets.icDropDown,
                          color: AppTheme.getInstance().unselectedLabelColor(),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<bool>(
                  stream: cubit.isCheckList,
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.isCheckList.sink.add(true);
                          },
                          child: SvgPicture.asset(
                            ImageAssets.icGridView,
                            color: snapshot.data ?? false
                                ? AppTheme.getInstance().colorField()
                                : AppTheme.getInstance().unselectedLabelColor(),
                          ),
                        ),
                        spaceW16,
                        GestureDetector(
                          onTap: () {
                            cubit.isCheckList.sink.add(false);
                          },
                          child: SvgPicture.asset(
                            ImageAssets.icListHopMobile,
                            color: !(snapshot.data ?? false)
                                ? AppTheme.getInstance().colorField()
                                : AppTheme.getInstance().unselectedLabelColor(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          StreamBuilder<bool>(
            stream: cubit.isCheckList,
            builder: (context, snapshot) {
              return Expanded(
                child: ComplexLoadMore(
                  isCallApiInit: false,
                  mainAxisExtent: 130,
                  titleNoData: S.current.khong_co_bao_cao,
                  isTitle: false,
                  shrinkWap: true,
                  checkRatio: 1.5,
                  crossAxisSpacing: 17,
                  childrenView: [
                    Column(
                      children: [
                        StreamBuilder<List<ReportItem>>(
                          stream: cubit.listReportFavorite,
                          builder: (context, snapshot) {
                            final listFavorite = snapshot.data ?? [];
                            return (cubit.listReportFavorite.value.isNotEmpty)
                                ? Column(
                                    children: [
                                      titleBaoCao(S.current.yeu_thich),
                                      ReportList(
                                        scrollPhysics:
                                            const NeverScrollableScrollPhysics(),
                                        isCheckList: cubit.isCheckList.value,
                                        listReport: listFavorite,
                                        cubit: cubit,
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                    titleBaoCao(S.current.all),
                  ],
                  callApi: (page) {
                    cubit.getListReport();
                  },
                  isListView: !(snapshot.data ?? false),
                  cubit: cubit,
                  viewItem: (value, index) {
                    try {
                      return !(snapshot.data ?? false)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: ItemList(
                                item: value,
                                cubit: cubit,
                              ),
                            )
                          : ItemGridView(
                              item: value,
                              cubit: cubit,
                            );
                    } catch (e) {
                      return const SizedBox();
                    }
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
          child: ListViewLoadMore(
            isLoadMoreBottom: false,
            cubit: cubit,
            isListView: !cubit.isCheckList.value,
            checkRatio: 1.5,
            crossAxisSpacing: 17,
            sinkWap: true,
            callApi: (page) => {cubit.getListReport()},
            viewItem: (value, index) => !cubit.isCheckList.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: ItemList(
                      item: value,
                      cubit: cubit,
                    ),
                  )
                : ItemGridView(
                    cubit: cubit,
                    item: value,
                  ),
          ),
        ),
      ],
    );
  }

  BaseAppBarMobile widgetAppbar(bool isSearch) {
    return BaseAppBarMobile(
      title: isSearch ? S.current.bac_cao : '',
      actions: [
        if (isSearch)
          GestureDetector(
            onTap: () {
              cubit.isStatusSearch.add(false);
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
                      cubit.textSearch.add(value.trim());
                      cubit.getListReport();
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
                            color:
                                AppTheme.getInstance().unselectedLabelColor(),
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
                              cubit.getListReport();
                            }
                          },
                          child: SvgPicture.asset(
                            snapshot.data?.isNotEmpty ?? false
                                ? ImageAssets.icSearchPAKN
                                : ImageAssets.icSearchPAKN,
                            color:
                                AppTheme.getInstance().unselectedLabelColor(),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
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
          bottom: 12,
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
