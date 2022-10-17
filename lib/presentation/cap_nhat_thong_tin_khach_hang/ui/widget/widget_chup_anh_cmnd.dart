import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/ui/widget/widget_frame_conner.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class WidgetChupAnhCMND extends StatefulWidget {
  final String title;
  final Function(List<File>) onChange;

  const WidgetChupAnhCMND({
    Key? key,
    required this.title, required this.onChange,
  }) : super(key: key);

  @override
  _WidgetChupAnhCMNDState createState() => _WidgetChupAnhCMNDState();
}

class _WidgetChupAnhCMNDState extends State<WidgetChupAnhCMND> {
  final GlobalKey _cropKey = GlobalKey();
  final GlobalKey _previewKey = GlobalKey();
  File? _capturedImage;
  late List<CameraDescription> _cameras;

  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _getCameras();
  }

  Future<void> _getCameras() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    await _controller?.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  String _randomNonceString([int length = 32]) {
    final random = math.Random();

    final charCodes = List<int>.generate(length, (_) {
      late int codeUnit;

      switch (random.nextInt(3)) {
        case 0:
          codeUnit = random.nextInt(10) + 48;
          break;
        case 1:
          codeUnit = random.nextInt(26) + 65;
          break;
        case 2:
          codeUnit = random.nextInt(26) + 97;
          break;
      }

      return codeUnit;
    });

    return String.fromCharCodes(charCodes);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Future<void> takePhoto() async {
    final XFile file = await _controller!.takePicture();
    await _controller?.pausePreview();
    _capturedImage = File(file.path);
    final bytes = await _capturedImage!.readAsBytes();
    final src = img.decodeImage(bytes);
    final tileWidth =
        (src?.width ?? 1) / (_previewKey.currentContext?.size?.width ?? 1);
    final tileHeight =
        (src?.height ?? 1) / (_previewKey.currentContext?.size?.height ?? 1);
    final box = _cropKey.currentContext!.findRenderObject() as RenderBox;
    final previewBox =
        _previewKey.currentContext!.findRenderObject() as RenderBox;
    final offsetX = box.localToGlobal(Offset.zero).dx;
    final offsetBoxY = box.localToGlobal(Offset.zero).dy;
    final offsetPreviewY = previewBox.localToGlobal(Offset.zero).dy;
    final width = box.size.width;
    final height = box.size.height;
    final destImage = img.copyCrop(
      src!,
      (offsetX * tileWidth).toInt(),
      ((offsetBoxY - offsetPreviewY) * tileHeight).toInt(),
      (width * tileWidth).toInt(),
      (height * tileHeight).toInt(),
    );
    final jpg = img.encodeJpg(destImage);
    final Directory dir = await getTemporaryDirectory();
    final String path = '${dir.path}/${_randomNonceString()}.png';
    _capturedImage = await File(path).writeAsBytes(jpg);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        widget.title,
      ),
      body: Stack(
        children: [
          if (_controller != null)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CameraPreview(
                _controller!,
                key: _previewKey,
              ),
            ),
          Column(
            children: [
              Container(
                color: AppTheme.getInstance().backGroundColor(),
                height: 16,
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.width - 32)  / 1.8,
                child: Row(
                  children: [
                    Container(
                      color: AppTheme.getInstance().backGroundColor(),
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: _capturedImage != null
                            ? SizedBox(
                                child: Image.file(
                                  _capturedImage!,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : WidgetFrameConner(
                                key: _cropKey,
                              ),
                      ),
                    ),
                    Container(
                      color: AppTheme.getInstance().backGroundColor(),
                      width: 16,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: AppTheme.getInstance().backGroundColor(),
                  child: Text(
                    _capturedImage == null
                        ? S.current.bam_chup
                        : S.current.bam_chon,
                    style: textNormalCustom(
                      color: color3D5586,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 16.0, left: 16.0),
        child: _capturedImage == null
            ? SolidButton(
                isColorBlue: true,
                mainAxisAlignment: MainAxisAlignment.center,
                text: S.current.chup,
                urlIcon: ImageAssets.icCameraWhite,
                onTap: () {
                  setState(() {});
                  takePhoto();
                },
              )
            : DoubleButtonBottom(
                onClickLeft: () {
                  _capturedImage = null;
                  _controller?.resumePreview();
                  setState(() {});
                },
                onClickRight: () {
                  if(_capturedImage!=null) {
                    widget.onChange([_capturedImage!]);
                    Navigator.pop(context);
                  }
                },
                title1: S.current.thu_lai,
                title2: S.current.chon,
              ),
      ),
    );
  }
}
