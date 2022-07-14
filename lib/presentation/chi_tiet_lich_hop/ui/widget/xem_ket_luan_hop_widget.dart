import 'dart:io';

import 'package:ccvc_mobile/bao_cao_module/widget/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/ket_luan_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import 'edit_ket_luan_hop_screen.dart';

class CreateOrUpdateKetLuanHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final bool isCreate;
  final bool isOnlyViewContent;
  final List<String> listFile;

  const CreateOrUpdateKetLuanHopWidget({
    Key? key,
    required this.cubit,
    this.isCreate = false,
    this.isOnlyViewContent = false,
    required this.listFile,
  }) : super(key: key);

  @override
  _CreateOrUpdateKetLuanHopWidgetState createState() =>
      _CreateOrUpdateKetLuanHopWidgetState();
}

class _CreateOrUpdateKetLuanHopWidgetState
    extends State<CreateOrUpdateKetLuanHopWidget> {
  final BehaviorSubject<bool> show = BehaviorSubject.seeded(false);
  BehaviorSubject<List<String>> listFile = BehaviorSubject();
  late String valueEdit;
  late String reportStatusId;
  late String reportTemplateId;
  List<File> listFiles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueEdit = '';
    reportStatusId = '';
    reportTemplateId = '';
    listFile.sink.add(widget.listFile);
    if ((widget.cubit.xemKetLuanHopModel.reportStatus ?? '').isNotEmpty) {
      reportStatusId = widget.cubit.xemKetLuanHopModel.reportStatusId ?? '';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.cubit.dataMauBienBan.close();
    widget.cubit.noiDung.sink.add('');
    if (widget.isCreate) {
      widget.cubit.dataMauBienBan.close();
      widget.cubit.noiDung.sink.add('');
    }
    listFile.sink.add([]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: !widget.isOnlyViewContent
          ? FollowKeyBoardWidget(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// tinh trang
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TitleWithRedStartWidget(
                          title: S.current.tinh_trang,
                        ),
                      ),
                      ShowRequied(
                        isShow: show.value,
                        child: StreamBuilder<List<StatusKetLuanHopModel>>(
                          stream: widget.cubit.dataTinhTrangKetLuanHop,
                          builder: (context, snapshot) {
                            final dataTinhTrang = snapshot.data ?? [];
                            return CustomDropDown(
                              hint: Text(
                                widget.cubit.xemKetLuanHopModel.reportStatus ??
                                    S.current.chon_tinh_trang,
                                style: textNormal(
                                    (widget.cubit.xemKetLuanHopModel
                                                    .reportStatus ??
                                                '')
                                            .isNotEmpty
                                        ? titleItemEdit
                                        : signInTextSecondaryColor,
                                    14),
                              ),
                              items: dataTinhTrang
                                  .map((e) => e.displayName)
                                  .toList(),
                              onSelectItem: (value) {
                                final vlSelect = dataTinhTrang[value];
                                if (widget.cubit.xemKetLuanHopModel
                                        .reportStatusId !=
                                    vlSelect.id) {
                                  reportStatusId = vlSelect.id ?? '';
                                }
                              },
                            );
                          },
                        ),
                      ),

                      /// chon mau bien ban
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 20),
                        child: Text(
                          S.current.chon_mau_bien_ban,
                          style: textNormal(titleItemEdit, 14),
                        ),
                      ),
                      StreamBuilder<ChonBienBanCuocHopModel>(
                          stream: widget.cubit.dataMauBienBan,
                          builder: (context, snapshot) {
                            final data = snapshot.data?.items ?? [];
                            return CustomDropDown(
                              hint: Text(
                                widget.cubit
                                        .getValueMauBienBanWithId(
                                          widget.cubit.xemKetLuanHopModel
                                                  .reportTemplateId ??
                                              '',
                                        )
                                        .isEmpty
                                    ? S.current.chon_mau_bien_ban
                                    : '',
                                style: textNormal(titleItemEdit, 14),
                              ),
                              items: data.map((e) => e.name).toList(),
                              onSelectItem: (value) {
                                widget.cubit.getValueMauBienBan(value);
                                if (widget.cubit.xemKetLuanHopModel
                                        .reportTemplateId !=
                                    data[value].id) {
                                  reportTemplateId = data[value].id ?? '';
                                }
                              },
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 20),
                        child: Text(
                          S.current.just_noi_dung,
                          style: textNormal(titleItemEdit, 14),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditKetLuanHopScreen(
                                key: keyEditKetLuanHop,
                                cubit: widget.cubit,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          padding: const EdgeInsets.only(
                              bottom: 8, top: 10, left: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: SingleChildScrollView(
                            child: StreamBuilder<String>(
                              stream: widget.cubit.noiDung.stream,
                              builder: (context, snapshot) {
                                return Html(
                                  style: {
                                    'html': Style(textAlign: TextAlign.center)
                                  },
                                  data: valueEdit != snapshot.data
                                      ? (snapshot.data ?? '')
                                      : valueEdit,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      /// them tai lieu cuoc hop
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: ButtonSelectFile(
                          title: S.current.tai_lieu_dinh_kem,
                          onChange: (List<File> files) {
                            bool checkMaxFile = false;

                            /// duyet file
                            for (final data in files) {
                              if (data.lengthSync() >
                                  widget.cubit.maxSizeFile30) {
                                checkMaxFile = true;
                              } else {
                                listFiles.add(data);
                                final List<String> thisListFile =
                                    listFile.value;
                                thisListFile.add(data.path.split('/').last);
                                listFile.sink.add(thisListFile);
                              }
                            }
                            if (checkMaxFile) {
                              showToast();
                            }
                          },
                          removeFileApi: (int index) {},
                        ),
                      ),

                      /// list file
                      StreamBuilder<List<String>>(
                          stream: listFile.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final dataIndex = data[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: FileFromAPIWidget(
                                    data: dataIndex,
                                    onTapDelete: () {
                                      final List<String> thisListFile =
                                          listFile.value;
                                      thisListFile.removeAt(index);
                                      listFile.sink.add(thisListFile);
                                    },
                                  ),
                                );
                              },
                            );
                          }),
                      Padding(
                        padding: APP_DEVICE == DeviceType.MOBILE
                            ? EdgeInsets.zero
                            : const EdgeInsets.symmetric(horizontal: 100),
                        child: DoubleButtonBottom(
                          title1: S.current.dong,
                          title2: S.current.xac_nhan,
                          onClickLeft: () {
                            widget.cubit.noiDung.add('');
                            Navigator.pop(context);
                          },
                          onClickRight: () {
                            if (reportStatusId.isNotEmpty) {
                              if (widget.isCreate) {
                                widget.cubit
                                    .createKetLuanHop(
                                      reportStatusId: reportStatusId,
                                      reportTemplateId: reportTemplateId,
                                      files: listFiles,
                                    )
                                    .then(
                                      (value) =>
                                          value ? Navigator.pop(context) : '',
                                    );
                                return;
                              }
                              widget.cubit.suaKetLuan(
                                reportStatusId: reportStatusId,
                                reportTemplateId: reportTemplateId,
                              );
                              Navigator.pop(context);
                            } else {
                              show.sink.add(true);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            )

          /// chỉ xem biên bản họp
          : Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: SingleChildScrollView(
                    child: StreamBuilder<String>(
                      stream: widget.cubit.noiDung.stream,
                      builder: (context, snapshot) {
                        return Html(
                          data: valueEdit != snapshot.data
                              ? (snapshot.data ?? '')
                              : valueEdit,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.listFile.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = widget.listFile;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImageAssets.icShareFile,
                              color: AppTheme.getInstance().colorField(),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              data[index],
                              style: textDetailHDSD(
                                fontSize: 14.0.textScale(),
                                color: color5A8DEE,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ButtonCustomBottom(
                    isColorBlue: false,
                    title: S.current.dong,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  void showToast() {
    final toast = FToast();
    toast.init(context);
    toast.showToast(
      child: ShowToast(
        text: S.current.file_qua_30M,
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}

class TitleWithRedStartWidget extends StatelessWidget {
  final String title;

  const TitleWithRedStartWidget({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: textNormal(titleItemEdit, 14),
        ),
        Text(
          ' *',
          style: textNormalCustom(color: canceledColor),
        ),
      ],
    );
  }
}

class ShowRequiedWithStream extends StatelessWidget {
  final Widget child;
  final BehaviorSubject<bool> isShow;
  String textShow;

  ShowRequiedWithStream(
      {Key? key, required this.child, required this.isShow, this.textShow = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        StreamBuilder<bool>(
          stream: isShow,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  textShow.isEmpty ? S.current.khong_duoc_de_trong : textShow,
                  style: textDetailHDSD(color: canceledColor, fontSize: 12),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class ShowRequied extends StatelessWidget {
  final Widget child;
  final bool isShow;
  String textShow;

  ShowRequied(
      {Key? key, required this.child, this.isShow = false, this.textShow = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (isShow)
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              textShow.isEmpty ? S.current.khong_duoc_de_trong : textShow,
              style: textDetailHDSD(color: canceledColor, fontSize: 12),
            ),
          )
        else
          const SizedBox()
      ],
    );
  }
}
