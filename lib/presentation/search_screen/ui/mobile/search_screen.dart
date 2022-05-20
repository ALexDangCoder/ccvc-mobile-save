import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/search_screen/bloc/search_cubit.dart';
import 'package:ccvc_mobile/presentation/search_screen/fake_data.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/bao_chi_mang_xa_hoi_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/lich_hop_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/lich_lam_viec_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/search_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/tong_hop_nv_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/tu_khoa_pho_bien_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/van_ban_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/widget/y_kien_nguoi_dan_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchCubit searchCubit = SearchCubit();

  @override
  void initState() {
    super.initState();
    searchCubit.configWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          S.current.tim_kiem,
          style: textNormalCustom(
            fontSize: 18,
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
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.tu_khoa_pho_bien,
                            style: textNormalCustom(
                              color: colorA2AEBD,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const TuKhoaPhoBienWidget(
                              listKeyWord: fakeTuKhoaThongDung,),
                          const SizedBox(
                            height: 10,
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
