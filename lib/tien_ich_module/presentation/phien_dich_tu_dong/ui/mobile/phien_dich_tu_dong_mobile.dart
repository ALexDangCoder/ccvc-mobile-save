import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/bloc/phien_dich_tu_dong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/ui/widget/language_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PhienDichTuDongMobile extends StatefulWidget {
  const PhienDichTuDongMobile({Key? key}) : super(key: key);

  @override
  _PhienDichTuDongMobileState createState() => _PhienDichTuDongMobileState();
}

class _PhienDichTuDongMobileState extends State<PhienDichTuDongMobile> {
  PhienDichTuDongCubit cubit = PhienDichTuDongCubit();
  TextEditingController textEditingController = TextEditingController();
  final SpeechToText speech = SpeechToText();
  bool _hasSpeech = false;
  String lastWords = '';
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  bool isListening = false;
  late final Debouncer debouncer;

  Future<bool> checkPermissionRecord() async {
    final permission = await Permission.microphone.request();
    final permissionBluetooth = Platform.isAndroid
        ? await Permission.bluetoothConnect.request()
        : await Permission.speech.request();
    final microReject = permission == PermissionStatus.denied ||
        permission == PermissionStatus.permanentlyDenied;
    final blueToothReject = permissionBluetooth == PermissionStatus.denied ||
        permissionBluetooth == PermissionStatus.permanentlyDenied;
    return  !microReject && !blueToothReject;
  }

  Future<void> initSpeechState() async {
    final permission = await checkPermissionRecord();
    if (permission) {
      try {
        final hasSpeech = await speech.initialize();
        if (!mounted) return;
        setState(() {
          _hasSpeech = hasSpeech;
        });
      } catch (e) {
        setState(() {
          _hasSpeech = false;
        });
      }
    } else {
      await MessageConfig.showDialogSetting();
    }
  }

  Future<void> startListening() async {
    if (!_hasSpeech) {
      await initSpeechState();
      if (!_hasSpeech) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.current.speech_not_available),
          ),
        );
        return;
      }
    }
    unawaited(
      speech.listen(
        onResult: resultListener,
        pauseFor: Platform.isAndroid ? const Duration(seconds: 3) : null,
        localeId: cubit.voiceType,
      ),
    );
    setState(() {
      isListening = true;
    });
  }

  void stopListening() {
    speech.stop();
    setState(() {
      isListening = false;
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    debouncer.run(() {
      textEditingController.text = result.recognizedWords;
      cubit.translateDocument(document: result.recognizedWords);
    });
    setState(() {});
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }

  @override
  void dispose() {
    speech.stop();
    super.dispose();
    cubit.dispose();
  }

  @override
  void initState() {
    super.initState();
    debouncer = Debouncer(milliseconds: 500);
    initSpeechState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.phien_dich_tu_dong,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: borderColor.withOpacity(0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowContainerColor.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: StreamBuilder<LANGUAGE>(
                stream: cubit.languageStream,
                builder: (context, snapshot) {
                  final dataLanguage = snapshot.data ?? LANGUAGE.vn;
                  return Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            dataLanguage.languageLeftWidget(),
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          cubit.swapLanguage();
                          stopListening();
                          cubit.textTranslateSubject
                              .add(textEditingController.value.text);
                          cubit.translateDocument(
                            document: textEditingController.value.text,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SvgPicture.asset(
                            ImageAssets.icReplace,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            dataLanguage.languageRightWidget(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 180,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: borderColor.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: shadowContainerColor.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //need translate
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          onChanged: (String value) {
                            debouncer.run(
                              () {
                                cubit.lengthTextSubject.add(value.length);
                                cubit.translateDocument(document: value);
                              },
                            );
                          },
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            counterText: '',
                          ),
                          maxLines: null,
                          maxLength: 5000,
                        ),
                      ),
                      //mic
                      if (Platform.isAndroid)
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: speech.isListening
                              ? stopListening
                              : startListening,
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: SvgPicture.asset(
                              ImageAssets.icVoiceMini,
                              color: speech.isListening
                                  ? AppTheme.getInstance().colorField()
                                  : textBodyTime,
                            ),
                          ),
                        ),
                      if (Platform.isIOS)
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: isListening ? stopListening : startListening,
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: SvgPicture.asset(
                              ImageAssets.icVoiceMini,
                              color: isListening
                                  ? AppTheme.getInstance().colorField()
                                  : textBodyTime,
                            ),
                          ),
                        ),
                    ],
                  ),
                  //icon delete
                  StreamBuilder<String>(
                    stream: cubit.textTranslateSubject,
                    builder: (context, snapshot) {
                      final isNotEmpty = (snapshot.data ?? '').isNotEmpty;
                      return isNotEmpty
                          ? Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  textEditingController.clear();
                                  cubit.textTranslateSubject.add('');
                                  stopListening();
                                },
                                child: ImageAssets.svgAssets(
                                  ImageAssets.icX,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                  color: textBodyTime.withOpacity(0.5),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),

            //translated
            StreamBuilder<String>(
              stream: cubit.textTranslateSubject,
              builder: (context, snapshot) {
                final bool isNotEmpty = (snapshot.data ?? '').isNotEmpty;
                return isNotEmpty
                    ? Container(
                        height: 180,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().colorField(),
                          border: Border.all(
                            color: borderColor.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: shadowContainerColor.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<String>(
                              stream: cubit.textTranslateStream,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? '';
                                return Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      textEditingController.text.isEmpty
                                          ? ''
                                          : data,
                                      style: textNormalCustom(
                                        color: AppTheme.getInstance()
                                            .dfBtnTxtColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.current.chon_tai_lieu,
              style: textNormalCustom(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: titleColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              S.current.just_txt,
              style: textNormalCustom(
                color: textBodyTime,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            btn(
              onTap: () {
                cubit.translateFile(
                  textEditingController,
                );
              },
            ),
            spaceH32,
          ],
        ),
      ),
    );
  }

  Widget btn({
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.5,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().colorField().withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              ImageAssets.icDocumentBlue,
              color: AppTheme.getInstance().colorField(),
            ),
            const SizedBox(
              width: 9,
            ),
            Text(
              S.current.tim_tep_tren_dien_thoai_cua_ban,
              style: textNormalCustom(
                color: AppTheme.getInstance().colorField(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
