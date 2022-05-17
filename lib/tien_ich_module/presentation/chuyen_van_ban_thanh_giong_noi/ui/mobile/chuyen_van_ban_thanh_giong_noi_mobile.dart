import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_van_ban_thanh_giong_noi/bloc/chuyen_van_ban_thanh_giong_noi_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChuyenVanBanThanhGiongNoi extends StatefulWidget {
  const ChuyenVanBanThanhGiongNoi({Key? key}) : super(key: key);

  @override
  _ChuyenVanBanThanhGiongNoiState createState() =>
      _ChuyenVanBanThanhGiongNoiState();
}

class _ChuyenVanBanThanhGiongNoiState extends State<ChuyenVanBanThanhGiongNoi> {
  ChuyenVanBanThanhGiongNoiCubit cubit = ChuyenVanBanThanhGiongNoiCubit();
  List<VoidTone> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = cubit.dataDrop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.chuyen_van_ban_thanh_giong_noi,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  onChanged: (String value) {
                    cubit.text = value;
                  },
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
                  maxLines: 10,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Giọng nói',
              style: tokenDetailAmount(
                fontSize: 16.0.textScale(),
                color: dateColor,
              ),
            ),
            const SizedBox(height: 10),
            CoolDropDown(
              initData: 'Nữ miền Bắc (Liên)',
              listData: data.map((e) => e.text ?? '').toList(),
              onChange: (vl) {
                final List<String> dataSelect =
                    data.map((e) => e.code ?? '').toList();
                cubit.voidTone = dataSelect[vl];
              },
            ),
            const SizedBox(height: 24),
            btnListen(
              onTap: () {
                cubit.chuyenVBSangGiongNoi();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget btnListen({required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().colorField(),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.current.doc_ngay,
              style: textNormalCustom(
                fontSize: 14,
                color: Colors.white,
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
