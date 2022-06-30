import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

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
            children: [
              selectFile(),
              const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            listFileFromApi()
          ],
        ),
      ),
    );
  }

  Widget selectFile() => ButtonSelectFile(
        title: S.current.them_tai_lieu_cuoc_hop,
        onChange: (List<File> files,) {},
      );

  Widget listFileFromApi() => StreamBuilder<ChiTietLichHopModel>(
        stream: widget.cubit.chiTietLichHopSubject,
        builder: (context, snapshot) {
          final data =
              snapshot.data?.fileData!.map((e) => e.name).toList() ?? [];
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: FileFromAPIWidget(
                  data: data[index] ?? '',
                  onTapDelete: () {},
                ),
              );
            },
          );
        },
      );
}

class FileFromAPIWidget extends StatelessWidget {
  final Function onTapDelete;
  final String data;

  const FileFromAPIWidget({Key? key, required this.onTapDelete, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgDropDown.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: bgDropDown),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              data,
              style: textNormalCustom(
                color: choXuLyColor,
                fontWeight: FontWeight.w400,
                fontSize: 14.0.textScale(),
              ),
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
