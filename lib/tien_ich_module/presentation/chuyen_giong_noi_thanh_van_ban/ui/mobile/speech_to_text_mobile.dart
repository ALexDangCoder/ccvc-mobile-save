import 'dart:math';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/bloc/chuyen_giong_noi_thanh_van_ban_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/ui/widget/voice_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextMobile extends StatefulWidget {
  const SpeechToTextMobile({Key? key}) : super(key: key);

  @override
  _SpeechToTextMobileState createState() => _SpeechToTextMobileState();
}

class _SpeechToTextMobileState extends State<SpeechToTextMobile> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  final SpeechToText speech = SpeechToText();
  ChuyenGiongNoiThanhVanBanCubit cubit = ChuyenGiongNoiThanhVanBanCubit();

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
    speech.listen(
      onResult: resultListener,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      cancelOnError: true,
    );
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
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
    initSpeechState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.chuyen_giong_noi_thanh_van_ban,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              children: [
                Expanded(
                  child: speech.isListening
                      ? VoiceWidget(
                          cubit: cubit,
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (!_hasSpeech) {
                      return;
                    }
                    !speech.isListening ? startListening() : stopListening();
                    cubit.isVoiceSubject.sink.add(speech.isListening);
                  },
                  child: SvgPicture.asset(
                    ImageAssets.icVoice,
                    color: AppTheme.getInstance().colorField(),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: speech.isListening
                      ? VoiceWidget(
                          cubit: cubit,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(24.0.textScale(space: 4)),
            child: Text(
              _hasSpeech
                  ? S.current.thay_doi_giong_noi
                  : S.current.speech_not_available,
              style: textNormalCustom(
                color: infoColor,
                fontWeight: FontWeight.w400,
                fontSize: 16.0.textScale(),
              ),
            ),
          ),
          if (lastWords.isNotEmpty)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorNumberCellQLVB,
                border: Border.all(color: borderColor.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: shadowContainerColor.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                // If listening is active show
                // the recognized words
                lastWords,
              ),
            )
          else
            Container(),
          if (lastWords.isNotEmpty)
            GestureDetector(
              onTap: () {
                FlutterClipboard.copy(lastWords).then(
                  (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          S.current.copy_success,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 15,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: buttonColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      ImageAssets.ic_copy,
                    ),
                    spaceW10,
                    Text(
                      S.current.copy,
                      style: textNormal(buttonColor, 14),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
