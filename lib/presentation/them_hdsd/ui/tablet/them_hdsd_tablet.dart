import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/presentation/edit_hdsd/ui/widget/double_button_edit_hdsd.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class ThemHDSDScreenTablet extends StatefulWidget {
  const ThemHDSDScreenTablet({
    Key? key,
  }) : super(key: key);

  @override
  _ThemHDSDScreenTabletState createState() => _ThemHDSDScreenTabletState();
}

class _ThemHDSDScreenTabletState extends State<ThemHDSDScreenTablet> {
  GlobalKey<FormState> formKeyChuDe = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyLoaiHD = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyDanhSach = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController chuDeController = TextEditingController();
  TextEditingController loaiHDController = TextEditingController();
  TextEditingController danhSachController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              Column(
                children: [
                  Form(
                    key: formKeyChuDe,
                    child: InputInfoUserWidget(
                      title: S.current.chu_de_hdsd,
                      child: TextFormFieldWidget(
                        controller: chuDeController,
                        isEnabled: true,
                        onChange: (value) {
                          formKeyChuDe.currentState?.validate();
                        },
                        validator: (value) {
                          return value?.checkNull();
                        },
                      ),
                    ),
                  ),
                  Form(
                    key: formKeyLoaiHD,
                    child: InputInfoUserWidget(
                      title: S.current.loai_hdsd,
                      child: TextFormFieldWidget(
                        controller: loaiHDController,
                        isEnabled: true,
                        onChange: (value) {
                          formKeyLoaiHD.currentState?.validate();
                        },
                        validator: (value) {
                          return value?.checkNull();
                        },
                      ),
                    ),
                  ),
                  Form(
                    key: formKeyDanhSach,
                    child: InputInfoUserWidget(
                      title: S.current.danhSach,
                      child: TextFormFieldWidget(
                        controller: danhSachController,
                        isEnabled: true,
                        onChange: (value) {
                          formKeyDanhSach.currentState?.validate();
                        },
                        validator: (value) {
                          return value?.checkNull();
                        },
                      ),
                    ),
                  ),
                  spaceH24,
                  BlockTextView(
                    title: S.current.noi_dung,
                    contentController: noiDungController,
                    formKey: formKeyNoiDung,
                  ),
                ],
              ),
              spaceH36,
              DoubleButtonEditHDSDScreen(
                onPressed2: () {
                  if (formKeyChuDe.currentState!.validate() &&
                      formKeyLoaiHD.currentState!.validate() &&
                      formKeyDanhSach.currentState!.validate() &&
                      formKeyNoiDung.currentState!.validate()) {
                  } else {}
                },
                title2: S.current.them_moi,
                onPressed1: () {},
                title1: S.current.xem_truoc,
              )
            ],
          ),
        ),
      ),
    );
  }
}
