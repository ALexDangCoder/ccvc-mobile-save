import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/dropdown_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

// todo chi tiet van ban
class CongTacChuanBiScreen extends StatefulWidget {
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
    // List<bool> openTab = [];

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
            child: ExpansionTitleCustom(
              expand: expanded,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(S.current.cong_tac_chuan_bi),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Column(
                  children: [
                    Text(S.current.thong_tin_phong),
                    StreamBuilder<DetailDocumentProfileSend>(
                      initialData: cubit.thongTinGuiNhan,
                      stream: cubit.detailDocumentGuiNhan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderItemCalender),
                                  color: borderItemCalender.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
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
                    Text(S.current.thong_tin_yeu_cau_thiet_bi),
                    StreamBuilder<DetailDocumentProfileSend>(
                      initialData: cubit.thongTinGuiNhan,
                      stream: cubit.detailDocumentGuiNhan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderItemCalender),
                                  color: borderItemCalender.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
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
            child: ExpansionTitleCustom(
              expand: expanded2,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(S.current.thanh_phan_tham_gia),
              ),
              child: Container(
                color: Colors.red,
                height: 50,
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
            child: ExpansionTitleCustom(
              expand: expanded3,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(S.current.tai_lieu),
              ),
              child: Container(
                color: Colors.red,
                height: 50,
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
            child: ExpansionTitleCustom(
              expand: expanded4,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(S.current.phat_bieu),
              ),
              child: Container(
                color: Colors.red,
                height: 50,
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
            child: ExpansionTitleCustom(
              expand: expanded5,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(S.current.bieu_quyet),
              ),
              child: Container(
                color: Colors.red,
                height: 50,
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
            child: ExpansionTitleCustom(
              expand: expanded6,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(S.current.ket_luan_hop),
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
            child: ExpansionTitleCustom(
              expand: expanded7,
              paddingRightIcon: const EdgeInsets.only(right: 21),
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 10.5,
                  bottom: 10.5,
                ),
                child: Text(S.current.y_kien_cuop_hop),
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
