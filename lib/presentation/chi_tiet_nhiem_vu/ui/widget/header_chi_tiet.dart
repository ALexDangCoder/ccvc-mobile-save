import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_header.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HeaderChiTiet extends StatelessWidget {
  final List<ChiTietHeaderRow> row;

  const HeaderChiTiet({Key? key, required this.row}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: APP_DEVICE == DeviceType.TABLET
          ? const EdgeInsets.all(20)
          : const EdgeInsets.all(16),
      decoration: APP_DEVICE == DeviceType.TABLET
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: toDayColor.withOpacity(0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorBlack.withOpacity(0.05),
                  blurRadius: 10, // changes position of shadow
                ),
              ],
            )
          : const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: row
            .map(
              (e) => Container(
                margin: EdgeInsets.only(
                  bottom: 10.0.textScale(),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: e.key,
                              style: textNormalCustom(
                                color: unselectedLabelColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0.textScale(),
                              ),
                            ),
                            if (e.isNote)
                              TextSpan(text: ' *', style: textNormalCustom(
                                color: Colors.red,
                                  fontSize: 14.0.textScale(),
                                ),
                              )
                            else
                              const TextSpan(text: ''),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0.textScale(),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        e.value,
                        style: textNormalCustom(
                          color: textTitle,
                          fontSize: 16.0.textScale(),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
