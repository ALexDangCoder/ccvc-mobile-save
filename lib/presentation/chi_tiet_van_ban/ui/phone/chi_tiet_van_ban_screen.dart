import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/history_detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/widget_phone/y_kien_xu_y.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/dropdown_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/history_widget/history_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/xem_luong.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';

// todo chi tiet van ban
class DetailDocument extends StatefulWidget {
  // final String taskId;

  // final DetailMissionViewModel viewModel;
  // final bool isPersonal;

  // const DetailDocument(
  //     {required this.taskId,
  //       required this.viewModel,
  //       required this.isPersonal});

  @override
  State<DetailDocument> createState() => _DetailDocumentState();
}

class _DetailDocumentState extends State<DetailDocument> {
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
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarDefaultBack('Chi tiết văn bản'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: StreamBuilder<DetailDocumentModel>(
                initialData: cubit.detailDocumentModel,
                stream: cubit.detailDocumentSubject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Column(
                          children: snapshot.data!.toListRow().map(
                            (row) {
                              return DetailDocumentRow(
                                row: row,
                              );
                            },
                          ).toList(),
                        ),
                        GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 3.9,
                          children: snapshot.data!
                              .toListCheckBox()
                              .map(
                                (row) => Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 41,
                                      child: CustomCheckBox(
                                        title: '',
                                        isCheck: row.value,
                                        onChange: (bool check) {},
                                      ),
                                    ),
                                    AutoSizeText(
                                      row.title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff667793),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        )
                      ],
                    );
                  } else {
                    return  SingleChildScrollView(
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
            ),
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
                  child: const Text('Thông tin gửi nhận'),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: StreamBuilder<DetailDocumentProfileSend>(
                    initialData: cubit.thongTinGuiNhan,
                    stream: cubit.detailDocumentGuiNhan,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffE2E8F0)),
                                color: const Color(0xffE2E8F0).withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
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
                  child: const Text('Lịch sử cập nhật tình hình xử lý'),
                ),
                child: StreamBuilder<HistoryProcessPage>(
                  stream: cubit.screenJobProfilesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && cubit.listHistory.isNotEmpty) {
                      return HistoryWidget(cubit);
                    } else {
                      return  SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('Không có dữ liệu'),
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
                paddingRightIcon: const EdgeInsets.only(right: 21),
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
                    if (snapshot.hasData && cubit.listHistory.isNotEmpty) {
                      return HistoryWidget(cubit);
                    } else {
                      return const SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
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
                paddingRightIcon: const EdgeInsets.only(right: 21),
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
                    if (snapshot.hasData && cubit.listHistory.isNotEmpty) {
                      return HistoryWidget(cubit);
                    } else {
                      return const SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
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
                paddingRightIcon: const EdgeInsets.only(right: 21),
                title: Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 10.5,
                    bottom: 10.5,
                  ),
                  child: const Text('Lịch sử văn bản liên thông'),
                ),
                child: StreamBuilder<HistoryProcessPage>(
                  stream: cubit.screenJobProfilesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && cubit.listHistory.isNotEmpty) {
                      return HistoryWidget(cubit);
                    } else {
                      return const SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
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
            Padding(
              padding:
                  const EdgeInsets.only(top: 25, left: 16, right: 16, bottom: 24),
              child: ButtonCustomBottom(
                title: 'Xem luồng',
                onPressed: () {
                  MaterialPageRoute(
                    builder: (context) => StreamProcessScreen(),
                  );
                },
                isColorBlue: true,
              ),
            )
          ],
        ),
      ),
    );
  }

}


