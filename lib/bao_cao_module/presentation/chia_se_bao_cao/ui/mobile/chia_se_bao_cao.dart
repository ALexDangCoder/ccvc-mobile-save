import 'dart:ui';
import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/tab_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/tab_ngoai_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChiaSeBaoCaoMobile extends StatefulWidget {
  const ChiaSeBaoCaoMobile({
    Key? key,
    required this.idReport,
    required this.appId,
    required this.type,
  }) : super(key: key);
  final String idReport;
  final String appId;
  final int type;

  @override
  _ChiaSeBaoCaoMobileState createState() => _ChiaSeBaoCaoMobileState();
}

class _ChiaSeBaoCaoMobileState extends State<ChiaSeBaoCaoMobile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ChiaSeBaoCaoCubit cubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    cubit = ChiaSeBaoCaoCubit();
    cubit.sourceType = widget.type;
    cubit.idReport = widget.idReport;
    cubit.appId = widget.appId;
    cubit.getGroup();
    cubit.loadTreeDonVi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 750.h,
      width: MediaQuery
          .of(context)
          .size
          .width,
      //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: StateStreamLayout(
        stream: cubit.stateStream,
        textEmpty: '',
        retry: () {
          cubit.getGroup();
          cubit.loadTreeDonVi();
        },
        error: AppException(S.current.error, S.current.something_went_wrong),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH20,
            Center(
              child: Container(
                height: 6.h,
                width: 48.w,
                decoration: BoxDecoration(
                  color: colorECEEF7,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
              ),
            ),
            spaceH20,
            spaceH2,
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Text(
                S.current.chia_se,
                style: textNormalCustom(
                  color: color3D5586,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            spaceH32,
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 6.h,
                  left: 16.w,
                  right: 10.w,
                  bottom: 6.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.r),
                  ),
                  border: Border.all(color: containerColorTab),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Text(
                        Get
                            .find<AppConstants>()
                            .urlHTCS + widget.idReport,
                        style: textNormalCustom(
                          color: AppTheme.getInstance().colorField(),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: Get
                                  .find<AppConstants>()
                                  .urlHTCS +
                                  widget.idReport,
                            ),
                          ).then((value) {
                            MessageConfig.show(title: S.current.copy_success);
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
            spaceH12,
            Container(
              height: 40.h,
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
                labelColor: AppTheme.getInstance().colorField(),
                unselectedLabelColor: infoColor,
                indicatorColor: AppTheme.getInstance().colorField(),
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
                  TabCungHeThongMobile(
                    cubit: cubit,
                  ),
                  TabNgoaiHeThongMobile(
                    cubit: cubit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
