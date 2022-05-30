import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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
              ButtonSelectFile(
                title: S.current.them_tai_lieu_cuoc_hop,
                onChange: (List<File> files) {},
              ),
              const SizedBox(height: 16),
              StreamBuilder<ChiTietLichHopModel>(
                stream: widget.cubit.chiTietLichLamViecSubject,
                builder: (context, snapshot) {
                  final data =
                      snapshot.data?.fileData?.map((e) => e.name).toList() ??
                          [];
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListFileFromAPI(
                            data: data[index] ?? '',
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60, left: 13.5),
        child: Column(
          children: [
            ButtonSelectFile(
              title: S.current.them_tai_lieu_cuoc_hop,
              onChange: (files) {},
            ),
            const SizedBox(height: 16),
            StreamBuilder<ChiTietLichHopModel>(
              stream: widget.cubit.chiTietLichLamViecSubject,
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
                      child: ListFileFromAPI(
                        data: data[index] ?? '',
                        onTap: () {},
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListFileFromAPI extends StatelessWidget {
  final Function onTap;
  final String data;

  const ListFileFromAPI({Key? key, required this.onTap, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            data,
            style: textNormalCustom(
              color: color5A8DEE,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: SvgPicture.asset(ImageAssets.icDelete),
        ),
      ],
    );
  }
}
