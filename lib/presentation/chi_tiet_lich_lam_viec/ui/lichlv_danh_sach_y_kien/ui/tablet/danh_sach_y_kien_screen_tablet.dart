import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/tablet/item_y_kiem_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DanhSachYKienTabletScreen extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  const DanhSachYKienTabletScreen({Key? key,required this.cubit}) : super(key: key);

  @override
  _DanhSachYKienTabletScreenState createState() =>
      _DanhSachYKienTabletScreenState();
}

class _DanhSachYKienTabletScreenState extends State<DanhSachYKienTabletScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.danh_sach_y_kien,
                  style: titleText(color: textTitle),
                ),
                IconButton(
                  icon: SvgPicture.asset(ImageAssets.icClose),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: StreamBuilder<List<YKienModel>>(
                    stream: widget.cubit.listYKien,
                    builder: (context, snapshot) {
                      final listData = snapshot.data ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                          return ItemYKienTablet(
                            yKienModel: listData[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
