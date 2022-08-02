import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChonNhomDialog extends StatefulWidget {
  const ChonNhomDialog({Key? key, required this.cubit, this.ibTablet = false})
      : super(key: key);
  final ChiaSeBaoCaoCubit cubit;
  final bool ibTablet;

  @override
  _ChonNhomDialogState createState() => _ChonNhomDialogState();
}

class _ChonNhomDialogState extends State<ChonNhomDialog> {

  @override
  void initState() {
    super.initState();
    widget.cubit.searchGroup('');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: widget.ibTablet ? 450.h : 350.h,
      width: widget.ibTablet ? 450.w : null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: cellColorborder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldValidator(
            hintText: S.current.tim_kiem,
            onChange: (value) {
              widget.cubit.searchGroup(value);
            },
          ),
          spaceH8,
          StreamBuilder<List<String>>(
              stream: widget.cubit.searchGroupStream,
              builder: (context, snapshot) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          itemSelect(
                            snapshot.data?[index] ?? '',
                            widget.cubit.checkSelectGroup(
                              snapshot.data?[index] ?? '',
                            ),
                          ),
                          spaceH5,
                        ],
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget itemSelect(String title, bool isSelect) {
    return InkWell(
      onTap: () {
        if (!isSelect) {
          widget.cubit.themNhom(title);
          Navigator.pop(context);
        }
      },
      child: Container(
        width: double.infinity,
        color: isSelect ? secondTxtColor.withOpacity(0.5) : Colors.transparent,
        padding: EdgeInsets.only(
          left: 10.w,
          top: 12.h,
          bottom: 12.h,
        ),
        child: Text(
          title,
          style: textNormalCustom(
            color: color3D5586,
            fontSize: 14.0.textScale(),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
