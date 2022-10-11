import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/ui/widget/widget_frame_conner.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PickImageDefault extends StatelessWidget {
  final Function() onTap;

  const PickImageDefault({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: borderColor,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Center(
              child: ImageAssets.svgAssets(
                ImageAssets.icUploadImage,
              ),
            ),
          ),
          const WidgetFrameConner(),
        ],
      ),
    );
  }
}
