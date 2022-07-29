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
import 'package:ccvc_mobile/tien_ich_module/widget/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

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
  BehaviorSubject<bool> isShow = BehaviorSubject.seeded(false);
  late String nameFileSelect;

  @override
  void initState() {
    // TODO: implement initState
    widget.cubit.dateChange =
        DateTime.parse(widget.todo?.finishDay ?? DateTime.now().toString())
            .formatApi;
    widget.cubit.titleChange = widget.todo?.label ?? '';
    widget.cubit.initDataNguoiTHucHienTextFild(widget.todo ?? TodoDSCVModel());
    super.initState();
    widget.cubit.nameFile.sink.add(widget.todo?.filePath ?? '');
    nameFileSelect = widget.todo?.filePath ?? '';
    widget.cubit.noteChange = widget.todo?.note ?? '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.cubit.disposs();
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      /// button dong va luu
      bottomWidget: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: APP_DEVICE == DeviceType.MOBILE
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 100),
        child: DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.luu,
          onClickLeft: () {
            Navigator.pop(context);
          },
          onClickRight: () {
            if ((widget.cubit.titleChange ?? '').isEmpty) {
              isShow.sink.add(true);
              return;
            }

            if (widget.isCreate ?? true) {
              widget.cubit.addTodo(
                fileName: nameFileSelect,
              );
            } else {
              widget.cubit.editWork(
                isDeleteFile: nameFileSelect.isEmpty,
                todo: widget.todo ?? TodoDSCVModel(),
                filePathTodo: nameFileSelect,
              );
            }

            Navigator.pop(context);
          },
        ),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
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
                          widget.cubit.titleChange = value;
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
                    value: widget.cubit.dateChange,
                    onSelectDate: (value) {
                      widget.cubit.dateChange = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  S.current.nguoi_thuc_hien,
                  style: textNormalCustom(
                    color: titleItemEdit,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.textScale(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

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
                                  color: titleItemEdit,
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
                              child: snapshot.data?.hoten !=
                                      S.current.tim_theo_nguoi
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
                const SizedBox(
                  height: 20,
                ),

                /// chọn file
                ButtonSelectFile(
                  isShowListFile: false,
                  title: S.current.them_tai_lieu_dinh_kem,
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
                const SizedBox(height: 20),

                /// textfild note
                ItemTextFieldWidgetDSNV(
                  initialValue: widget.todo?.note ?? '',
                  title: S.current.ghi_chu,
                  validator: (String? value) {},
                  onChange: (value) {
                    widget.cubit.noteChange = value;
                  },
                  maxLine: 8,
                  controller: noteControler,
                ),
                const SizedBox(height: 20),
              ],
            ),
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
        text: S.current.file_qua_30M,
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
