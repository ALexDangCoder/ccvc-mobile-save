import 'dart:io' show Platform;
import 'dart:math';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/debouncer.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/bloc/phien_dich_tu_dong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/ui/widget/language_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PhienDichTuDongTablet extends StatefulWidget {
  const PhienDichTuDongTablet({Key? key}) : super(key: key);

  @override
  _PhienDichTuDongTabletState createState() => _PhienDichTuDongTabletState();
}

class _PhienDichTuDongTabletState extends State<PhienDichTuDongTablet> {
  PhienDichTuDongCubit cubit = PhienDichTuDongCubit();
  TextEditingController textEditingController = TextEditingController();
  final SpeechToText speech = SpeechToText();
  bool _hasSpeech = false;
  String lastWords = '';
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  late final Debouncer debouncer;
  bool isListening = false;

  Future<void> initSpeechState() async {
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
  }

  void startListening() {
    if (!_hasSpeech) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.speech_not_available),
        ),
      );
      return;
    }
    speech.listen(
      onResult: resultListener,
      pauseFor: Platform.isAndroid ? const Duration(seconds: 3) : null,
      localeId: cubit.voiceType,
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
  void initState() {
    super.initState();
    debouncer = Debouncer();
    initSpeechState();
  }

  @override
  void dispose() {
    speech.stop();
    super.dispose();
    cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(
        S.current.phien_dich_tu_dong,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),

            /// Change language
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: borderColor.withOpacity(0.5),
                ),
              ),
              child: StreamBuilder<LANGUAGE>(
                stream: cubit.languageStream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? LANGUAGE.vn;
                  return Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            data.languageLeftWidget(),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.swapLanguage();
                          stopListening();
                          cubit.textTranslateSubject
                              .add(textEditingController.value.text);
                          cubit.translateDocument(
                            document: textEditingController.value.text,
                          );
                        },
                        child: SvgPicture.asset(ImageAssets.icReplace),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            data.languageRightWidget(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: toDayColor.withOpacity(0.5),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //input
                              Expanded(
                                child: TextField(
                                  controller: textEditingController,
                                  onChanged: (String value) {
                                    debouncer.run(() {
                                      cubit.translateDocument(document: value);
                                    });
                                    cubit.lengthTextSubject.add(value.length);
                                  },
                                  style: textNormal(
                                    infoColor,
                                    16,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      right: 28,
                                      top: 20,
                                      bottom: 20,
                                      left: 16,
                                    ),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //mic
                                    if (Platform.isAndroid)
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: speech.isListening
                                            ? stopListening
                                            : startListening,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          child: SvgPicture.asset(
                                            ImageAssets.icVoiceMini,
                                            color: speech.isListening
                                                ? AppTheme.getInstance()
                                                    .colorField()
                                                : textBodyTime,
                                          ),
                                        ),
                                      ),
                                    if (Platform.isIOS)
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: isListening
                                            ? stopListening
                                            : startListening,
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                            3,
                                          ),
                                          child: SvgPicture.asset(
                                            ImageAssets.icVoiceMini,
                                            color: isListening
                                                ? AppTheme.getInstance()
                                                    .colorField()
                                                : textBodyTime,
                                          ),
                                        ),
                                      ),
                                    StreamBuilder<int>(
                                      stream: cubit.lengthTextStream,
                                      builder: (context, snapshot) {
                                        final count = snapshot.data ?? 0;
                                        return Text(
                                          '$count/5000',
                                          style: textNormal(
                                            iconColorDown,
                                            14,
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              spaceH20,
                            ],
                          ),
                          StreamBuilder<String>(
                            stream: cubit.textTranslateSubject,
                            builder: (context, snapshot) {
                              final isNotEmpty = (snapshot.data ?? '').isNotEmpty;
                              return isNotEmpty
                                  ? Positioned(
                                top: 10,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    textEditingController.clear();
                                    cubit.lengthTextSubject.sink.add(0);
                                    cubit.textTranslateSubject.add('');
                                    stopListening();
                                  },
                                  child: ImageAssets.svgAssets(
                                    ImageAssets.icX,
                                    width: 25,
                                    height: 25,
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
                  ),
                  spaceW28,
                  //translated
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: toDayColor.withOpacity(0.5),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: StreamBuilder<String>(
                        stream: cubit.textTranslateStream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? '';
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  data,
                                  style: textNormal(infoColor, 16),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// choose file
            const SizedBox(
              height: 16,
            ),
            Text(
              S.current.chon_tai_lieu,
              style: textNormalCustom(
                fontWeight: FontWeight.w500,
                fontSize: 18,
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
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            btn(
              onTap: () {
                cubit.translateFile(textEditingController);
              },
            ),
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
          color: textDefault.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(ImageAssets.icDocumentBlue),
            const SizedBox(
              width: 9,
            ),
            Text(
              S.current.tim_tep_tren_dien_thoai_cua_ban,
              style: textNormalCustom(
                color: buttonColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
