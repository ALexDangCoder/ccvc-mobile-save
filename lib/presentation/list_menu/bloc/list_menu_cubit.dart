import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/menu_item_model.dart';
import 'package:ccvc_mobile/presentation/list_menu/bloc/list_menu_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:rxdart/rxdart.dart';

class ListMenuCubit extends BaseCubit<ListMenuState> {
  ListMenuCubit() : super(ListMenuInitial());

  BehaviorSubject<List<bool>> checkExpandSubject =
      BehaviorSubject<List<bool>>();

  Stream<List<bool>> get streamCheckExpand => checkExpandSubject.stream;

  List<bool> isCheck = [false, false, false];

  DetailMissionViewModel() {
    checkExpandSubject.add(isCheck);
  }

  void selectExpand(int index) {
    for (int i = 0; i < isCheck.length; i++) {
      if (i == index) {
        isCheck[i] = !isCheck[i];
      } else {
        isCheck[i] = false;
      }
    }
    checkExpandSubject.add(isCheck);
  }

  List<String> img = [
    ImageAssets.icTongSoLichLamviec,
    ImageAssets.icLichCongTacTrongNuoc,
    ImageAssets.icLichCongTacTrongNuoc,
  ];

  List<MenuItemSchedule> menuItems = [
    MenuItemSchedule(
        key: 'abc', menuTitle: "Lịch của tôi", badgeNumber: 15, children: []),
    MenuItemSchedule(
      key: 'abc',
      menuTitle: "Lịch theo trạng thái",
      badgeNumber: 0,
      children: [
        ChildrenMenuItem(isSelected: true, title: 'Lịch được mời', number: 15),
        ChildrenMenuItem(isSelected: true, title: 'Lịch tạo hộ', number: 15),
        ChildrenMenuItem(isSelected: true, title: 'Lịch hủy', number: 15),
        ChildrenMenuItem(isSelected: true, title: 'Lịch thu hồi', number: 15),
        ChildrenMenuItem(
            isSelected: true, title: 'Lịch đã có báo cáo', number: 15),
        ChildrenMenuItem(
            isSelected: true, title: 'Lịch chưa có báo cáo', number: 15),
      ],
    ),
    MenuItemSchedule(
      key: 'abc',
      menuTitle: "Lịch lãnh đạo",
      badgeNumber: 0,
      children: [
        ChildrenMenuItem(
            isSelected: true, title: 'Lãnh đạo UBND Tỉnh', number: 12),
        ChildrenMenuItem(
            isSelected: true, title: 'Văn phòng UBND Tỉnh', number: 3),
        ChildrenMenuItem(
            isSelected: true, title: 'Sở Kế hoạch và Đầu tư', number: 8)
      ],
    ),
  ];

  List<MenuItemSchedule> fakeDataMenu() {
    return [];
  }
}
