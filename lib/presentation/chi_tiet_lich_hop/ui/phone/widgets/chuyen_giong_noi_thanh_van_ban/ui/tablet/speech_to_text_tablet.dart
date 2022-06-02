import 'dart:io' show Platform;
import 'dart:math';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/bloc/chuyen_giong_noi_thanh_van_ban_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/ui/widget/voice_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextTablet extends StatefulWidget {
  const SpeechToTextTablet({Key? key}) : super(key: key);

  @override
  _SpeechToTextTabletState createState() => _SpeechToTextTabletState();
}

class _SpeechToTextTabletState extends State<SpeechToTextTablet> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  final SpeechToText speech = SpeechToText();
  ChuyenGiongNoiThanhVanBanCubit cubit = ChuyenGiongNoiThanhVanBanCubit();
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
    speech.listen(
      onResult: resultListener,
      pauseFor: Platform.isAndroid ? const Duration(seconds: 3) : null,
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
  void dispose() {
    super.dispose();
    speech.stop();
    speech.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          spaceH20,
          Text(
            S.current.chon_thiet_bi,
            style: textNormalCustom(
              color: color586B8B,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
            textAlign: TextAlign.left,
          ),
          spaceH8,
          CoolDropDown(
            initData: cubit.mList.first,
            placeHoder: cubit.mList.first,
            onChange: (value) {},
            listData: cubit.mList,
          ),
          InputInfoUserWidget(
            title: S.current.tep_am_thanh,
            child: TextFieldValidator(
              hintText: S.current.tep_am_thanh,
              maxLength: 255,
            ),
          ),
          InputInfoUserWidget(
            title: S.current.thoi_luong_phut,
            child: TextFieldValidator(
              hintText: S.current.thoi_gian,
              maxLength: 255,
            ),
          ),
          spaceH32,
          if (Platform.isAndroid)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 160),
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
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 160),
                    child: speech.isListening
                        ? VoiceWidget(
                            cubit: cubit,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          if (Platform.isIOS)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 160),
                    child: isListening
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
                      !isListening ? startListening() : stopListening();
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
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 160),
                    child: isListening
                        ? VoiceWidget(
                            cubit: cubit,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          Center(
            child: Container(
              padding: EdgeInsets.all(24.0.textScale(space: 4)),
              child: Text(
                _hasSpeech
                    ? S.current.thay_doi_giong_noi
                    : S.current.speech_not_available,
                style: textNormalCustom(
                  color: textTitle,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0.textScale(),
                ),
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
              child: SelectableText(
                // If listening is active show
                // the recognized words
                lastWords,
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
