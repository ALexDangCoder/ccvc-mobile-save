import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/selecdate_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
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
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
  late String timeStart;
  late String timeEnd;
  String thoiGianHop = '';
  bool isShowValidate = false;

  @override
  void initState() {
    super.initState();
    tenPhienHop.text = widget.phienHopModel.tieuDe ?? '';
    ngay.text = widget.phienHopModel.thoiGianBatDau ?? '';
    ngayKetThuc.text = widget.phienHopModel.thoiGianKetThuc ?? '';
    noiDung.text = widget.phienHopModel.noiDung ?? '';
    widget.cubit.chonNgay = widget.phienHopModel.thoiGianBatDau ?? '';
    widget.cubit.idPerson = widget.phienHopModel.hoTen ?? '';
    timeEnd = DateFormat(DateTimeFormat.DATE_TIME_RECEIVE)
        .parse(widget.phienHopModel.thoiGianKetThuc ?? '')
        .formatTime;
    timeStart = DateFormat(DateTimeFormat.DATE_TIME_RECEIVE)
        .parse(widget.phienHopModel.thoiGianBatDau ?? '')
        .formatTime;
    thoiGianHop = DateFormat(DateTimeFormat.DATE_TIME_RECEIVE)
        .parse(widget.phienHopModel.thoiGianBatDau ?? '')
        .formatApi;
    handleButtonSaveClick();
  }

  void handleButtonSaveClick() {
    // Thời gian bắt đầu phiên họp:
    final dateTimeStart = '$thoiGianHop $timeStart'.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    //Thời gian kết thúc phiên họp:
    final dateTimeEnd = '$thoiGianHop $timeEnd'.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    //Thời gian bắt đầu cuộc họp:
    final limitTimeStart = widget.cubit.getTime().convertStringToDate(
          formatPattern: DateTimeFormat.DATE_TIME_HM,
        );

    //Thời gian kết thúc cuộc họp:
    final limitTimeEnd =
        widget.cubit.getTime(isGetDateStart: false).convertStringToDate(
              formatPattern: DateTimeFormat.DATE_TIME_HM,
            );

    final bool isOverMeetingTime = dateTimeStart.isBefore(limitTimeStart) ||
        dateTimeEnd.isAfter(limitTimeEnd);
    final bool validateTime = _keyBaseTime.currentState?.validator() ?? false;

    if (validateTime) {
      widget.cubit.isValidateTimer.sink.add(isOverMeetingTime);
      isShowValidate = isOverMeetingTime;
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: DoubleButtonBottom(
          onClickRight: () async {
            final nav = Navigator.of(context);
            if (_key.currentState?.validator() ?? false) {
              await widget.cubit.suaChuongTrinhHop(
                id: widget.id,
                lichHopId: widget.lichHopId,
                tieuDe: tenPhienHop.text,
                thoiGianBatDau: '$thoiGianHop $timeStart',
                thoiGianKetThuc: '$thoiGianHop $timeEnd',
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
              nav.pop(true);
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
                    thoiGianHop = dateTime.changeToNewPatternDate(
                      DateTimeFormat.DEFAULT_FORMAT,
                      DateTimeFormat.DOB_FORMAT,
                    );
                    handleButtonSaveClick();
                  },
                ),
              ),
              spaceH20,
              SizedBox(
                child: StreamBuilder<bool>(
                  stream: widget.cubit.isValidateTimer,
                  builder: (context, snapshot) {
                    return ShowRequied(
                      isShow: snapshot.data ?? true,
                      textShow: S.current.validata_phien_hop,
                      child: BaseChooseTimerWidget(
                        key: _keyBaseTime,
                        timeBatDau: timeStart.getTimeData(
                          timeReturnParseFail: TimerData(
                            hour: DateTime.now().hour,
                            minutes: DateTime.now().minute,
                          ),
                        ),
                        isCheckRemoveDidUpdate: true,
                        timeKetThuc: timeEnd.getTimeData(
                          timeReturnParseFail: TimerData(
                            hour: DateTime.now().hour,
                            minutes: DateTime.now().minute,
                          ),
                        ),
                        onChange: (start, end) {
                          timeStart = start.timerToString;
                          timeEnd = end.timerToString;
                          handleButtonSaveClick();
                        },
                        validator: (timeBegin, timerEn) {
                          return timeBegin.equalTime(timerEn);
                        },
                      ),
                    );
                  },
                ),
              ),
              StreamBuilder<List<NguoiChutriModel>>(
                stream: widget.cubit.listNguoiCHuTriModel.stream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  return InputInfoUserWidget(
                    title: S.current.nguoi_chu_tri,
                    child: DropDownSearch(
                      initSelected: widget.phienHopModel.hoTen ?? '',
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
