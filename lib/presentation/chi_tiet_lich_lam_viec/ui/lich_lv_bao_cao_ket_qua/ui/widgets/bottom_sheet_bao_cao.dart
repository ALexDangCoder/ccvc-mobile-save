import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/tinh_trang_bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BaoCaoBottomSheet extends StatefulWidget {
  final List<TinhTrangBaoCaoModel> listTinhTrangBaoCao;
  final String id;
  final BaoCaoKetQuaCubit cubit;
  final String scheduleId;
  final bool isEdit;

  const BaoCaoBottomSheet({
    Key? key,
    required this.listTinhTrangBaoCao,
    required this.cubit,
    this.id = '',
    required this.scheduleId,
    this.isEdit = false,
  }) : super(key: key);

  @override
  _ChinhSuaBaoCaoBottomSheetState createState() =>
      _ChinhSuaBaoCaoBottomSheetState();
}

class _ChinhSuaBaoCaoBottomSheetState extends State<BaoCaoBottomSheet> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();

  String? errorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      controller.text = widget.cubit.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state is SuccessChiTietLichLamViecState) {
          Navigator.pop(context, true);
        }
      },
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        padding: EdgeInsets.only(
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    S.current.trang_thai,
                    style: tokenDetailAmount(
                      fontSize: 14.0.textScale(),
                      color: titleItemEdit,
                    ),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(color: canceledColor),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CoolDropDown(
                showSelectedDecoration: false,
                useCustomHintColors: true,
                selectedIcon: SvgPicture.asset(
                  ImageAssets.icV,
                  color: AppTheme.getInstance().colorField(),
                ),
                initData: widget.cubit.tinhTrangBaoCaoModel?.displayName ?? '',
                placeHoder: S.current.chon_trang_thai,
                listData: widget.listTinhTrangBaoCao
                    .map((e) => e.displayName ?? '')
                    .toList(),
                onChange: (index) {
                  setState(() {
                    errorText = null;
                  });
                  widget.cubit.reportStatusId =
                      widget.listTinhTrangBaoCao[index].id ?? '';
                },
              ),
              Text(
                errorText ?? '',
                style: textNormalCustom(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: canceledColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlockTextView(
                title: S.current.noidung,
                contentController: controller,
                formKey: globalKey,
                isRequired: false,
              ),
              const SizedBox(
                height: 24,
              ),
              ButtonSelectFile(
                removeFileApi: (int index) {},
                isShowFile: false,
                title: S.current.tai_lieu_dinh_kem,
                onChange: (
                  files,
                ) {
                  if (widget.cubit.files
                      .map((e) => e.path)
                      .contains(files.first.path)) {
                    MessageConfig.show(
                        title: S.current.file_da_ton_tai,
                        messState: MessState.error);
                    return;
                  }
                  widget.cubit.files.addAll(files);
                  widget.cubit.updateFilePicker.sink.add(true);
                },
                files: widget.cubit.files.toList(),
              ),
              StreamBuilder(
                  stream: widget.cubit.deleteFileInit.stream,
                  builder: (context, snapshot) {
                    return Column(
                      children: widget.cubit.fileInit
                          .map((e) => itemListFile(
                              onTap: () {
                                widget.cubit.fileInit.remove(e);
                                widget.cubit.fileDelete.add(e);
                                widget.cubit.deleteFileInit.sink.add(true);
                              },
                              fileTxt: e.name ?? ''))
                          .toList(),
                    );
                  }),
              StreamBuilder(
                  stream: widget.cubit.updateFilePicker.stream,
                  builder: (context, snapshot) {
                    return Column(
                      children: widget.cubit.files
                          .map(
                            (e) => itemListFile(
                                onTap: () {
                                  widget.cubit.files.remove(e);
                                  widget.cubit.updateFilePicker.sink.add(true);
                                },
                                fileTxt: e.path.convertNameFile(),
                                lengthFile: e.lengthSync().getFileSize(2)),
                          )
                          .toList(),
                    );
                  }),
              Align(alignment: Alignment.bottomCenter, child: navigatorBar())
            ],
          ),
        ),
      ),
    );
  }

  Widget itemListFile({
    required String fileTxt,
    required Function onTap,
    String? lengthFile,
    double? spacingFile,
  }) {
    return Container(
      margin: EdgeInsets.only(top: spacingFile ?? 16.0.textScale()),
      padding: EdgeInsets.all(16.0.textScale()),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0.textScale()),
        border: Border.all(color: bgDropDown),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileTxt,
                  style: textNormalCustom(
                    color: color5A8DEE,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.textScale(),
                  ),
                ),
                Visibility(
                  visible: lengthFile != null,
                  child: Text(
                    '$lengthFile',
                    style: textNormal(redChart, 14),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: SvgPicture.asset(ImageAssets.icDelete),
          ),
        ],
      ),
    );
  }

  Widget navigatorBar() {
    return isMobile()
        ? SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DoubleButtonBottom(
                onClickRight: () {
                  btnThem();
                },
                title2: widget.isEdit ? S.current.luu : S.current.them,
                title1: S.current.dong,
                onClickLeft: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 142,
                  child: ButtonBottom(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: S.current.dong,
                  ),
                ),
                spaceW20,
                SizedBox(
                  width: 142,
                  child: ButtonBottom(
                    customColor: true,
                    onPressed: () {
                      btnThem();
                    },
                    text: widget.isEdit ? S.current.them : S.current.luu,
                  ),
                ),
              ],
            ),
          );
  }

  void btnThem() {
    if (!widget.cubit.checkLenghtFile()) {
      MessageConfig.show(
        title: S.current.dung_luong_toi_da_30,
        messState: MessState.error,
      );
      return;
    }
    if (widget.cubit.reportStatusId.isNotEmpty) {
      if (widget.isEdit) {
        widget.cubit.editScheduleReport(
          id: widget.id,
          scheduleId: widget.scheduleId,
          content: controller.text.trim(),
        );
      } else {
        widget.cubit.createScheduleReport(widget.scheduleId, controller.text);
      }
    } else {
      setState(() {
        errorText = S.current.vui_long_chon;
      });
    }
  }
}
