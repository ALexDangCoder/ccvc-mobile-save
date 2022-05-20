import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/mobile/prev_view_widget.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/drag_item_list.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  void dispose() {
    super.dispose();
    widgetManageCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.widget_manage,
          style: textNormalCustom(
            color: color3D5586,
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
                      color: AppTheme.getInstance().colorField(),
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    widgetManageCubit.resetListWidget();
                  },
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
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: widgetManageCubit.stateStream,
        child: RefreshIndicator(
          onRefresh: () async {
            await widgetManageCubit.onRefreshData();
          },
          child: SingleChildScrollView(
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
                      color: colorF0F6FF,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.icHoiChamTron),
                        const SizedBox(width: 14,),
                        Text(
                          S.current.keep_drop,
                          style: const TextStyle(color: color3D5586),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    S.current.using,
                    style: textNormalCustom(
                      color: color28C76F,
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
                      color: colorFF9F43,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>  PrevViewWidget(
                            cubit: widgetManageCubit,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
