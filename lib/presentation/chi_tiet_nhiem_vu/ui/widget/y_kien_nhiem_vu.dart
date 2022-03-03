

import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/handing_comment.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/send_comment_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:flutter/material.dart';

import 'expand_only_nhiem_vu.dart';

class YKienNhiemVuWidget extends StatelessWidget {

  final ChiTietNVCubit cubit;

  const YKienNhiemVuWidget({Key? key,  required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ExpandOnlyNhiemVu(
      name: S.current.y_kien_xu_ly,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.textScale(space: 4),
        ),
        child:Column(
          children: [
            const SizedBox(height: 17.0,),
            SendCommentWidget(
              isReComment: true,
              onSendComment:(text, listFile){

              },
            ),
            const SizedBox(height: 24.0,),
            ButtonSelectFile(
              titleColor: backgroundColorApp,
              isIcon: false,
              background: attackFile,
              title: S.current.dinh_kem,
              onChange: (List<File> files) {

              }, files: [],
            ),
            CommentWidget(
              object: handingComment,
            ),
          ],
        )
      ),
    );
  }
}
