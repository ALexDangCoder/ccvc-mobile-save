import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
Widget tabBar(TabController _tabController) {
  return Container(
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
  );
}