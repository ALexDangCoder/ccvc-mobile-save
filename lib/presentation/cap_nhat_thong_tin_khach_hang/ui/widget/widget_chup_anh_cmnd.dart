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
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class WidgetChupAnhCMND extends StatefulWidget {
  final String title;

  const WidgetChupAnhCMND({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _WidgetChupAnhCMNDState createState() => _WidgetChupAnhCMNDState();
}

class _WidgetChupAnhCMNDState extends State<WidgetChupAnhCMND>
    with WidgetsBindingObserver {
  final GlobalKey _cropKey = GlobalKey();
  final GlobalKey _previewKey = GlobalKey();
  File? _capturedImage;
  late List<CameraDescription> _cameras;
  bool showFocusCircle = false;
  bool isTakePhoto = false;
  double x = 0;
  double y = 0;
  late final FToast toast;

  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    toast = FToast();
    toast.init(context);
    WidgetsBinding.instance?.addObserver(this);
    _getCameras();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = _controller;
    if (oldController != null) {
      _controller = null;
      await oldController.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup:
          Platform.isIOS ? ImageFormatGroup.bgra8888 : ImageFormatGroup.yuv420,
    );
    _controller = cameraController;
    // If the controller is updated then update the UI.
    await initCamera(cameraController);
  }

  Future<void> initCamera(CameraController cameraController) async {
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Camera error ${cameraController.value.errorDescription}'),
          ),
        );
      }
    });
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          await MessageConfig.showDialogSetting(title: S.current.camera_access);
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          await MessageConfig.showDialogSetting(title: S.current.camera_access);
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showToast(message: S.current.camera_restricted);
          break;
        case 'AudioAccessDenied':
          await MessageConfig.showDialogSetting(title: S.current.audio_access);
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          //ios only
          await MessageConfig.showDialogSetting(title: S.current.audio_access);
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showToast(message: S.current.audio_restricted);
          break;
        default:
          showToast(
            message: S.current.something_went_wrong,
          );
          break;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getCameras() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras[0],
      ResolutionPreset.max,
      imageFormatGroup:
          Platform.isIOS ? ImageFormatGroup.bgra8888 : ImageFormatGroup.yuv420,
    );
    await initCamera(_controller!);
    if (mounted) {
      setState(() {});
    }
  }

  void showToast({required String message}) {
    toast.removeQueuedCustomToasts();
    toast.showToast(
      child: ShowToast(
        text: message,
        withOpacity: 0.4,
      ),
      gravity: ToastGravity.TOP_RIGHT,
    );
  }

  Future<void> _tapToFocus(TapUpDetails details) async {
    if (_controller?.value.isInitialized ?? false) {
      showFocusCircle = true;
      x = details.localPosition.dx;
      y = details.localPosition.dy;
      final double xp = x / (_previewKey.currentContext?.size?.width ?? 0);
      final double yp = y / (_previewKey.currentContext?.size?.height ?? 0);
      final Offset point = Offset(xp, yp);
      await _controller?.setFocusPoint(point);
      setState(() {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          setState(() {
            showFocusCircle = false;
          });
        });
      });
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

  Future<void> takePhoto() async {
    if (!isTakePhoto &&
        _cropKey.currentContext != null &&
        _previewKey.currentContext != null) {
      try {
        isTakePhoto = true;
        final XFile file = await _controller!.takePicture();
        await _controller?.pausePreview();
        final image = File(file.path);
        final bytes = await image.readAsBytes();
        final src = img.decodeImage(bytes);
        final tileWidth =
            (src?.width ?? 1) / (_previewKey.currentContext?.size?.width ?? 1);
        final tileHeight = (src?.height ?? 1) /
            (_previewKey.currentContext?.size?.height ?? 1);
        final _box = getBox(_cropKey);
        final _previewBox = getBox(_previewKey);
        final offsetX = _box.localToGlobal(Offset.zero).dx;
        final offsetBoxY = _box.localToGlobal(Offset.zero).dy;
        final offsetPreviewY = _previewBox.localToGlobal(Offset.zero).dy;
        final width = _box.size.width;
        final height = _box.size.height;
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
        isTakePhoto = false;
      } catch (_) {
      } finally {
        isTakePhoto = false;
      }
    }
  }

  RenderBox getBox(GlobalKey key) {
    try {
      final _box = key.currentContext!.findRenderObject() as RenderBox;
      return _box;
    } catch (_) {
      return getBox(key);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    _controller?.dispose();
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
          if (showFocusCircle)
            Positioned(
              top: y - 20,
              left: x - 20,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          Column(
            children: [
              Container(
                color: AppTheme.getInstance().backGroundColor(),
                height: 16,
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.width - 32) / 1.8,
                child: Row(
                  children: [
                    Container(
                      color: AppTheme.getInstance().backGroundColor(),
                      width: 16,
                    ),
                    Expanded(
                      child: _capturedImage != null
                          ? WidgetFrameConner(
                              child: Image.file(
                                _capturedImage!,
                                fit: BoxFit.fill,
                              ),
                            )
                          : GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTapUp: (details) {
                                _tapToFocus(details);
                              },
                              child: WidgetFrameConner(
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
                showLoad: isTakePhoto,
                onTap: () {
                  takePhoto();
                  // showDiaLog(
                  //   context,
                  //   title: S.current.hinh_anh_nhan_dien_khong_hop_le,
                  //   icon: Container(
                  //     width: 56,
                  //     height: 56,
                  //     decoration: BoxDecoration(
                  //       color: choVaoSoColor.withOpacity(0.1),
                  //       borderRadius: BorderRadius.circular(6.0),
                  //     ),
                  //     padding: const EdgeInsets.all(14.0),
                  //     child: SvgPicture.asset(
                  //       ImageAssets.icAlertDanger,
                  //     ),
                  //   ),
                  //   btnLeftTxt: S.current.dong,
                  //   btnRightTxt: S.current.thu_lai,
                  //   funcBtnRight: () {},
                  //   showTablet: false,
                  //   textAlign: TextAlign.start,
                  //   textContent:
                  //       '${S.current.mesage_thong_tin_khach}\n${S.current.mesage_thong_tin_khach1}\n'
                  //       '${S.current.mesage_thong_tin_khach2}\n${S.current.mesage_thong_tin_khach3}\n'
                  //       '${S.current.mesage_thong_tin_khach4}',
                  // );
                },
              )
            : DoubleButtonBottom(
                onClickLeft: () {
                  _capturedImage = null;
                  _controller?.resumePreview();
                  setState(() {});
                },
                onClickRight: () {},
                title1: S.current.thu_lai,
                title2: S.current.chon,
              ),
      ),
    );
  }
}

class SolidButton extends StatelessWidget {
  final Function() onTap;
  final bool showLoad;

  const SolidButton({
    Key? key,
    required this.onTap,
    required this.showLoad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.getInstance().colorField(),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: showLoad
            ? SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(
                  color: AppTheme.getInstance().backGroundColor(),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageAssets.icCameraWhite,
                    width: 20,
                    height: 20,
                    color: AppTheme.getInstance().backGroundColor(),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    S.current.chup,
                    style: textNormalCustom(
                      color: AppTheme.getInstance().backGroundColor(),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
