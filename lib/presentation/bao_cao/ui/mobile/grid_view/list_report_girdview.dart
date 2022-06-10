import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_cao/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/mobile/grid_view/widget/report_list.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/widget/filter_bao_cao.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/mobile/base_app_bar_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TypeLoai {
  THU_MUC,
  BAO_CAO,
}

class DanhSachBaoCaoDangGirdviewMobile extends StatefulWidget {
  const DanhSachBaoCaoDangGirdviewMobile({Key? key}) : super(key: key);

  @override
  _DanhSachBaoCaoDangGirdviewMobileState createState() =>
      _DanhSachBaoCaoDangGirdviewMobileState();
}

class _DanhSachBaoCaoDangGirdviewMobileState
    extends State<DanhSachBaoCaoDangGirdviewMobile> {
  late DanhSachBaoCaoCubit cubit;

  @override
  void initState() {
    cubit = DanhSachBaoCaoCubit();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarMobile(
        title: S.current.bac_cao,
        actions: [
          GestureDetector(
            onTap: () {
              //todo search anh hải
            },
            child: Container(
              padding: const EdgeInsets.only(top: 16, right: 16, bottom: 16),
              child: SvgPicture.asset(
                ImageAssets.icSearchPAKN,
                color: AppTheme.getInstance().unselectedLabelColor(),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          //TODO
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
                        builder: (context) => FilterBaoCao(
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
                            color:
                                AppTheme.getInstance().unselectedLabelColor(),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 16,
                              ),
                              child: SvgPicture.asset(
                                ImageAssets.icGridView,
                                color: snapshot.data ?? false
                                    ? AppTheme.getInstance().colorField()
                                    : AppTheme.getInstance()
                                        .unselectedLabelColor(),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.isCheckList.sink.add(false);
                            },
                            child: SvgPicture.asset(
                              ImageAssets.icListHopMobile,
                              color: !(snapshot.data ?? false)
                                  ? AppTheme.getInstance().colorField()
                                  : AppTheme.getInstance()
                                      .unselectedLabelColor(),
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
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        titleBaoCao(S.current.yeu_thich),
                        ReportList(
                          listReport: cubit.dumpData,
                          isCheckList: snapshot.data ?? false,
                        ),
                        titleBaoCao(S.current.all),
                        ReportList(
                          listReport: cubit.dumpData,
                          isCheckList: snapshot.data ?? false,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
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