import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:flutter/material.dart';

class YKienBottomSheet extends StatefulWidget {
  final String id;

  const YKienBottomSheet({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ChinhSuaBaoCaoBottomSheetState createState() =>
      _ChinhSuaBaoCaoBottomSheetState();
}

class _ChinhSuaBaoCaoBottomSheetState extends State<YKienBottomSheet> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlockTextView(
                title: S.current.noi_dung,
                contentController: controller,
                formKey: globalKey,
                isRequired: false,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonCustomBottom(
                      title: S.current.dong,
                      isColorBlue: false,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ButtonCustomBottom(
                      title: S.current.them,
                      isColorBlue: true,
                      onPressed: () async {
                        await chiTietLichLamViecCubit
                            .themYKien(
                          content: controller.text,
                          phienHopId: null,
                          scheduleId: widget.id,
                          scheduleOpinionId: null,
                        )
                            .then((value) {
                          MessageConfig.show(
                            title: S.current.cho_y_kien_thanh_cong,
                          );
                        }).onError((error, stackTrace) {
                          MessageConfig.show(
                            title: S.current.cho_y_kien_that_bai,
                          );
                        });
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
