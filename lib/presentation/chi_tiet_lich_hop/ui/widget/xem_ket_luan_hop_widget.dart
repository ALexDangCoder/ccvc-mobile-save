import 'dart:io';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'chon_ngay_widget.dart';
import 'edit_ket_luan_hop_screen.dart';

class XemKetLuanHopWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const XemKetLuanHopWidget({Key? key, required this.cubit, required this.id})
      : super(key: key);

  @override
  _XemKetLuanHopWidgetState createState() => _XemKetLuanHopWidgetState();
}

class _XemKetLuanHopWidgetState extends State<XemKetLuanHopWidget> {
  late String valueEdit;
  late bool show;
  late String reportStatusId;
  late String reportTemplateId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueEdit = '';
    show = false;
    reportStatusId = '';
    reportTemplateId = '';
    widget.cubit.getXemKetLuanHop(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: FollowKeyBoardWidget(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TitleWithRedStartWidget(
                    title: S.current.tinh_trang,
                  ),
                ),
                ShowRequied(
                  isShow: show,
                  child: StreamBuilder<List<StatusKetLuanHopModel>>(
                    stream: widget.cubit.dataTinhTrangKetLuanHop,
                    builder: (context, snapshot) {
                      final datatinhTrang = snapshot.data ?? [];
                      return CustomDropDown(
                        hint: Text(
                          widget.cubit.xemKetLuanHopModel.reportStatus ?? '',
                          style: textNormal(color586B8B, 14),
                        ),
                        items: datatinhTrang.map((e) => e.displayName).toList(),
                        onSelectItem: (value) {
                          final vlSelect = datatinhTrang[value];
                          if (widget.cubit.xemKetLuanHopModel.reportStatusId !=
                              vlSelect.id) {
                            reportStatusId = vlSelect.id ?? '';
                            show = false;
                            setState(() {});
                          }
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 20),
                  child: Text(
                    S.current.chon_mau_bien_ban,
                    style: textNormal(color586B8B, 14),
                  ),
                ),
                StreamBuilder<ChonBienBanCuocHopModel>(
                    stream: widget.cubit.dataMauBienBan,
                    builder: (context, snapshot) {
                      final data = snapshot.data?.items ?? [];
                      return CustomDropDown(
                        hint: data.isNotEmpty
                            ? Text(
                                widget.cubit.getValueMauBienBanWithId(
                                  widget.cubit.xemKetLuanHopModel
                                          .reportTemplateId ??
                                      '',
                                ),
                                style: textNormal(color586B8B, 14),
                              )
                            : const SizedBox(),
                        items: data.map((e) => e.name).toList(),
                        onSelectItem: (value) {
                          widget.cubit.getValueMauBienBan(value);
                          if (widget
                                  .cubit.xemKetLuanHopModel.reportTemplateId !=
                              data[value].id) {
                            reportTemplateId = data[value].id ?? '';
                          }
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 20),
                  child: Text(
                    S.current.noi_dung,
                    style: textNormal(color586B8B, 14),
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
                      border: Border.all(color: colorDBDFEF),
                      borderRadius: BorderRadius.circular(6),
                    ),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: ButtonSelectFile(
                    title: S.current.them_tai_lieu_cuoc_hop,
                    onChange: (List<File> files) {},
                  ),
                ),
                ListFileFromAPI(
                  data: [],
                  onTap: () {},
                ),
                Padding(
                  padding: APP_DEVICE == DeviceType.MOBILE
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(horizontal: 100),
                  child: DoubleButtonBottom(
                    title1: S.current.dong,
                    title2: S.current.xac_nhan,
                    onPressed1: () {
                      Navigator.pop(context);
                    },
                    onPressed2: () {
                      if (reportStatusId.isNotEmpty) {
                        widget.cubit.suaKetLuan(
                          scheduleId: widget.id,
                          reportStatusId: reportStatusId,
                          reportTemplateId: reportTemplateId,
                        );
                        Navigator.pop(context);
                      } else {
                        show = true;
                        setState(() {});
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
      ),
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
          style: textNormal(color586B8B, 14),
        ),
        Text(
          ' *',
          style: textNormalCustom(color: colorF94444),
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
              textShow == '' ? S.current.khong_duoc_de_trong : textShow,
              style: textDetailHDSD(color: colorF94444, fontSize: 12),
            ),
          )
        else
          const SizedBox()
      ],
    );
  }
}
