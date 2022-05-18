import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_van_ban_thanh_giong_noi/bloc/chuyen_van_ban_thanh_giong_noi_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_van_ban_thanh_giong_noi/ui/mobile/chuyen_van_ban_thanh_giong_noi_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChuyenVanBanThanhGiongNoiTablet extends StatefulWidget {
  const ChuyenVanBanThanhGiongNoiTablet({Key? key}) : super(key: key);

  @override
  _ChuyenVanBanThanhGiongNoiTabletState createState() =>
      _ChuyenVanBanThanhGiongNoiTabletState();
}

class _ChuyenVanBanThanhGiongNoiTabletState
    extends State<ChuyenVanBanThanhGiongNoiTablet> {
  ChuyenVanBanThanhGiongNoiCubit cubit = ChuyenVanBanThanhGiongNoiCubit();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(
        S.current.chuyen_van_ban_thanh_giong_noi,
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                btnListen(
                  title: S.current.tai_van_ban_len,
                  background:
                      AppTheme.getInstance().colorField().withOpacity(0.1),
                  textColor: AppTheme.getInstance().colorField(),
                  isIcon: true,
                  onTap: () {
                    cubit.readFile(textEditingController);
                  },
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colorNumberCellQLVB,
                  border: Border.all(color: borderColor.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: shadowContainerColor.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: textEditingController,
                  onChanged: (String value) {},
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  maxLines: null,
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            btnListen(
              title: S.current.doc_ngay,
              background: AppTheme.getInstance().colorField(),
              textColor: Colors.white,
              isIcon: false,
              onTap: () {},
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget btnListen({
    required String title,
    required Color background,
    required Color textColor,
    required bool isIcon,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: isIcon
            ? const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 14,
              )
            : const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 71.5,
              ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIcon)
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.icUpFile,
                    color: AppTheme.getInstance().colorField(),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              )
            else
              Container(),
            Text(
              title,
              style: textNormalCustom(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
