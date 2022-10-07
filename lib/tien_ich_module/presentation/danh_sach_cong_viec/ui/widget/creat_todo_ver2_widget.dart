import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/button/button_select_file.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/chon_nguoi_thuc_hien_screen.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/select_date_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/customTextFieldVersion2.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/select_file/select_file.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';

class CreatTodoOrUpdateWidget extends StatefulWidget {
  final bool? isCreate;
  final TodoDSCVModel? todo;
  final DanhSachCongViecTienIchCubit cubit;

  const CreatTodoOrUpdateWidget({
    Key? key,
    required this.cubit,
    this.todo,
    this.isCreate,
  }) : super(key: key);

  @override
  _CreatTodoOrUpdateWidgetState createState() =>
      _CreatTodoOrUpdateWidgetState();
}

class _CreatTodoOrUpdateWidgetState extends State<CreatTodoOrUpdateWidget> {
  final TextEditingController tieuDeController = TextEditingController();
  final TextEditingController noteControler = TextEditingController();
  final TextEditingController searchControler = TextEditingController();
  BehaviorSubject<bool> isShow = BehaviorSubject.seeded(false);
  late String nameFileSelect;
  late String date;
  late String title;
  late String note;

  @override
  void initState() {
    // TODO: implement initState
    widget.cubit.listNguoiThucHien('');

    /// data can update or creat
    note = widget.todo?.note ?? '';
    date = DateTime.parse(widget.todo?.finishDay ?? DateTime.now().toString())
        .formatApi;
    title = widget.todo?.label ?? '';
    nameFileSelect = widget.todo?.filePath ?? '';
    widget.cubit.initDataNguoiTHucHienTextFild(widget.todo ?? TodoDSCVModel());
    super.initState();
    widget.cubit.nameFile.sink.add(widget.todo?.filePath ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// textFild tiêu đề
              StreamBuilder<Object>(
                stream: isShow,
                builder: (context, snapshot) {
                  return ShowRequied(
                    textShow: S.current.ban_phai_nhap_truong_tieu_de,
                    isShow: isShow.value,
                    child: ItemTextFieldWidgetDSNV(
                      initialValue: widget.todo?.label ?? '',
                      title: S.current.tieu_de,
                      controller: tieuDeController,
                      validator: (String? value) {},
                      onChange: (String value) {
                        title = value;
                        if (value.isNotEmpty) {
                          isShow.sink.add(false);
                        }
                      },
                    ),
                  );
                },
              ),

              ///chọn ngày hoàn thành
              InputInfoUserWidget(
                title: S.current.ngay_hoan_thanh,
                child: SelectDateDSCV(
                  initDateTime:
                      (widget.todo?.finishDay ?? DateTime.now().toString())
                          .convertStringToDate(
                    formatPattern: DateFormatApp.dateTimeBackEnd,
                  ),
                  leadingIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SvgPicture.asset(ImageAssets.icCalendar),
                  ),
                  value: date,
                  onSelectDate: (value) {
                    date = value;
                  },
                ),
              ),
              spaceH20,
              Text(
                S.current.nguoi_thuc_hien,
                style: textNormalCustom(
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0.textScale(),
                ),
              ),
              spaceH8,

              ///chọn người thực hiện
              StreamBuilder<NguoiThucHienModel>(
                stream: widget.cubit.nguoiThucHienSubject,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChonNguoiThucHienScreen(
                            cubit: widget.cubit,
                            searchController: searchControler,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                            border: Border.all(
                              color: borderColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 14,
                              bottom: 14,
                              right: 30,
                            ),
                            child: Text(
                              snapshot.data?.dataAll() ?? '',
                              style: textNormalCustom(
                                color: snapshot.data?.dataAll() ==
                                        S.current.tim_theo_nguoi
                                    ? textBodyTime
                                    : titleItemEdit,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0.textScale(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 14,
                          top: 14,
                          bottom: 14,
                          child: GestureDetector(
                            onTap: () {
                              widget.cubit.nguoiThucHienSubject.add(
                                NguoiThucHienModel(
                                  id: '',
                                  hoten: S.current.tim_theo_nguoi,
                                  donVi: [],
                                  chucVu: [],
                                ),
                              );
                            },
                            child:
                                snapshot.data?.hoten != S.current.tim_theo_nguoi
                                    ? SvgPicture.asset(
                                        ImageAssets.icClose,
                                      )
                                    : const SizedBox(),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              spaceH20,
              Text(
                S.current.file_dinh_kem,
                style: textNormalCustom(
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0.textScale(),
                ),
              ),
              spaceH8,
              /// chọn file
              SelectFileBtn(
                hasMultiFile: false,
                isShowFile: false,
                replaceFile: true,
                allowedExtensions: [],
                textButton: S.current.them_file_dinh_kem,
                onChange: (files) {
                  if (files.first.lengthSync() > widget.cubit.maxSizeFile) {
                    showToast();
                  } else {
                    widget.cubit.uploadFilesWithFile(files.first).then(
                          (value) => nameFileSelect = value,
                        );
                  }
                },
              ),

              /// list file ở api
              StreamBuilder<String>(
                stream: widget.cubit.nameFile,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData && data != '') {
                    return FileFromAPIWidget(
                      downloadType: DomainDownloadType.CCVC,
                      url: '/$data',
                      data: data?.split('/').toList().last ?? '',
                      onTapDelete: () {
                        nameFileSelect = '';
                        widget.cubit.nameFile.sink.add('');
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              spaceH20,

              /// textfild note
              ItemTextFieldWidgetDSNV(
                initialValue: widget.todo?.note ?? '',
                title: S.current.ghi_chu,
                validator: (String? value) {},
                onChange: (value) {
                  note = value;
                },
                maxLine: 8,
                controller: noteControler,
              ),
              spaceH20,

              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: APP_DEVICE == DeviceType.MOBILE
                    ? EdgeInsets.zero
                    : const EdgeInsets.symmetric(horizontal: 100),
                child: DoubleButtonBottom(
                  isTablet: !isMobile(),
                  title1: S.current.dong,
                  title2: S.current.luu,
                  onClickLeft: () {
                    Navigator.pop(context);
                  },
                  onClickRight: () {
                    if (title.isEmpty) {
                      isShow.sink.add(true);
                      return;
                    }

                    if (widget.isCreate ?? true) {
                      widget.cubit.addTodo(
                        title: title,
                        fileName: nameFileSelect,
                        date: date,
                        note: note,
                      );
                    } else {
                      widget.cubit.editWork(
                        todo: widget.todo ?? TodoDSCVModel(),
                        filePathTodo: nameFileSelect,
                        title: title,
                        date: date,
                        note: note,
                        performer: widget.cubit.getDataNguoiThucHienModel.id,
                      );
                    }
                    Navigator.pop(context);
                    widget.cubit.editPop.sink.add(true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast() {
    final toast = FToast();
    toast.init(context);
    toast.showToast(
      child: ShowToast(
        text: S.current.dung_luong_toi_da_20,
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
