import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

Widget tabBar(TabController _tabController) {
  return screenDevice(
      mobileScreen: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().colorField().withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppTheme.getInstance().colorField(),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: AppTheme.getInstance().colorField(),
          tabs: [
            Tab(
              text: S.current.document_incoming,
            ),
            Tab(
              text: S.current.document_out_going,
            ),
          ],
        ),
      ),
      tabletScreen: Container(
        height: 40,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: bgDropDown))),
        child: TabBar(
          controller: _tabController,
          labelColor: AppTheme.getInstance().colorField(),
          indicatorColor:  AppTheme.getInstance().colorField(),
          unselectedLabelColor: textBodyTime,
          labelStyle: textNormalCustom(
              color: AppTheme.getInstance().colorField(),
              fontSize: 16,
              fontWeight: FontWeight.w700),
          unselectedLabelStyle: textNormalCustom(
            color: textBodyTime,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          tabs: [
            Tab(
              text: S.current.van_ban_den,
            ),
            Tab(
              text: S.current.van_ban_di,
            ),
          ],
        ),
      ));
}
