import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/selecdate_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/select_file/select_file.dart';
import 'package:ccvc_mobile/widgets/dropdown/drop_down_search_widget.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuaPhienHopScreen extends StatefulWidget {
  final String id;
  final String lichHopId;
  final DetailMeetCalenderCubit cubit;
  final ListPhienHopModel phienHopModel;

  const SuaPhienHopScreen({
    Key? key,
    required this.cubit,
    required this.id,
    required this.lichHopId,
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
  TextEditingController ngayKetThuc = TextEditingController();
  TextEditingController nguoiChuTri = TextEditingController();
  TextEditingController noiDung = TextEditingController();

  @override
  void initState() {
    super.initState();
    tenPhienHop.text = widget.phienHopModel.tieuDe ?? '';
    ngay.text = widget.phienHopModel.thoiGianBatDau ?? '';
    ngayKetThuc.text = widget.phienHopModel.thoiGianKetThuc ?? '';
    noiDung.text = widget.phienHopModel.noiDung ?? '';
    widget.cubit.chonNgay = widget.phienHopModel.thoiGianBatDau ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: DoubleButtonBottom(
          onClickRight: () async {
            _keyBaseTime.currentState?.validator();
            if (_key.currentState?.validator() ?? false) {
              await widget.cubit.suaChuongTrinhHop(
                id: widget.id,
                lichHopId: widget.lichHopId,
                tieuDe: tenPhienHop.text,
                thoiGianBatDau: widget.cubit.plus(
                  widget.cubit.ngaySinhs,
                  widget.cubit.start,
                ),
                thoiGianKetThuc: widget.cubit.plus(
                  widget.cubit.ngaySinhs,
                  widget.cubit.end,
                ),
                canBoId: HiveLocal.getDataUser()?.userId ?? '',
                donViId: HiveLocal.getDataUser()
                        ?.userInformation
                        ?.donViTrucThuoc
                        ?.id ??
                    '',
                noiDung: noiDung.text,
                hoTen: widget.cubit.idPerson,
                isMultipe: false,
                file: widget.cubit.listFile ?? [],
              );
              Navigator.pop(context, true);
            } else {
              return;
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
                child: SelectDateWidget(
                  paddings: 10,
                  leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
                  value: ngay.text,
                  onSelectDate: (dateTime) {
                    if (mounted) setState(() {});
                    widget.cubit.ngaySinhs = dateTime;
                  },
                ),
              ),
              spaceH20,
              BaseChooseTimerWidget(
                timeBatDau: widget.cubit.subStringTime(ngay.text),
                key: _keyBaseTime,
                timeKetThuc: widget.cubit.subStringTime(ngayKetThuc.text),
                onChange: (start, end) {
                  widget.cubit.start = start;
                  widget.cubit.end = end;
                },
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
                        widget.cubit.idPerson = data[value].hoTen ?? '';
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
                  controller: noiDung,
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
              SelectFileBtn(
                onChange: (files) {
                  //   widget.createCubit.filesTaoLich = files;
                },
                maxSize: MaxSizeFile.MAX_SIZE_30MB.toDouble(),
                initFileFromApi: widget.phienHopModel.files
                    .map((file) => FileModel(
                          id: file.id ?? '',
                          fileLength: file.getSize(),
                          name: file.name,
                        ))
                    .toList(),
                onDeletedFileApi: (fileDeleted) {
                  // widget.createCubit.filesDelete.add(
                  //   fileDeleted.id ?? '',
                  // );
                },
                allowedExtensions: const [
                  FileExtensions.DOC,
                  FileExtensions.DOCX,
                  FileExtensions.JPEG,
                  FileExtensions.JPG,
                  FileExtensions.PDF,
                  FileExtensions.PNG,
                  FileExtensions.XLSX,
                  FileExtensions.PPTX,
                ],
              ),
              ButtonSelectFile(
                removeFileApi: (int index) {},
                title: S.current.tai_lieu_dinh_kem,
                onChange: (
                  value,
                ) {
                  widget.cubit.listFile = value;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
