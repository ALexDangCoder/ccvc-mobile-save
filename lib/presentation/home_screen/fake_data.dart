import 'package:ccvc_mobile/domain/model/dashboard_schedule.dart';
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/home/date_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_model.dart';
import 'package:ccvc_mobile/domain/model/home/event_model.dart';
import 'package:ccvc_mobile/domain/model/home/press_network_model.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_huong_khan_cap_model.dart';
import 'package:ccvc_mobile/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';

import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

class FakeData {
  static final tinhKhanCap = <TinhHuongKhanCapModel>[
    TinhHuongKhanCapModel(
        id: '6183602f-f5fc-4cbe-9618-339658767f89',
        isLink: true,
        linkOrContent: 'https://www.google.com/',
        title: 'Cập nhật mới nhất tình hình dịch bệnh COVID-19 tại Đồng Nai'),
    TinhHuongKhanCapModel(
        id: '6009d3c6-7908-42ca-8502-5139da346a98',
        isLink: true,
        linkOrContent: 'https://www.google.com/',
        title:
            'Đồng Nai sẽ hỗ trợ gần 8.00 công dân về quê tỉnh Phú Yên trong chiều ngày 25.11'),
    TinhHuongKhanCapModel(
        id: 'b6d248b3-1120-44e3-ba97-c48e2a8f5fe2',
        isLink: true,
        linkOrContent: 'https://www.google.com/',
        title:
            'Sáng 12-11, thêm 247 ca mắc trong cộng đồng; hơn 95 ngàn trẻ từ 15 đến dưới 18 tuổi đã tiêm vắc xin COVID-19'),
    TinhHuongKhanCapModel(
        id: 'f7034c54-d00c-44a3-9105-f3f7d8ec1227',
        isLink: true,
        linkOrContent: 'https://www.google.com/',
        title:
            'Ngày 11-11: Có 8.162 ca mắc COVID-19 tại 56 địa phương, TP.HCM nhiều nhất với gần 1.200 ca')
  ];
  static final tinhHinhXuLyDocVBDen = DocumentDashboardModel(
    soLuongChoXuLy: 5,
    soLuongDangXuLy: 0,
    soLuongDaXuLy: 17,
    soLuongChoVaoSo: 4,
  );
  static final tinhHinhXuLyDocVBDi = DocumentDashboardModel(
    soLuongChoTrinhKy: 30,
    soLuongChoXuLy: 12,
    soLuongDaXuLy: 14,
    soLuongChoCapSo: 14,
    soLuongChoBanHanh: 13,
  );
  static final ykienNguoiDan = DocumentDashboardModel(
      soLuongDangXuLy: 30, soLuongQuaHan: 30, soLuongDaBanHanh: 30);
  static final listTodoWork = [
    TodoModel(
        id: "12312312312",
        important: false,
        inUsed: true,
        isDeleted: false,
        isTicked: true,
        label:
            '423 8932 48967532 9832  ư rwqe rư r hwue r r weuruwe wehruiewhru hui hewquhr uiwhe uhrewhr weh wehr ewuh riuwehriuweohr jhfuwe hueifh iuew hfeui hfeuwi fhiuewhr ijhsdfhuwieh fiufheiw iuwfh ưe798237 8832341 234 234 74 89372 9843274'),
    TodoModel(
        id: "1231221312331sad2312",
        important: true,
        inUsed: true,
        isDeleted: false,
        isTicked: false,
        label: 'gán việc3543'),
    TodoModel(
        id: "1231231212312312qưq321312",
        important: false,
        inUsed: true,
        isDeleted: false,
        isTicked: false,
        label: "23423213345"),
    TodoModel(
        id: "1231231121xzc31232312",
        important: false,
        inUsed: true,
        isDeleted: false,
        isTicked: true,
        label: "Việc thì nhiều nhưng làm không bao nhiêu :)"),
    TodoModel(
        id: "1231231231231dá23112",
        important: false,
        inUsed: true,
        isDeleted: false,
        isTicked: false,
        label: "123213"),
    TodoModel(
        id: "12312312ádasdqe31sda2",
        important: true,
        inUsed: true,
        isDeleted: false,
        isTicked: true,
        label: "Họp với ban Tổng Giám đốc"),
  ];
  static final fakeDataPress = [
    PressNetWorkModel(
        url:
            "https://tin247.com/sang-61-hon-143-trieu-ca-covid-19-o-nuoc-ta-khoi-benh-toc-do-lay-cua-omicron-gap-7-lan-voi-nhom-chua-tiem-vaccine-24-29186882.html",
        publishedTime: "2022-01-06T09:47:56",
        avatar:
            "https://image2.tin247.news/pictures/2022/01/06/tyl1641437344.jpeg",
        domain: "tin247.com",
        title:
            "Sáng 6/1: Hơn 1,43 Triệu Ca Covid-19 Ở Nước Ta Khỏi Bệnh; Tốc Độ Lây Của Omicron Gấp 7 Lần Với Nhóm Chưa Tiêm Vaccine"),
    PressNetWorkModel(
        url:
            "https://tin247.com/sang-61-hon-143-trieu-ca-covid-19-o-nuoc-ta-khoi-benh-toc-do-lay-cua-omicron-gap-7-lan-voi-nhom-chua-tiem-vaccine-24-29186882.html",
        publishedTime: "2022-01-06T09:47:56",
        avatar:
            "https://image2.tin247.news/pictures/2022/01/06/tyl1641437344.jpeg",
        domain: "tin247.com",
        title:
            "Sáng 6/1: Hơn 1,43 Triệu Ca Covid-19 Ở Nước Ta Khỏi Bệnh; Tốc Độ Lây Của Omicron Gấp 7 Lần Với Nhóm Chưa Tiêm Vaccine"),
    PressNetWorkModel(
        url:
            "https://tin247.com/sang-61-hon-143-trieu-ca-covid-19-o-nuoc-ta-khoi-benh-toc-do-lay-cua-omicron-gap-7-lan-voi-nhom-chua-tiem-vaccine-24-29186882.html",
        publishedTime: "2022-01-06T09:47:56",
        avatar:
            "https://image2.tin247.news/pictures/2022/01/06/tyl1641437344.jpeg",
        domain: "tin247.com",
        title:
            "Sáng 6/1: Hơn 1,43 Triệu Ca Covid-19 Ở Nước Ta Khỏi Bệnh; Tốc Độ Lây Của Omicron Gấp 7 Lần Với Nhóm Chưa Tiêm Vaccine"),
    PressNetWorkModel(
        url:
            "https://tin247.com/sang-61-hon-143-trieu-ca-covid-19-o-nuoc-ta-khoi-benh-toc-do-lay-cua-omicron-gap-7-lan-voi-nhom-chua-tiem-vaccine-24-29186882.html",
        publishedTime: "2022-01-06T09:47:56",
        avatar:
            "https://image2.tin247.news/pictures/2022/01/06/tyl1641437344.jpeg",
        domain: "tin247.com",
        title:
            "Sáng 6/1: Hơn 1,43 Triệu Ca Covid-19 Ở Nước Ta Khỏi Bệnh; Tốc Độ Lây Của Omicron Gấp 7 Lần Với Nhóm Chưa Tiêm Vaccine"),
    PressNetWorkModel(
        url:
            "https://tin247.com/sang-61-hon-143-trieu-ca-covid-19-o-nuoc-ta-khoi-benh-toc-do-lay-cua-omicron-gap-7-lan-voi-nhom-chua-tiem-vaccine-24-29186882.html",
        publishedTime: "2022-01-06T09:47:56",
        avatar:
            "https://image2.tin247.news/pictures/2022/01/06/tyl1641437344.jpeg",
        domain: "tin247.com",
        title:
            "Sáng 6/1: Hơn 1,43 Triệu Ca Covid-19 Ở Nước Ta Khỏi Bệnh; Tốc Độ Lây Của Omicron Gấp 7 Lần Với Nhóm Chưa Tiêm Vaccine"),
    PressNetWorkModel(
        url:
            "https://tin247.com/sang-61-hon-143-trieu-ca-covid-19-o-nuoc-ta-khoi-benh-toc-do-lay-cua-omicron-gap-7-lan-voi-nhom-chua-tiem-vaccine-24-29186882.html",
        publishedTime: "2022-01-06T09:47:56",
        avatar:
            "https://image2.tin247.news/pictures/2022/01/06/tyl1641437344.jpeg",
        domain: "tin247.com",
        title:
            "Sáng 6/1: Hơn 1,43 Triệu Ca Covid-19 Ở Nước Ta Khỏi Bệnh; Tốc Độ Lây Của Omicron Gấp 7 Lần Với Nhóm Chưa Tiêm Vaccine"),
    PressNetWorkModel(
        url:
            "https://tin247.com/sang-61-hon-143-trieu-ca-covid-19-o-nuoc-ta-khoi-benh-toc-do-lay-cua-omicron-gap-7-lan-voi-nhom-chua-tiem-vaccine-24-29186882.html",
        publishedTime: "2022-01-06T09:47:56",
        avatar:
            "https://image2.tin247.news/pictures/2022/01/06/tyl1641437344.jpeg",
        domain: "tin247.com",
        title:
            "Sáng 6/1: Hơn 1,43 Triệu Ca Covid-19 Ở Nước Ta Khỏi Bệnh; Tốc Độ Lây Của Omicron Gấp 7 Lần Với Nhóm Chưa Tiêm Vaccine"),
    PressNetWorkModel(
        url:
            "https://tin247.com/sang-61-hon-143-trieu-ca-covid-19-o-nuoc-ta-khoi-benh-toc-do-lay-cua-omicron-gap-7-lan-voi-nhom-chua-tiem-vaccine-24-29186882.html",
        publishedTime: "2022-01-06T09:47:56",
        avatar:
            "https://image2.tin247.news/pictures/2022/01/06/tyl1641437344.jpeg",
        domain: "tin247.com",
        title:
            "Sáng 6/1: Hơn 1,43 Triệu Ca Covid-19 Ở Nước Ta Khỏi Bệnh; Tốc Độ Lây Của Omicron Gấp 7 Lần Với Nhóm Chưa Tiêm Vaccine")
  ];
  static final tag = [
    TagModel('Covid-19', false),
    TagModel('Vaccine', true),
    TagModel('Lê Sĩ Lâm', false),
  ];
  static final documentList = [
    DocumentModel(
        title: 'Công văn 2005/KHPTDL chờ phê duyệt',
        kyHieu: 'VPCP-TTĐT',
        status: 'Hoàn thành',
        code: 'HOAN_THANH',
        noiGui: "Ban ATGT Tiền Giang - tỉnh tiền giang ok các thứ"),
    DocumentModel(
        title: 'Công văn 2005/KHPTDL chờ phê duyệt',
        kyHieu: 'VPCP-TTĐT',
        status: 'Quá hạn',
        code: 'HOAN_THANH',
        noiGui: "Ban ATGT Tiền Giang - tỉnh tiền giang ok các thứ"),
    DocumentModel(
        title: 'Công văn 2005/KHPTDL chờ phê duyệt',
        kyHieu: 'VPCP-TTĐT',
        status: 'Hoàn thành',
        code: 'QUA_HAN',
        noiGui: "Ban ATGT Tiền Giang - tỉnh tiền giang ok các thứ"),
    DocumentModel(
        title: 'Công văn 2005/KHPTDL chờ phê duyệt',
        kyHieu: 'VPCP-TTĐT',
        status: 'Hoàn thành',
        code: 'HOAN_THANH',
        noiGui: "Ban ATGT Tiền Giang - tỉnh tiền giang ok các thứ")
  ];
  static final caledar = [
    CalendarMeetingModel(
        time: '5/11/2021 8:00 - 9:00 PM',
        title: 'Hội nghị lãnh đạo về việc cải cách chương trình đào tạo',
        address: 'UBND Tỉnh Đồng Nai',
        codeStatus: DocumentStatus.CHO_XAC_NHAN,
        nguoiChuTri: 'Phan Hà Minh'),
    CalendarMeetingModel(
        time: '5/11/2021 8:00 - 9:00 PM',
        title: 'Hội nghị lãnh đạo về việc cải cách chương trình đào tạo',
        address: 'UBND Tỉnh Đồng Nai',
        codeStatus: DocumentStatus.CHO_XAC_NHAN,
        nguoiChuTri: 'Phan Hà Minh'),
    CalendarMeetingModel(
        time: '5/11/2021 8:00 - 9:00 PM',
        title: 'Hội nghị lãnh đạo về việc cải cách chương trình đào tạo',
        address: 'UBND Tỉnh Đồng Nai',
        codeStatus: DocumentStatus.CHO_XAC_NHAN,
        nguoiChuTri: 'Phan Hà Minh'),
    CalendarMeetingModel(
        time: '5/11/2021 8:00 - 9:00 PM',
        title: 'Hội nghị lãnh đạo về việc cải cách chương trình đào tạo',
        address: 'UBND Tỉnh Đồng Nai',
        codeStatus: DocumentStatus.CHO_XAC_NHAN,
        nguoiChuTri: 'Phan Hà Minh'),
    CalendarMeetingModel(
        time: '5/11/2021 8:00 - 9:00 PM',
        title: 'Hội nghị lãnh đạo về việc cải cách chương trình đào tạo',
        address: 'UBND Tỉnh Đồng Nai',
        codeStatus: DocumentStatus.THAM_GIA,
        nguoiChuTri: 'Phan Hà Minh'),
    CalendarMeetingModel(
        time: '5/11/2021 8:00 - 9:00 PM',
        title: 'Hội nghị lãnh đạo về việc cải cách chương trình đào tạo',
        address: 'UBND Tỉnh Đồng Nai',
        codeStatus: DocumentStatus.THAM_GIA,
        nguoiChuTri: 'Phan Hà Minh'),
  ];
  static final List<String> img = [
    ImageAssets.icTongSoNhiemVu,
    ImageAssets.icHoanThanhNhiemVu,
    ImageAssets.icNhiemVuDangThucHien,
    ImageAssets.icHoanThanhQuaHan,
    ImageAssets.icDangThucHienTrongHan,
    ImageAssets.icDangThucHienQuaHan,
  ];
  static final listCalendarWork = [
    DashboardSchedule(1, "22ssads2", "Tổng số nhiệm vụ"),
    DashboardSchedule(2, "2dasdsd22", "Hoàn thành nhiệm vụ"),
    DashboardSchedule(3, "2dasda22", "Nhiệm vụ đang thực hiện"),
    DashboardSchedule(4, "2asdas22", "Hoàn thành quá hạn"),
    DashboardSchedule(5, "sdasdasd", "Đang thực hiện trong hạn"),
    DashboardSchedule(5, "sdasdasd", "Đang thực hiện quá hạn"),
  ];
  static final listNhiemView = [
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
    CalendarMeetingModel(
        title:
            'Rà soát, hoàn chỉnh kế hoạch đầu tư công qweuqioweuiqowueiou ioeu iouqwioe qiow uoiq',
        loaiNhiemVu: 'Nhiệm vụ CP/VPCP',
        hanXuLy: '13/10/2021',
        codeStatus: DocumentStatus.CHO_PHAN_XU_LY),
  ];
  static final List<WidgetModel> listUseWidget = [
    WidgetModel(
        name: 'Tình hình xử lý văn bản',
        id: '',
        component: 'TinhHinhXuLyVanBan'),
    WidgetModel(name: 'Văn bản', id: '', component: 'VanBanWidGet'),
    WidgetModel(name: 'Tổng hợp nhiệm vụ', id: '', component: 'TongHopNhiemVu'),
    WidgetModel(name: 'Nhiệm vụ', id: '', component: 'NhienVuWidGet'),
    WidgetModel(
        name: 'Ý kiến người dân', id: '', component: 'YKienNguoiDanTongHop'),
    WidgetModel(name: 'Lịch làm việc', id: '', component: 'BoxLichLamViec'),
    WidgetModel(name: 'Lịch họp', id: '', component: 'BoxLichHop'),
    WidgetModel(name: 'Báo chị mạng xã hội', id: '', component: 'BaoChi'),
    WidgetModel(name: 'Danh sách công việc', id: '', component: 'BoxTodoList'),
    WidgetModel(
        name: 'Sự kiện trong ngày', id: '', component: 'SuKienTrongNgay'),
    WidgetModel(name: 'Sinh nhật', id: '', component: 'SinhNhat'),
  ];

