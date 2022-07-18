import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaiLieuWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const TaiLieuWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _TaiLieuWidgetState createState() => _TaiLieuWidgetState();
}

class _TaiLieuWidgetState extends State<TaiLieuWidget> {
  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        title: S.current.tai_lieu,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectFile(),
              listFileFromApi(),
            ],
          ),
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60, left: 13.5),
        child: Column(
          children: [
            selectFile(),
            listFileFromApi(),
          ],
        ),
      ),
    );
  }

  Widget selectFile() => ButtonSelectFile(
        isShowFile: false,
        title: S.current.them_tai_lieu_cuoc_hop,
        onChange: (List<File> files) {
          if (files.first.lengthSync() > widget.cubit.maxSizeFile30) {
            showToast();
          } else {
            widget.cubit.postFileTaoLichHop(
              files: files,
              entityId: widget.cubit.idCuocHop,
            );
          }
        },
        removeFileApi: (int index) {},
      );

  Widget listFileFromApi() => StreamBuilder<ChiTietLichHopModel>(
        stream: widget.cubit.chiTietLichHopSubject,
        builder: (context, snapshot) {
          final data = snapshot.data?.fileData ?? [];
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final dataIndex = data[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: FileFromAPIWidget(
                  data: dataIndex.name ?? '',
                  onTapDelete: () {
                    widget.cubit.deleteFileHop(id: dataIndex.id ?? '');
                  },
                ),
              );
            },
          );
        },
      );

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

class FileFromAPIWidget extends StatelessWidget {
  final Function onTapDelete;
  final String data;
  final String? lengthFile;
  const FileFromAPIWidget(
      {Key? key,
      required this.onTapDelete,
      required this.data,
      this.lengthFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0.textScale()),
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
                  data,
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
              onTapDelete();
            },
            child: SvgPicture.asset(ImageAssets.icDelete),
          ),
        ],
      ),
    );
  }
}
