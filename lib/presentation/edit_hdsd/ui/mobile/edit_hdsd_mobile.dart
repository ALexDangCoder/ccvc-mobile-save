import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/hoi_dap/hoi_dap.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_hdsd/ui/mobile/detail_hdsd.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class EditHDSDScreen extends StatefulWidget {
  final HoiDap hoiDap;
  final int index;

  const EditHDSDScreen({Key? key, required this.hoiDap, required this.index})
      : super(key: key);

  @override
  _EditHDSDScreenState createState() => _EditHDSDScreenState();
}

class _EditHDSDScreenState extends State<EditHDSDScreen> {
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
    chuDeController.text = widget.hoiDap.chuDe ?? '';
    loaiHDController.text = widget.hoiDap.loaiHDSD ?? '';
    danhSachController.text = widget.hoiDap.danhSach ?? '';
    noiDungController.text = widget.hoiDap.noiDung ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> hoiDaps = widget.hoiDap.getInfoToMap();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chinh_sua_hdsd),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Column(
              children: [
                Form(
                  key: formKeyChuDe,
                  child: InputInfoUserWidget(
                    title: hoiDaps.keys.elementAt(1),
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
                    title: hoiDaps.keys.elementAt(2),
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
                    title: hoiDaps.keys.elementAt(3),
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
                spaceH20,
                BlockTextView(
                  title: hoiDaps.keys.elementAt(4),
                  contentController: noiDungController,
                  formKey: formKeyNoiDung,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 17, right: 17),
        child: DoubleButtonBottom(
          onClickRight: () {},
          title2: S.current.cap_nhat,
          onClickLeft: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailHDSDScreen(),
              ),
            );
          },
          title1: S.current.xem_truoc,
        ),
      ),
    );
  }
}
