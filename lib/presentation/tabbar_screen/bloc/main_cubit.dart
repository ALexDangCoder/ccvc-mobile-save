import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/presentation/tabbar_screen/bloc/main_state.dart';
import 'package:ccvc_mobile/presentation/tabbar_screen/ui/tabbar_item.dart';
import 'package:rxdart/rxdart.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit() : super(MainStateInitial());
  final BehaviorSubject<TabBarType> _selectTabBar =
      BehaviorSubject<TabBarType>.seeded(TabBarType.home);

  Stream<TabBarType> get selectTabBar => _selectTabBar.stream;

  final PublishSubject<TabBarType> _selectDoubleTapTabBar =
  PublishSubject<TabBarType>();


  Stream<TabBarType> get selectDoubleTapTabBar =>
      _selectDoubleTapTabBar.stream;

  void selectTab(TabBarType tab) {
    _selectTabBar.sink.add(tab);
  }
  void selectDoubleTap(TabBarType type){
    _selectDoubleTapTabBar.sink.add(type);
  }

  void dispose() {
    _selectTabBar.close();
  }
}
