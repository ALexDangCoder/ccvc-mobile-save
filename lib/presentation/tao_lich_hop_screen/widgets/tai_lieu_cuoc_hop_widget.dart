import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/select_file/select_file.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';

class TaiLieuCuocHopWidget extends StatelessWidget {
  final TaoLichHopCubit cubit;

  const TaiLieuCuocHopWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                isMobile() ? S.current.tai_lieu : S.current.tai_lieu_dinh_kem,
                style: textNormalCustom(
                  color: titleColumn,
                  fontSize: 16.0.textScale(),
                ),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 0.0.textScale(space: 10),
          ),
          SelectFileBtn(
            allowedExtensions: const [
              'doc',
              'docx',
              'xlsx',
              'png',
              'jpeg',
              'jpg',
              'pdf',
            ],
            onChange: (files) {
              cubit.listTaiLieu = files;
            },
            textButton: S.current.them_tai_lieu_cuoc_hop,
            iconButton: ImageAssets.ic_file_meeting,
          ),
        ],
      ),
    );
  }
}
