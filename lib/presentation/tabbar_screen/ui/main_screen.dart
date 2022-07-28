import 'package:ccvc_mobile/presentation/tabbar_screen/bloc/main_cubit.dart';
import 'package:ccvc_mobile/presentation/tabbar_screen/ui/tabbar_item.dart';
import 'package:ccvc_mobile/presentation/tabbar_screen/ui/widgets/custom_navigator_tabbar.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTabBarView extends StatefulWidget {
  const MainTabBarView({Key? key}) : super(key: key);

  @override
  _MainTabBarViewState createState() => _MainTabBarViewState();
}

class _MainTabBarViewState extends State<MainTabBarView> {
  final List<TabScreen> _listScreen = [];
  final MainCubit _cubit = MainCubit();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _addScreen(TabBarType.home);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MainCubit>(
      cubit: _cubit,
      child: StreamBuilder<TabBarType>(
        stream: _cubit.selectTabBar,
        builder: (context, snapshot) {
          final type = snapshot.data ?? TabBarType.home;
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: IndexedStack(
              index: _getIndexListScreen(type),
              children: _listScreen.map((e) => e.widget).toList(),
            ),
            bottomNavigationBar: BottomTabBarWidget(
              selectItemIndex: type.index,
              onChange: (value) {
                _addScreen(value);
                _cubit.selectTab(value);
              },
              onDoubleTap: (value) {
                _addScreen(value);
                _cubit.selectTab(value);
                _cubit.selectDoubleTap(value);
              },
            ),
          );
        },
      ),
    );
  }

  int _getIndexListScreen(TabBarType type) {
    return _listScreen
        .indexWhere((element) => element.type.index == type.index);
  }

  void _addScreen(TabBarType type) {
    if (_listScreen.indexWhere((element) => element.type.index == type.index) ==
        -1) {
      _listScreen.add(
        TabScreen(widget: type.getScreen(), type: type),
      );
    }
  }
}
