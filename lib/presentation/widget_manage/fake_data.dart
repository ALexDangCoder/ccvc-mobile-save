import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';

class FakeData {
  static final List<WidgetModel> listUse = [
    WidgetModel(
        name: 'Tình hình xử lý văn bản',
        id: '',
        component: 'TinhHinhXuLyVanBan',),
    WidgetModel(name: 'Văn bản', id: '', component: 'VanBanWidGet'),
    WidgetModel(name: 'Tổng hợp nhiệm vụ', id: '', component: 'TongHopNhiemVu'),
    WidgetModel(name: 'Nhiệm vụ', id: '', component: 'NhienVuWidGet'),
    WidgetModel(
        name: 'Ý kiến người dân', id: '', component: 'YKienNguoiDanTongHop',),
    WidgetModel(name: 'Lịch làm việc', id: '', component: 'BoxLichLamViec'),
    WidgetModel(name: 'Lịch họp', id: '', component: 'BoxLichHop'),
    WidgetModel(name: 'Báo chị mạng xã hội', id: '', component: 'BaoChi'),
    WidgetModel(name: 'Danh sách công việc', id: '', component: 'BoxTodoList'),
    WidgetModel(
        name: 'Sự kiện trong ngày', id: '', component: 'SuKienTrongNgay',),
    WidgetModel(name: 'Sinh nhật', id: '', component: 'SinhNhat'),
  ];

  static final List<WidgetModel> listNotUse = [
    WidgetModel(
        id: 'bb',
        name: 'Tình hình xử lý ý kiến người dân',
        component: 'TinhHinhXuLyYKienNguoiDan',)
  ];
}
