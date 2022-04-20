import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
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

class SuaPhienHopScreen extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;
  final ListPhienHopModel phienHopModel;

  const SuaPhienHopScreen({
    Key? key,
    required this.cubit,
    required this.id,
    required this.phienHopModel,
  }) : super(key: key);

  @override
  _SuaPhienHopScreenState createState() => _SuaPhienHopScreenState();
}

class _SuaPhienHopScreenState extends State<SuaPhienHopScreen> {
  final _key = GlobalKey<FormGroupState>();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();
  TextEditingController tenPhienHop = TextEditingController();
  TextEditingController ngay = TextEditingController();
  TextEditingController nguoiChuTri = TextEditingController();
  TextEditingController noiDung = TextEditingController();

  @override
  void initState() {
    super.initState();
    tenPhienHop.text = widget.phienHopModel.tieuDe ?? '';
    tenPhienHop.text = widget.phienHopModel.tieuDe ?? '';
    nguoiChuTri.text = widget.phienHopModel.hoTen ?? '';
    noiDung.text = widget.phienHopModel.noiDung ?? '';
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
          child: DoubleButtonBottom(
            onPressed2: () {
              _keyBaseTime.currentState?.validator();
              if (_key.currentState?.validator() ?? false) {
                Navigator.pop(context);
              }
            },
            onPressed1: () {
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
                InputInfoUserWidget(
                  title: S.current.them_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    controller: tenPhienHop,
                    hintText: S.current.nhap_ten_phien_hop,
                    onChange: (value) {
                      widget.cubit.taoPhienHopRepuest.tieuDe = value;
                    },
                    validator: (value) {
                      return value?.checkNull();
                    },
                  ),
                ),
                InputInfoUserWidget(
                  title: S.current.thoi_gian_hop,
                  isObligatory: true,
                  child: CustomSelectDate(
                    value: DateTime.now().toString(),
                    onSelectDate: (value) {
                      widget.cubit.taoPhienHopRepuest.thoiGian_BatDau =
                          value.toString();
                      widget.cubit.taoPhienHopRepuest.thoiGian_KetThuc =
                          value.toString();
                    },
                  ),
                ),
                spaceH20,
                BaseChooseTimerWidget(
                  key: _keyBaseTime,
                  validator: () {},
                ),
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
                          widget.cubit.taoPhienHopRepuest.hoTen =
                              data[value].hoTen;
                        },
                        listSelect: data.map((e) => e.hoTen ?? '').toList(),
                      ),
                    );
                  },
                ),
                InputInfoUserWidget(
                  title: S.current.noi_dung_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    maxLine: 5,
                    onChange: (value) {
                      widget.cubit.taoPhienHopRepuest.noiDung = value;
                    },
                    validator: (value) {
                      return value?.checkNull();
                    },
                  ),
                ),
                spaceH20,
                ButtonSelectFile(
                  title: S.current.tai_lieu_dinh_kem,
                  onChange: (value) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
