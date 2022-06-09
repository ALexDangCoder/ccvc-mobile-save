import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetItemThongKe extends StatelessWidget {
  final List<ThongKeDiemDanhCaNhanModel> listItem;

  const WidgetItemThongKe({Key? key, required this.listItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listItem.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              if (index != 0)
                Padding(
                  padding: const EdgeInsets.only(bottom:16.0 ),
                  child: SizedBox(
                    child: Divider(
                      color: AppTheme.getInstance().lineColor(),
                      height: 1,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      listItem[index].title ?? '',
                      style: textNormalCustom(
                        color: color667793,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      listItem[index].number.toString(),
                      style: textNormalCustom(
                        color: color667793,
                        fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
