import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/tablet/tab_cung_he_thong_tablet.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/tablet/tab_ngoai_he_thong_tablet.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChiaSeBaoCaoTablet extends StatefulWidget {
  const ChiaSeBaoCaoTablet({
    Key? key,
    required this.idReport,
    required this.appId,
  }) : super(key: key);

  final String idReport;
  final String appId;

  @override
  _ChiaSeBaoCaoTabletState createState() => _ChiaSeBaoCaoTabletState();
}

class _ChiaSeBaoCaoTabletState extends State<ChiaSeBaoCaoTablet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ChiaSeBaoCaoCubit cubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    cubit = ChiaSeBaoCaoCubit();
    cubit.idReport = widget.idReport;
    cubit.appId = widget.appId;
    cubit.getGroup();
    cubit.getTree();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 1366),
      builder: () {
        return Container(
          clipBehavior: Clip.hardEdge,
          height: 750.h,
          width: 592.w,
          //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: StateStreamLayout(
            stream: cubit.stateStream,
            textEmpty: '',
            retry: () {
              cubit.getGroup();
              cubit.getTree();
            },
            error: AppException(S.current.something_went_wrong, ''),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH24,
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                  ),
                  child: Text(
                    S.current.chia_se,
                    style: textNormalCustom(
                      color: color3D5586,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                spaceH20,
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.all(color: containerColorTab),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Text(
                            widget.idReport,
                            style: textNormalCustom(
                              color: labelColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: widget.idReport,
                                ),
                              ).then((value) {
                                MessageConfig.show(
                                  title: S.current.copy_success,
                                );
                              });
                            },
                            child: SvgPicture.asset(
                              ImageAssets.ic_copy,
                              color: colorA2AEBD,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spaceH20,
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: containerColorTab,
                      ),
                    ),
                  ),
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: S.current.chia_se_cung_he_thong,
                      ),
                      Tab(
                        text: S.current.chia_se_ngoai_he_thong,
                      ),
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    //isScrollable: true,
                    labelColor: textDefault,
                    unselectedLabelColor: infoColor,
                    indicatorColor: textDefault,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TabCungHeThongTablet(
                        cubit: cubit,
                      ),
                      TabNgoaiHeThongTablet(
                        cubit: cubit,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
