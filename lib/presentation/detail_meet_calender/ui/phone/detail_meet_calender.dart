import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/custom_expand_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/icon_tiltle_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

// todo chi tiet van ban
class CongTacChuanBiScreen extends StatefulWidget {
  const CongTacChuanBiScreen({Key? key}) : super(key: key);

  @override
  State<CongTacChuanBiScreen> createState() => _CongTacChuanBiScreenState();
}

class _CongTacChuanBiScreenState extends State<CongTacChuanBiScreen> {
  late DetailDocumentCubit cubit;
  bool expanded = false;
  bool expanded2 = false;
  bool expanded3 = false;
  bool expanded4 = false;
  bool expanded5 = false;
  bool expanded6 = false;
  bool expanded7 = false;

  @override
  void initState() {
    super.initState();
    cubit = DetailDocumentCubit();
    // widget.viewModel.loadingDetail(widget.taskId, widget.isPersonal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: backgroundColorApp,
        bottomOpacity: 0.0,
        elevation: APP_DEVICE == DeviceType.MOBILE ? 0 : 0.7,
        shadowColor: bgDropDown,
        automaticallyImplyLeading: false,
        title: Text(
          S.current.chi_tiet_lich_hop,
          style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
      ),
      body: DetailMeetCalendarInherited(
        cubit: cubit,
        child: ExpandGroup(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: const [
                 CongTacChuanBiWidget(),
                 ThanhPhanThamGiaWidget(),
                 TaiLieuWidget(),
                 PhatBieuWidget(),
                 BieuQuyetWidget(),
                 KetLuanHopWidget(),
                 YKienCuocHopWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// void dowloadFile(YKienXuLyFileDinhKem file) {
//   // EasyLoading.show();
//
//   APICommon.shared.dowloadFile(file.Ten, file.Id).then((value) {
//     EasyLoading.dismiss(animation: true);
//
//     if (value.error != null) {
//       CoolAlert.show(
//         context: context,
//         type: CoolAlertType.error,
//         text: value.error,
//       );
//     } else {
//       CoolAlert.show(
//         context: context,
//         type: CoolAlertType.success,
//         text: value.data,
//       );
//     }
//   });
// }
}

// expand: openTab[index],
// onChangeExpand: () {
// final indexOpen = openTab
//     .indexWhere((element) => element == true);
// if (indexOpen >= 0) openTab[indexOpen] = false;
// if (indexOpen != index) {
// setState(() {
// openTab[index] = !openTab[index];
// });
// } else {
// setState(() {
// openTab[index] = false;
// });
// }
// },

class DetailMeetCalendarInherited extends InheritedWidget {
  DetailDocumentCubit cubit;

  DetailMeetCalendarInherited(
      {Key? key, required this.cubit, required Widget child})
      : super(key: key, child: child);

  static DetailMeetCalendarInherited of(BuildContext context) {
    final DetailMeetCalendarInherited? result = context
        .dependOnInheritedWidgetOfExactType<DetailMeetCalendarInherited>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
