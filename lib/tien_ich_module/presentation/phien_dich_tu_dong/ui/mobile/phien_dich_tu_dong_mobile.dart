import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/bloc/phien_dich_tu_dong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/ui/widget/language_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class PhienDichTuDongMobile extends StatefulWidget {
  const PhienDichTuDongMobile({Key? key}) : super(key: key);

  @override
  _PhienDichTuDongMobileState createState() => _PhienDichTuDongMobileState();
}

class _PhienDichTuDongMobileState extends State<PhienDichTuDongMobile> {
  PhienDichTuDongCubit cubit = PhienDichTuDongCubit();
  TextEditingController textEditingController = TextEditingController();
  final translator = GoogleTranslator();

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void viToEn() {
    translator.translate(textEditingController.text, to: 'en').then((result) {
      cubit.translateLanguage(result.text);
    });
  }

  void enToVi() {
    translator.translate(textEditingController.text, to: 'vi').then((result) {
      cubit.translateLanguage(result.text);
    });
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    viToEn();
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    concatenationString();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void concatenationString() {
    textEditingController.text = '${textEditingController.text} $_lastWords';
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
                        onTap: () {
                          cubit.swapLanguage();
                          cubit.translateLanguage(textEditingController.text);
                          cubit.languageSubject.value == LANGUAGE.vn
                              ? viToEn()
                              : enToVi();
                        },
                        child: SvgPicture.asset(
                          ImageAssets.icReplace,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (String value) {
                        cubit.languageSubject.value == LANGUAGE.vn
                            ? viToEn()
                            : enToVi();
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
                      ),
                      maxLines: null,
                    ),
                  ),
                  GestureDetector(
                    onTap: _speechToText.isNotListening
                        ? _startListening
                        : _stopListening,
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                      ),
                      child: SvgPicture.asset(
                        ImageAssets.icVoiceMini,
                        color: AppTheme.getInstance().colorField(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.all(16),
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
                            textEditingController.text.isEmpty ? '' : data,
                            style: textNormalCustom(
                              color: textTitle,
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
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.current.chon_tat_ca,
              style: textNormalCustom(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: titleColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              S.current.chi_ho_tro_txt,
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
                cubit.readFile(
                  textEditingController,
                  viToEn,
                  enToVi,
                );
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
            )
          ],
        ),
      ),
    );
  }
}
