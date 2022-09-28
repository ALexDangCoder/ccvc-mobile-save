import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class ViewTodoDetail extends StatefulWidget {
  final Function()? onEdit;
  final bool canEdit;
  final TodoDSCVModel todoModel;
  final DanhSachCongViecTienIchCubit cubit;

  const ViewTodoDetail({
    Key? key,
    this.onEdit,
    required this.canEdit,
    required this.todoModel,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ViewTodoDetail> createState() => _ViewTodoDetailState();
}

class _ViewTodoDetailState extends State<ViewTodoDetail> {
  NguoiThucHienModel? nguoiThucHien;
  String fileName = '';

  @override
  void initState() {
    final slitRes = widget.todoModel.filePath?.split('/') ?? [];
    if (slitRes.isNotEmpty) {
      fileName = slitRes.last;
    }
    getNguoiThucHien();
    super.initState();
  }

  Future<void> getNguoiThucHien() async {
    nguoiThucHien =
        await widget.cubit.getNguoiThucHien(widget.todoModel.performer ?? '');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile() ? 0 : 16,
      ),
      child: Column(
        children: [
          spaceH20,
          rowData(
            key: S.current.tieu_de,
            value: widget.todoModel.label ?? '',
          ),
          spaceH20,
          rowData(
            key: S.current.ngay_hoan_thanh,
            value: DateTime.tryParse(widget.todoModel.finishDay ?? '')
                    ?.toStringWithListFormat ??
                '',
          ),
          spaceH20,
          rowData(
            key: S.current.nguoi_thuc_hien,
            value: nguoiThucHien?.tenChucVuDonVi() ?? '',
          ),
          spaceH20,
          rowFile(
            name: fileName,
            path: '/${widget.todoModel.filePath}',
          ),
          spaceH20,
          rowData(
            key: S.current.ghi_chu,
            value: widget.todoModel.note ?? '',
          ),
          spaceH20,
          if (widget.canEdit)
            DoubleButtonBottom(
              onPressed1: () {
                Navigator.of(context).pop();
              },
              title1: S.current.dong,
              title2: S.current.chinh_sua,
              onPressed2: () {
                widget.onEdit?.call();
                widget.cubit.editPop.sink.add(false);
                widget.cubit.editPop.listen((value) {
                  if (value) {
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          if (!widget.canEdit)
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                height: 44,
                width: 142,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.getInstance().colorField().withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    S.current.dong,
                    style: textNormalCustom(
                      fontSize: 16,
                      color: AppTheme.getInstance().colorField(),
                    ),
                  ),
                ),
              ),
            ),
          spaceH32,
        ],
      ),
    );
  }

  Widget rowData({required String key, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isMobile() ? 2 : 3,
          child: Text(
            key,
            style: textNormalCustom(
              color: textTitle,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        spaceW12,
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: textNormalCustom(
              color: textTitle,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget rowFile({required String name, required String path}) {
    return Row(
      children: [
        Expanded(
          flex: isMobile() ? 2 : 3,
          child: Text(
            S.current.file_dinh_kem,
            style: textNormalCustom(
              color: textTitle,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        spaceW12,
        Expanded(
          flex: 5,
          child: GestureDetector(
            onTap: () {
              saveFile(
                fileName: name,
                url: path,
                downloadType: DomainDownloadType.CCVC,
              );
            },
            child: Text(
              name,
              style: textNormalCustom(
                color: AppTheme.getInstance().colorField(),
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
