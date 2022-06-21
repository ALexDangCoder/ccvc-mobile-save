import 'dart:ui';
import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/tab_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/tab_ngoai_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChiaSeBaoCaoMobile extends StatefulWidget {
  const ChiaSeBaoCaoMobile({Key? key, required this.idReport,required this.appId,})
      : super(key: key);
  final String idReport;
  final String appId;

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
    cubit.idReport = widget.idReport;
    cubit.getGroup();
    cubit.getTree();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 750.h,
      width: MediaQuery.of(context).size.width,
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
          cubit.getTree();
        },
        error: AppException(S.current.something_went_wrong, ''),
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
                height: 40.h,
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 10.w,
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
                        S.current.chia_se,
                        style: textNormalCustom(
                          color: labelColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        ImageAssets.ic_copy,
                        color: colorA2AEBD,
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
                isScrollable: true,
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
