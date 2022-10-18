import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html_editor_enhanced/html_editor.dart';

final keyEditKetLuanHop = GlobalKey<_EditKetLuanHopScreenState>();

class EditKetLuanHopScreen extends StatefulWidget {
  final String htmlText;

  const EditKetLuanHopScreen({Key? key, required this.htmlText})
      : super(key: key);

  @override
  _EditKetLuanHopScreenState createState() => _EditKetLuanHopScreenState();
}

class _EditKetLuanHopScreenState extends State<EditKetLuanHopScreen> {
  final HtmlEditorController controller = HtmlEditorController();

  @override
  void initState() {
    super.initState();
    // widget.cubit.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AqiColor,
            size: 20,
          ),
        ),
        title: S.current.sua_bien_ban_ket_luan_hop,
        actions: [
          IconButton(
            onPressed: () async {
              final getHtml =
                  await controller.getText();
              Navigator.pop(context, getHtml.removeSpaceHtml);
            },
            icon: SvgPicture.asset(
              ImageAssets.icTickCircle,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: SingleChildScrollView(
            child: HtmlEditor(
              controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                initialText: widget.htmlText,
              ),
              otherOptions: OtherOptions(
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
