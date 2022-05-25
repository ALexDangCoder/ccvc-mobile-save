import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_bieu_quyet_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/phat_bieu_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/cupertino.dart';

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
  TaoBieuQuyetRequest taoBieuQuyetRequest = TaoBieuQuyetRequest();
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();
  TextEditingController timeControler = TextEditingController();
  final userName = HiveLocal.getDataUser()?.username ?? '';
  late bool isShow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taoBieuQuyetRequest.lichHopId = widget.id;
    taoBieuQuyetRequest.unitName = 'UBND TỈNH ĐỒNG NAI';
    taoBieuQuyetRequest.personName = userName;
    isShow = false;
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.xac_nhan,
          onPressed1: () {
            Navigator.pop(context);
          },
          onPressed2: () {
            if (timeControler.text == '') {
              isShow = true;
              setState(() {});
            } else {
              taoBieuQuyetRequest.content = noiDungController.text;
              widget.cubit.taoPhatBieu(taoBieuQuyetRequest);
              Navigator.pop(context);
            }
          },
        ),
      ),
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
                hint: Text(
                  'Tất cả',
                  style: tokenDetailAmount(
                    fontSize: 14.0.textScale(),
                    color: titleColor,
                  ),
                ),
                items: [...data.map((e) => e.tieuDe ?? '').toList(), 'Tất cả'],
                onSelectItem: (value) {
                  if (value < data.length) {
                    taoBieuQuyetRequest.phienHopId = data[value].id;
                  }
                },
              );
            },
          ),
          Column(
            children: [
              InputInfoUserWidget(
                isObligatory: true,
                title: S.current.thoi_gian_phat_bieu,
                child: const SizedBox(),
              ),
              ShowRequied(
                isShow: isShow,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldValidator(
                        controller: timeControler,
                        textInputType: TextInputType.number,
                        onChange: (vl) {
                          if (timeControler.text != '') {
                            isShow = false;
                            setState(() {});
                          }
                          taoBieuQuyetRequest.time = int.parse(vl);
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
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Flexible(
            child: BlockTextView(
              formKey: formKeyNoiDung,
              contentController: noiDungController,
              title: S.current.noi_dung_phat_bieu,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
