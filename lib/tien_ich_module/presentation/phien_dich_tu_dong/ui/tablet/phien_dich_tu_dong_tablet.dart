import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/bloc/phien_dich_tu_dong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/ui/widget/language_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

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
    if (speech.isListening) {
      speech.stop();
    } else {
      speech.listen(
        onResult: (result) {
          setState(() {
            lastWords = result.recognizedWords;
            textEditingController.text =
                '${textEditingController.value.text} $lastWords';
          });
        },
        pauseFor: const Duration(seconds: 3),
      );
    }
  }

  final snackBar = SnackBar(
    content: Text(
      S.current.coppy,
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(
        S.current.phien_dich_tu_dong,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
                          cubit.textTranslateSubject
                              .add(textEditingController.text);
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 180,
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
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
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            onChanged: (String value) {
                              cubit.lengthTextSubject
                                  .add(textEditingController.text.length);
                            },
                            maxLength: 1000,
                            decoration: const InputDecoration(
                              counterText: '',
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
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 23.5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: startListening,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 20,
                                    right: 20,
                                  ),
                                  child: SvgPicture.asset(
                                    ImageAssets.icVoiceMini,
                                  ),
                                ),
                              ),
                              StreamBuilder<int>(
                                stream: cubit.lengthTextStream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? 0;
                                  return Text(
                                    '${data.toString()}/1000',
                                    style: textNormalCustom(
                                      color: unselectLabelColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 180,
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 22,
                    ),
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
                        Expanded(
                          child: StreamBuilder<String>(
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
                                      color: textTitle,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: cubit.textTranslateSubject.value,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: SvgPicture.asset(ImageAssets.icCoppy),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.current.chon_tai_lieu,
              style: textNormalCustom(
                fontWeight: FontWeight.w400,
                fontSize: 18,
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
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            btn(
              onTap: () {
                cubit.readFile(textEditingController);
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