  static DateModel dateModel = DateModel(
      dateMore: 'Thứ 3, ngày 27 tháng 04 năm 2021',
      aqiStatus: 'Tốt',
      dayLunar: 'Ngày hoàng đạo',
      lunarDate: '16 tháng 3 (Đ), Tân Sửu',
      aqi: '49');


  static final List<WidgetModel> listSearchWidget = [
    WidgetModel(name: 'Văn bản', id: '', component: 'VanBanWidGet'),
    WidgetModel(name: 'Tổng hợp nhiệm vụ', id: '', component: 'TongHopNhiemVu'),
    WidgetModel(
        name: 'Ý kiến người dân', id: '', component: 'YKienNguoiDanTongHop'),
    WidgetModel(name: 'Lịch làm việc', id: '', component: 'BoxLichLamViec'),
    WidgetModel(name: 'Lịch họp', id: '', component: 'BoxLichHop'),
    WidgetModel(name: 'Báo chị mạng xã hội', id: '', component: 'BaoChi'),
  ];

  static final userInfo = UserInformationModel(
      hoTen: 'Cao Tiến Dũng', chucVu: 'Chủ thích UBND tỉnh');
  static final suKienTrongNgay = [
    EventModel('', "Talkshow “Trí tuệ nhân tạo với cuộc sống”"),
    EventModel('', "Talkshow “Trí tuệ nhân tạo với cuộc sống”"),
    EventModel('', "Talkshow “Trí tuệ nhân tạo với cuộc sống”"),
    EventModel('', "Talkshow “Trí tuệ nhân tạo với cuộc sống”"),
    EventModel('', "Talkshow “Trí tuệ nhân tạo với cuộc sống”"),
    EventModel('', "Talkshow “Trí tuệ nhân tạo với cuộc sống”")
  ];
  static final sinhNhat = [
    EventModel('', "Sinh nhật bà Vy Vũ Hồng Thảo - (26/10/2021)"),
    EventModel('', "Sinh nhật ông Nguyễn Thanh Tú - (27/10/2021)"),
    EventModel('', "Sinh nhật ông Hồ Văn Hà - (28/10/2021)"),
    EventModel('', "Sinh nhật ông Cao Văn Thành - (29/10/2021)"),
    EventModel('', "Sinh nhật ông Lê Sĩ Lâm - (30/10/2021)"),
  ];
}
