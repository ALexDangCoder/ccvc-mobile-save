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
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/cupertino.dart';
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
  final _formKey = GlobalKey<FormGroupState>();
  final userName = HiveLocal.getDataUser()?.username ?? '';

  @override
  void initState() {
    super.initState();
    taoBieuQuyetRequest.lichHopId = widget.id;
    taoBieuQuyetRequest.unitName = 'UBND TỈNH ĐỒNG NAI';
    taoBieuQuyetRequest.personName = userName;
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
            if (_formKey.currentState?.validator() ?? false) {
              widget.cubit.taoPhatBieu(taoBieuQuyetRequest);
              Navigator.pop(context);
            }
          },
        ),
      ),
      child: FormGroup(
        scrollController: ScrollController(),
        key: _formKey,
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
                  return CustomDropDown(
                    items: [
                      ...data.map((e) => e.tieuDe ?? '').toList(),
                      S.current.tat_ca,
                    ],
                    onSelectItem: (value) {
                      taoBieuQuyetRequest.phienHopId = data[value].id;
                    },
                    value: S.current.tat_ca,
                  );
                },
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
                      textInputType: TextInputType.number,
                      onChange: (vl) {
                        try{
                          taoBieuQuyetRequest.time = int.parse(vl);
                        }catch(e){
                          _formKey.currentState?.validator();
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return S.current.khong_duoc_de_trong;
                        }
                        try{
                          int.parse(value?.trim() ?? '');
                        }catch(e){
                          return S.current.check_so_luong;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: InputInfoUserWidget(
                      title: S.current.phut,
                      child: const SizedBox(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
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
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
