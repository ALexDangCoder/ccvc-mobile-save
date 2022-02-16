import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/tablet/prev_view_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/drag_item_list.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetManageScreenTablet extends StatefulWidget {
  const WidgetManageScreenTablet({Key? key}) : super(key: key);

  @override
  _WidgetManageScreenTabletState createState() =>
      _WidgetManageScreenTabletState();
}

class _WidgetManageScreenTabletState extends State<WidgetManageScreenTablet> {
  WidgetManageCubit widgetManageCubit = WidgetManageCubit();

  @override
  void initState() {
    super.initState();
    widgetManageCubit.loadApi();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetManageProvider(
      widgetManageCubit: widgetManageCubit,
      child: Scaffold(
        backgroundColor: bgWidgets,
        appBar: AppBarDefaultBack(
          S.current.widget_manage,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 28, 30, 5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: borderColor.withOpacity(0.5),
                ),
                color: backgroundColorApp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.ic_hoicham),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            S.current.keep_drop,
                            style: textNormal(textTitle, 14.0.textScale()),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Center(
                          child: Text(
                            S.current.dat_lai_mac_dinh,
                            style: textNormalCustom(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: labelColor,
                            ),
                          ),
                        ),
                        onTap: () {
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                            const PrevViewWidgetTablet(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: unFocusColor,
                        ),
                        height: 40,
                        width: 360,
                        child: Center(
                          child: Text(
                            S.current.xem_truoc,
                            style: textNormalCustom(
                              fontSize: 16,
                              color: labelColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    S.current.using,
                    style: textNormalCustom(
                      color: itemWidgetUsing,
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder<List<WidgetModel>>(
                    stream: widgetManageCubit.listWidgetUsing,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      if (data.isNotEmpty) {
                        final List<WidgetModel> listWidgetUsing = data;
                        return DragItemList(
                          listWidget: listWidgetUsing,
                          widgetManageCubit: widgetManageCubit,
                          isUsing: true,
                        );
                      } else {
                        return Center(
                          child: Text(S.current.no_data),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.current.not_use,
                    style: textNormalCustom(
                      color: itemWidgetNotUse,
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  StreamBuilder<List<WidgetModel>>(
                    stream: widgetManageCubit.listWidgetNotUse,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      if (data.isNotEmpty) {
                        final List<WidgetModel> listWidgetNotUse = data;
                        return DragItemList(
                          listWidget: listWidgetNotUse,
                          widgetManageCubit: widgetManageCubit,
                          isUsing: false,
                        );
                      } else {
                        return Center(
                          child: Text(S.current.no_data),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetManageProvider extends InheritedWidget {
  final WidgetManageCubit widgetManageCubit;

  const WidgetManageProvider({
    Key? key,
    required this.widgetManageCubit,
    required Widget child,
  }) : super(key: key, child: child);

  static WidgetManageProvider of(BuildContext context) {
    final WidgetManageProvider? result =
        context.dependOnInheritedWidgetOfExactType<WidgetManageProvider>();
    assert(result != null, 'No elenment');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
