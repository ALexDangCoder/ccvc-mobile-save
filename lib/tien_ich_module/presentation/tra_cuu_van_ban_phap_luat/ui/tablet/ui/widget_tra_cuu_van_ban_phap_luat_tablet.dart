import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/tra_cuu_van_ban_phap_luat_model.dart';
import 'package:flutter/material.dart';

class WidgetTraCuuVanBanPhapLuatTablet extends StatelessWidget {
  final TraCuuVanBanPhapLuatModel data;
  final int index;

  const WidgetTraCuuVanBanPhapLuatTablet({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorE2E8F0),
          borderRadius: BorderRadius.circular(10.0),
          color: colorFFFFFF,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      '${index.toString().padLeft(2, '0')}.',
                      style: textNormalCustom(
                        fontSize: 16.0,
                        color: color586B8B,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => WebViewScreen(
                              title: '',
                              url: data.url ?? '',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        data.title ?? '',
                        softWrap: true,
                        style: titleAppbar(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    '${S.current.ban_hanh}: ${data.day}',
                    style: textNormalCustom(
                      color: colorA2AEBD,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
