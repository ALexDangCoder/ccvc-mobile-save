import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/custom_checkbox_list_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/block_text_view_lich.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/cac_lua_chon_don_vi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/radio/custom_radio_button.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaoBieuQuyetWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const TaoBieuQuyetWidget({
    Key? key,
    required this.id,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TaoBieuQuyetWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TaoBieuQuyetWidget> {
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();
  final keyGroup = GlobalKey<FormGroupState>();
  bool isShow = false;
  bool isShowValidate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.cacLuaChonBieuQuyet = [];
    widget.cubit.listDanhSach = [DanhSachNguoiThamGiaModel()];
    widget.cubit.isValidateSubject.sink.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return FormGroup(
      key: keyGroup,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: FollowKeyBoardWidget(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH20,
                CustomRadioButtons(
                  title: S.current.loai_bieu_quyet,
                  onchange: (value) {
                    widget.cubit.loaiBieuQ = value;
                  },
                ),
                InputInfoUserWidget(
                  title: S.current.ngay_bieu_quyet,
                  isObligatory: true,
                  child: SelectDate(
                    paddings: 10,
                    leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
                    value: DateTime.now().toString(),
                    onSelectDate: (dateTime) {
                      if (mounted) setState(() {});
                      final date =
                          DateTime.parse(dateTime).toStringWithListFormat;
                      widget.cubit.date = date;
                    },
                  ),
                ),
                spaceH20,
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    child: BaseChooseTimerWidget(
                      key: _keyBaseTime,
                      timeBatDau: widget.cubit.dateTimeNowStart(),
                      timeKetThuc: widget.cubit.dateTimeNowEnd(),
                      onChange: (start, end) {
                        widget.cubit.start = start;
                        widget.cubit.end = end;
                      },
                    ),
                  ),
                ),
                BlockTextViewLich(
                  formKey: formKeyNoiDung,
                  contentController: noiDungController,
                  title: S.current.ten_bieu_quyet,
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return S.current.khong_duoc_de_trong;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ShowRequied(
                    isShow: isShow,
                    child: InputInfoUserWidget(
                      isObligatory: true,
                      title: S.current.cac_lua_chon_bieu_quyet,
                      child: CacLuaChonDonViWidget(
                        detailMeetCalenderCubit: widget.cubit,
                        onchange: (vl) {
                          if (vl.isEmpty) {
                            isShow = true;
                          } else {
                            isShow = false;
                          }
                          widget.cubit.listLuaChon = vl;
                        },
                      ),
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                    stream: widget.cubit.isValidateSubject,
                    builder: (context, snapshot) {
                      return ShowRequied(
                        isShow: snapshot.data ?? true,
                        child: InputInfoUserWidget(
                          isObligatory: true,
                          title: S.current.cac_lua_chon_bieu_quyet,
                          child: StreamBuilder<List<DanhSachNguoiThamGiaModel>>(
                            stream: widget.cubit.nguoiThamGiaSubject,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? [];
                              if (data.isNotEmpty) {
                                return CustomCheckBoxList(
                                  urlIcon: ImageAssets.icDocument,
                                  title: S.current.loai_bai_viet,
                                  onChange: (value) {
                                    setState(() {});
                                    if (widget.cubit.listDanhSach.isEmpty) {
                                      widget.cubit.isValidateSubject.sink
                                          .add(true);
                                    } else {
                                      widget.cubit.isValidateSubject.sink
                                          .add(false);
                                    }
                                    widget.cubit.listDanhSach = value;
                                  },
                                  dataNguoiThamGia: data,
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                DoubleButtonBottom(
                  isTablet: true,
                  title1: S.current.dong,
                  title2: S.current.luu,
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  onPressed2: () async {
                    if (noiDungController.text.isEmpty ||
                        widget.cubit.cacLuaChonBieuQuyet.isEmpty ||
                        widget.cubit.listDanhSach.isEmpty) {
                      isShow = true;
                      widget.cubit.isValidateSubject.sink.add(true);
                      setState(() {});
                      formKeyNoiDung.currentState!.validate();
                    } else {
                      isShow = false;
                      widget.cubit.isValidateSubject.sink.add(false);
                      setState(() {});
                      await widget.cubit.postThemBieuQuyetHop(
                        widget.id,
                        noiDungController.text,
                        widget.cubit.date,
                        widget.cubit.loaiBieuQ,
                      );
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
