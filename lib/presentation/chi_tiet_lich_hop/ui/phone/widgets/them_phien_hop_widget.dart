import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_phien_hop_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/drop_down_search_widget.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/selectdate/custom_selectdate.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:flutter/material.dart';

class ThemPhienHopScreen extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const ThemPhienHopScreen({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  _ThemPhienHopScreenState createState() => _ThemPhienHopScreenState();
}

class _ThemPhienHopScreenState extends State<ThemPhienHopScreen> {
  final _key = GlobalKey<FormGroupState>();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();
  late TaoPhienHopRequest taoPhienHopRequest;

  @override
  void initState() {
    super.initState();
    taoPhienHopRequest = TaoPhienHopRequest(
      thoiGian_BatDau:
          '${DateTime.parse(DateTime.now().toString()).formatApi} ${widget.cubit.startTime}',
      thoiGian_KetThuc:
          '${DateTime.parse(DateTime.now().toString()).formatApi} ${widget.cubit.startTime}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),

          /// hai button
          child: DoubleButtonBottom(
            onClickRight: () {
              _keyBaseTime.currentState?.validator();
              if (_key.currentState?.validator() ?? false) {
                widget.cubit.themPhienHop(
                  id: widget.id,
                  taoPhienHopRequest: taoPhienHopRequest,
                );
                widget.cubit.startTime = '00:00';
                widget.cubit.endTime = '00:00';
                Navigator.pop(context);
              }
            },
            onClickLeft: () {
              Navigator.pop(context);
            },
            title1: S.current.dong,
            title2: S.current.luu,
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: FormGroup(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// them phien hop
                InputInfoUserWidget(
                  title: S.current.them_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    hintText: S.current.nhap_ten_phien_hop,
                    onChange: (value) {
                      taoPhienHopRequest.tieuDe = value;
                    },
                    validator: (value) {
                      return value?.checkNull();
                    },
                  ),
                ),

                /// thoi gian hop
                InputInfoUserWidget(
                  title: S.current.thoi_gian_hop,
                  isObligatory: true,
                  child: CustomSelectDate(
                    value: DateTime.now(),
                    onSelectDate: (value) {
                      taoPhienHopRequest.thoiGian_BatDau =
                          DateTime.parse(value.toString()).formatApi;
                      taoPhienHopRequest.thoiGian_KetThuc =
                          DateTime.parse(value.toString()).formatApi;
                    },
                  ),
                ),
                spaceH20,
                BaseChooseTimerWidget(
                  key: _keyBaseTime,
                  onChange: (timeSt, timeEnd) {
                    widget.cubit.getTimeHour(startT: timeSt, endT: timeEnd);
                  },
                ),

                /// chon nguoi chu tri
                StreamBuilder<List<NguoiChutriModel>>(
                  stream: widget.cubit.listNguoiCHuTriModel.stream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    return InputInfoUserWidget(
                      title: S.current.nguoi_chu_tri,
                      child: DropDownSearch(
                        title: S.current.nguoi_chu_tri,
                        hintText: S.current.chon_nguoi_chu_tri,
                        onChange: (value) {
                          taoPhienHopRequest.hoTen = data[value].hoTen ?? '';
                        },
                        listSelect: data.map((e) => e.hoTen ?? '').toList(),
                      ),
                    );
                  },
                ),

                /// nội dung phiên họp
                InputInfoUserWidget(
                  title: S.current.noi_dung_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    maxLine: 5,
                    onChange: (value) {
                      taoPhienHopRequest.noiDung = value;
                    },
                    validator: (value) {
                      return value?.checkNull();
                    },
                  ),
                ),
                spaceH20,

                /// thêm tài liệu
                ButtonSelectFile(
                  hasMultipleFile: true,
                  maxSize: widget.cubit.maxSizeFile30 * 1.0,
                  title: S.current.tai_lieu_dinh_kem,
                  onChange: (value) {
                    taoPhienHopRequest.files = value;
                  },
                  removeFileApi: (int index) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
