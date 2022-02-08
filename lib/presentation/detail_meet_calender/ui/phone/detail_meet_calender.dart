import 'dart:io';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/widget/custom_expand_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/widget/icon_tiltle_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/widget/them_thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

// todo chi tiet van ban
class DetailMeetCalenderScreen extends StatefulWidget {
  @override
  State<DetailMeetCalenderScreen> createState() =>
      _DetailMeetCalenderScreenState();
}

class _DetailMeetCalenderScreenState extends State<DetailMeetCalenderScreen> {
  late DetailMeetCalenderCubit cubit;
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
    cubit = DetailMeetCalenderCubit();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> openTab = [false, false, false];

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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ExpandWidgetDetailMeetCalender(
              expand: expanded,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(
                  S.current.cong_tac_chuan_bi,
                  style: titleAppbar(
                    fontSize: 16.0,
                    color: dateColor,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.thong_tin_phong,
                      style: titleAppbar(
                        fontSize: 14.0,
                        color: dateColor,
                      ),
                    ),
                    StreamBuilder<DetailDocumentProfileSend>(
                      initialData: cubit.thongTinGuiNhan,
                      stream: cubit.detailDocumentGuiNhan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderItemCalender),
                                  color: borderItemCalender.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Column(
                                  children: snapshot.data!.toListRow().map(
                                    (row) {
                                      return DetailDocumentRow(
                                        row: row,
                                      );
                                    },
                                  ).toList(),
                                ),
                              );
                            },
                          );
                        } else {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(S.current.khong_co_du_lieu),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      S.current.thong_tin_yeu_cau_thiet_bi,
                      style: titleAppbar(
                        fontSize: 14.0,
                        color: dateColor,
                      ),
                    ),
                    StreamBuilder<DetailDocumentProfileSend>(
                      initialData: cubit.thongTinGuiNhan,
                      stream: cubit.detailDocumentGuiNhan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderItemCalender),
                                  color: borderItemCalender.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Column(
                                  children: snapshot.data!.toListRow().map(
                                    (row) {
                                      return DetailDocumentRow(
                                        row: row,
                                      );
                                    },
                                  ).toList(),
                                ),
                              );
                            },
                          );
                        } else {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(S.current.khong_co_du_lieu),
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              onChangeExpand: () {
                setState(() {
                  expanded = !expanded;
                  // expanded2 = !expanded2;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ExpandWidgetDetailMeetCalender(
              expand: expanded2,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(
                  S.current.thanh_phan_tham_gia,
                  style: titleAppbar(
                    fontSize: 16.0,
                    color: dateColor,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13.5),
                    child: IconWithTiltleWidget(
                      icon: ImageAssets.icAddUser,
                      title: S.current.moi_nguoi_tham_gia,
                      onPress: () {
                        showBottomSheetCustom(
                          context,
                          child: const ThemThanhPhanThamGiaWidget(),
                          title: S.current.them_thanh_phan_tham_gia,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.5),
                    child: IconWithTiltleWidget(
                      icon: ImageAssets.icTickSquare,
                      title: S.current.diem_danh,
                      onPress: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.5, right: 18.5),
                    child: StreamBuilder<DetailDocumentProfileSend>(
                      initialData: cubit.thongTinGuiNhan,
                      stream: cubit.detailDocumentGuiNhan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderItemCalender),
                                  color: borderItemCalender.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Column(
                                  children: snapshot.data!.toListRow().map(
                                    (row) {
                                      return DetailDocumentRow(
                                        row: row,
                                      );
                                    },
                                  ).toList(),
                                ),
                              );
                            },
                          );
                        } else {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(S.current.khong_co_du_lieu),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
              onChangeExpand: () {
                setState(() {
                  expanded2 = !expanded2;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ExpandWidgetDetailMeetCalender(
              expand: expanded3,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(
                  S.current.tai_lieu,
                  style: titleAppbar(
                    fontSize: 16.0,
                    color: dateColor,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 13.5, right: 18.5),
                child: ButtonSelectFile(
                  title: S.current.them_tai_lieu_cuoc_hop,
                  onChange: (List<File> files) {
                    print(files);
                  },
                  files: [],
                ),
              ),
              onChangeExpand: () {
                setState(() {
                  expanded3 = !expanded3;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ExpandWidgetDetailMeetCalender(
              expand: expanded4,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(
                  S.current.phat_bieu,
                  style: titleAppbar(
                    fontSize: 16.0,
                    color: dateColor,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13.5),
                    child: IconWithTiltleWidget(
                      icon: ImageAssets.icVoice2,
                      title: S.current.dang_ky_phat_bieu,
                      onPress: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.5, right: 18.5),
                    child: StreamBuilder<DetailDocumentProfileSend>(
                      initialData: cubit.thongTinGuiNhan,
                      stream: cubit.detailDocumentGuiNhan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderItemCalender),
                                  color: borderItemCalender.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Column(
                                  children: snapshot.data!.toListRow().map(
                                    (row) {
                                      return DetailDocumentRow(
                                        row: row,
                                      );
                                    },
                                  ).toList(),
                                ),
                              );
                            },
                          );
                        } else {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(S.current.khong_co_du_lieu),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
              onChangeExpand: () {
                setState(() {
                  expanded4 = !expanded4;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ExpandWidgetDetailMeetCalender(
              expand: expanded5,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(
                  S.current.bieu_quyet,
                  style: titleAppbar(
                    fontSize: 16.0,
                    color: dateColor,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13.5),
                    child: IconWithTiltleWidget(
                      icon: ImageAssets.icVectorA,
                      title: S.current.them_bieu_quyet,
                      onPress: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.5, right: 18.5),
                    child: StreamBuilder<DetailDocumentProfileSend>(
                      initialData: cubit.thongTinGuiNhan,
                      stream: cubit.detailDocumentGuiNhan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderItemCalender),
                                  color: borderItemCalender.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Column(
                                  children: snapshot.data!.toListRow().map(
                                    (row) {
                                      return DetailDocumentRow(
                                        row: row,
                                      );
                                    },
                                  ).toList(),
                                ),
                              );
                            },
                          );
                        } else {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(S.current.khong_co_du_lieu),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
              onChangeExpand: () {
                setState(() {
                  expanded5 = !expanded5;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ExpandWidgetDetailMeetCalender(
              expand: expanded6,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(
                  S.current.ket_luan_hop,
                  style: titleAppbar(
                    fontSize: 16.0,
                    color: dateColor,
                  ),
                ),
              ),
              child: Container(
                color: Colors.red,
                height: 50,
              ),
              onChangeExpand: () {
                setState(() {
                  expanded6 = !expanded6;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ExpandWidgetDetailMeetCalender(
              expand: expanded7,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(
                  S.current.y_kien_cuop_hop,
                  style: titleAppbar(
                    fontSize: 16.0,
                    color: dateColor,
                  ),
                ),
              ),
              child: Container(
                color: Colors.red,
                height: 50,
              ),
              onChangeExpand: () {
                setState(() {
                  expanded7 = !expanded7;
                });
              },
            ),
          ),
        ],
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
