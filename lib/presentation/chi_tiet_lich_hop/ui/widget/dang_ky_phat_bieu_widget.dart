
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_bieu_quyet_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/phat_bieu_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DangKyPhatBieuWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const DangKyPhatBieuWidget({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  State<DangKyPhatBieuWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<DangKyPhatBieuWidget> {
  final TaoBieuQuyetRequest taoBieuQuyetRequest = TaoBieuQuyetRequest();
  final userName = HiveLocal.getDataUser()?.userInformation?.hoTen ?? '';
  final unitName = HiveLocal.getDataUser()?.userInformation?.donVi ?? '';
  String phienHopErrorText = '';
  String valueDropDownSelected = '';
  final timeController = TextEditingController();
  String errorText = '';

  @override
  void initState() {
    super.initState();
    taoBieuQuyetRequest.lichHopId = widget.id;
    taoBieuQuyetRequest.unitName = unitName;
    taoBieuQuyetRequest.personName = userName;
  }

  void validatePhienHop() {
    final chonPhienHop = (taoBieuQuyetRequest.phienHopId ?? '').isEmpty;
    setState(() {
      phienHopErrorText = chonPhienHop ? S.current.vui_long_chon_phien_hop : '';
    });
  }

  void validateForm (String value){
    validatePhienHop();
    validate(value);
  }

  void validate(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        errorText = S.current.vui_long_nhap_thoi_gian_phat_bieu;
      });
    } else {
      final intValue = int.tryParse(value.trim());
      setState(() {
        errorText = intValue != null ? '' : S.current.nhap_sai_dinh_dang;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.xac_nhan,
          onClickLeft: () {
            Navigator.pop(context);
          },
          onClickRight: () {
            validateForm(timeController.text);
            if (errorText.isEmpty && phienHopErrorText.isEmpty) {
              taoBieuQuyetRequest.content?.trim();
              widget.cubit.taoPhatBieu(taoBieuQuyetRequest);
              Navigator.pop(context);
            }
          },
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 8),
              child: Text(
                S.current.phien_hop,
                style: tokenDetailAmount(
                  color: dateColor,
                  fontSize: 14.0,
                ),
              ),
            ),
            StreamBuilder<List<ListPhienHopModel>>(
              stream: widget.cubit.danhSachChuongTrinhHop,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                final newListSelect =
                data.map((e) => e.tieuDe ?? '').toList();
                return CoolDropDown(
                  key: UniqueKey(),
                  maxLines:  2,
                  useCustomHintColors: true,
                  placeHoder: S.current.chon_phien_hop,
                  listData: newListSelect,
                  initData: valueDropDownSelected,
                  onChange: (value) {
                    taoBieuQuyetRequest.phienHopId = data[value].id;
                    validatePhienHop();
                    valueDropDownSelected  = data[value].tieuDe ?? '';
                  },
                );
              },
            ),
            if (phienHopErrorText.isNotEmpty)
              Text(
                phienHopErrorText,
                style: const TextStyle(fontSize: 12, color: canceledColor),
              ),
            InputInfoUserWidget(
              isObligatory: true,
              title: S.current.thoi_gian_phat_bieu,
              child: const SizedBox(),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldValidator(
                    controller: timeController,
                    textInputType: TextInputType.number,
                    onChange: (value) {
                      validate(value);
                      try {
                        taoBieuQuyetRequest.time = int.parse(value);
                      } catch (_) {}
                    },
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                spaceW16,
                Expanded(
                  child: InputInfoUserWidget(
                    title: S.current.phut,
                    child: const SizedBox(),
                  ),
                ),
              ],
            ),
            if (errorText.isNotEmpty)
              Text(
                errorText,
                style: const TextStyle(fontSize: 12, color: canceledColor),
              ),
            spaceH24,
            Text(
              S.current.noi_dung_phat_bieu,
              style: tokenDetailAmount(
                fontSize: 14.0.textScale(),
                color: borderCaneder,
              ),
            ),
            spaceH5,
            TextFieldValidator(
              maxLine: 5,
              onChange: (value) {
                taoBieuQuyetRequest.content = value;
              },
            ),
            spaceH24,
          ],
        ),
      ),
    );
  }
}
