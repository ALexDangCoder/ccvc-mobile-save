import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/bao_chi_mang_xa_hoi_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/lich_hop_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/lich_lam_viec_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/search_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/tong_hop_nv_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/tu_khoa_pho_bien_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/van_ban_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/y_kien_nguoi_dan_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fake_data.dart';

class SearchScreenTablet extends StatefulWidget {
  const SearchScreenTablet({Key? key}) : super(key: key);

  @override
  _SearchScreenTabletState createState() => _SearchScreenTabletState();
}

class _SearchScreenTabletState extends State<SearchScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          S.current.tim_kiem,
          style: textNormalCustom(
            fontSize: 18.0.textScale(),
            fontWeight: FontWeight.w500,
            color: color3D5586,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: colorA2AEBD,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0.textScale()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0.textScale()),
              child: const SearchWidget(),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                color: colorEEF3FF,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0.textScale(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.tu_khoa_pho_bien,
                            style: textNormalCustom(
                              color: colorA2AEBD,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0.textScale(),
                            ),
                          ),
                          SizedBox(
                            height: 16.0.textScale(),
                          ),
                          TuKhoaPhoBienWidget(listKeyWord: fakeTuKhoaThongDung),
                          SizedBox(
                            height: 10.0.textScale(),
                          ),
                        ],
                      ),
                    ),
                    VanBanWidget(
                      time: vanBanDiModel.time,
                      listDocument: FakeData.documentList,
                    ),
                    TongHopNVWidget(
                      time: tongHopNVModel.time,
                      listData: tongHopNVModel.listData,
                    ),
                    YKienNguoiDanWidget(
                      time: yKienNguoiDan.time,
                      listData: yKienNguoiDan.listDocument,
                    ),
                    LichLamViecWidget(
                      time: lichLamViec.time,
                      listData: lichLamViec.listData,
                    ),
                    LichHopWidget(
                      time: lichHop.time,
                      listData: lichHop.listData,
                    ),
                    BaoChiMangXaHoiWidget(
                      time: baoChiMangXaHoi.time,
                      listData: baoChiMangXaHoi.listData,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
