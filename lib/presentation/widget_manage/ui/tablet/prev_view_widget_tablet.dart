import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/preview_widget_item.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class PrevViewWidgetTablet extends StatefulWidget {
  const PrevViewWidgetTablet({Key? key}) : super(key: key);

  @override
  _PrevViewWidgetTabletState createState() => _PrevViewWidgetTabletState();
}

class _PrevViewWidgetTabletState extends State<PrevViewWidgetTablet>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  WidgetManageCubit cubit = WidgetManageCubit();
  HomeCubit homeCubit = HomeCubit();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.loadApi();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    homeCubit.loadApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.xem_truoc_widget,
      ),
      body: HomeProvider(
        controller: scrollController,
        homeCubit: homeCubit,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: homeColor,
                    child: StreamBuilder<List<WidgetModel>>(
                      stream: cubit.listWidgetUsing,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? <WidgetModel>[];
                        if (data.isNotEmpty) {
                          return Column(
                            children: List.generate(data.length, (index) {
                              final type = data[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child:
                                    type.widgetType?.getItemsTabletPreview() ??
                                        const SizedBox(),
                              );
                            }),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Container(
                  width: double.maxFinite,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
