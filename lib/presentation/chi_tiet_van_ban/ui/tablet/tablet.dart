
import 'package:ccvc_mobile/domain/model/detail_doccument/detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/history_detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/widget_phone/y_kien_xu_y.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/widget/detail_document_row_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/dropdown_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/history_widget/history_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/xem_luong.dart';

import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';

// todo chi tiet van ban
class DetailDocumentTablet extends StatefulWidget {
  // final String taskId;

  // final DetailMissionViewModel viewModel;
  // final bool isPersonal;

  // const DetailDocument(
  //     {required this.taskId,
  //       required this.viewModel,
  //       required this.isPersonal});

  @override
  State<DetailDocumentTablet> createState() => _DetailDocumentTabletState();
}

class _DetailDocumentTabletState extends State<DetailDocumentTablet> {
  late DetailDocumentCubit cubit;
  bool expanded = false;
  bool expanded2 = false;
  bool expanded3 = false;
  bool expanded4 = false;
  bool expanded5 = false;
  bool expanded6 = false;

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
      appBar: AppBarDefaultBack('Chi tiết văn bản'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.only(left: 600, top: 25, bottom: 25),
              child: ButtonCustomBottom(
                title: 'Xem luồng',
                onPressed: () {
                  MaterialPageRoute(
                    builder: (context) => StreamProcessScreen(),
                  );
                },
                isColorBlue: true,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffE2E8F0).withOpacity(0.5),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: StreamBuilder<DetailDocumentModel>(
                              initialData: cubit.detailDocumentModel,
                              stream: cubit.detailDocumentSubject,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Column(
                                        children:
                                            snapshot.data!.toListRow().map(
                                          (row) {
                                            return DetailDocumentRowTablet(
                                              row: row,
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Text('Không có dữ liệu'),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffE2E8F0).withOpacity(0.5),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ExpansionTitleCustom(
                                  expand: expanded,
                                  paddingRightIcon:
                                      const EdgeInsets.only(right: 21),
                                  title: Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 10.5,
                                      bottom: 10.5,
                                    ),
                                    child: const Text('Thông tin gửi nhận'),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 16, left: 16, right: 16),
                                    child: StreamBuilder<
                                        DetailDocumentProfileSend>(
                                      initialData: cubit.thongTinGuiNhan,
                                      stream: cubit.detailDocumentGuiNhan,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 2,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    top: 16),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffE2E8F0)),
                                                  color: const Color(0xffE2E8F0)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(6),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: snapshot.data!
                                                      .toListRow()
                                                      .map(
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
                                          return const SingleChildScrollView(
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            child: SizedBox(
                                              height: 200,
                                              child: Center(
                                                child: Text('Không có dữ liệu'),
                                              ),
                                            ),
                                          );
                                        }
                                      },
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
                                  expand: expanded3,
                                  paddingRightIcon:
                                      const EdgeInsets.only(right: 21),
                                  title: Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 10.5,
                                      bottom: 10.5,
                                    ),
                                    child: const Text(
                                        'Lịch sử cập nhật tình hình xử lý'),
                                  ),
                                  child: StreamBuilder<HistoryProcessPage>(
                                    stream: cubit.screenJobProfilesStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          cubit.listHistory.isNotEmpty) {
                                        return HistoryWidget(cubit);
                                      } else {
                                        return const SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: Text('Không có dữ liệu'),
                                            ),
                                          ),
                                        );
                                      }
                                    },
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
                                  paddingRightIcon:
                                      const EdgeInsets.only(right: 21),
                                  title: Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 10.5,
                                      bottom: 10.5,
                                    ),
                                    child: const Text('Lịch sử trả lại'),
                                  ),
                                  child: StreamBuilder<HistoryProcessPage>(
                                    stream: cubit.screenJobProfilesStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          cubit.listHistory.isNotEmpty) {
                                        return HistoryWidget(cubit);
                                      } else {
                                        return const SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: Text('Không có dữ liệu'),
                                            ),
                                          ),
                                        );
                                      }
                                    },
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
                                  paddingRightIcon:
                                      const EdgeInsets.only(right: 21),
                                  title: Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 10.5,
                                      bottom: 10.5,
                                    ),
                                    child: const Text('Lịch sử thu hồi'),
                                  ),
                                  child: StreamBuilder<HistoryProcessPage>(
                                    stream: cubit.screenJobProfilesStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          cubit.listHistory.isNotEmpty) {
                                        return HistoryWidget(cubit);
                                      } else {
                                        return const SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: Text('Không có dữ liệu'),
                                            ),
                                          ),
                                        );
                                      }
                                    },
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
                                  paddingRightIcon:
                                      const EdgeInsets.only(right: 21),
                                  title: Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 10.5,
                                      bottom: 10.5,
                                    ),
                                    child: const Text(
                                        'Lịch sử văn bản liên thông'),
                                  ),
                                  child: StreamBuilder<HistoryProcessPage>(
                                    stream: cubit.screenJobProfilesStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          cubit.listHistory.isNotEmpty) {
                                        return HistoryWidget(cubit);
                                      } else {
                                        return const SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: Text('Không có dữ liệu'),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  onChangeExpand: () {
                                    setState(() {
                                      expanded6 = !expanded6;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffE2E8F0).withOpacity(0.5),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    margin: const EdgeInsets.only(right: 30),
                    child: ExpansionTitleCustom(
                      expand: expanded2,
                      paddingRightIcon: const EdgeInsets.only(right: 21),
                      title: Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 10.5,
                          bottom: 10.5,
                        ),
                        child: const Text('Ý kiến xử lý'),
                      ),
                      child: Column(
                        children: [
                          YKienXuLyExpand(
                            onSendComment: (text, listFileId) {},
                            miss: cubit.info,
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
                )
              ],
            ),
          ],
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
