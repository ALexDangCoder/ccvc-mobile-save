import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/drag_item_list.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetManageScreen extends StatefulWidget {
  const WidgetManageScreen({Key? key}) : super(key: key);

  @override
  _WidgetManageScreenState createState() => _WidgetManageScreenState();
}

class _WidgetManageScreenState extends State<WidgetManageScreen> {
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
        appBar: AppBar(
          title: Text(
            S.current.widget_manage,
            style: textNormalCustom(
              color: textTitle,
              fontSize: 18.0.textScale(space: 6),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [
            Row(
              children: [
                Center(
                  child: TextButton(
                    child: Text(
                      S.current.default_word,
                      style: textNormalCustom(
                        color: textDefault,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ],
          leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: SvgPicture.asset(
              ImageAssets.icBack,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                  height: 45,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: backgroundWidget,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    S.current.keep_drop,
                    style: const TextStyle(color: textTitle),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  S.current.using,
                  style: textNormalCustom(
                    color: itemWidgetUsing,
                    fontSize: 16,
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
                  height: 16,
                ),
                Text(
                  S.current.not_use,
                  style: textNormalCustom(
                    color: itemWidgetNotUse,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 16,
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Center(
                          child: Text(S.current.no_data),
                        ),
                      );
                    }
                  },
                ),
                ButtonCustomBottom(
                  title: S.current.xem_truoc,
                  isColorBlue: true,
                  onPressed: () {},
                )
              ],
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
