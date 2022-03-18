import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_van_ban_thanh_giong_noi/ui/mobile/chuyen_van_ban_thanh_giong_noi_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChuyenVanBanThanhGiongNoiTablet extends StatefulWidget {
  const ChuyenVanBanThanhGiongNoiTablet({Key? key}) : super(key: key);

  @override
  _ChuyenVanBanThanhGiongNoiTabletState createState() =>
      _ChuyenVanBanThanhGiongNoiTabletState();
}

class _ChuyenVanBanThanhGiongNoiTabletState
    extends State<ChuyenVanBanThanhGiongNoiTablet> {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  void get isPlaying => ttsState == TtsState.playing;

  void get isStopped => ttsState == TtsState.stopped;

  void get isPaused => ttsState == TtsState.paused;

  void get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isWeb => kIsWeb;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  void initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<void> _getDefaultEngine() async {
    final engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(
        S.current.chuyen_van_ban_thanh_giong_noi,
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                btnListen(
                  title: S.current.tai_van_ban_len,
                  background: labelColor.withOpacity(0.1),
                  textColor: labelColor,
                  isIcon: true,
                  onTap: () {},
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: Container(
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
                child: TextField(
                  onChanged: (String value) {
                    _onChange(value);
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
            ),
            const SizedBox(
              height: 28,
            ),
            btnListen(
              title: S.current.doc_ngay,
              background: labelColor,
              textColor: Colors.white,
              isIcon: false,
              onTap: () {
                _speak();
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget btnListen({
    required String title,
    required Color background,
    required Color textColor,
    required bool isIcon,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: isIcon
            ? const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 14,
              )
            : const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 71.5,
              ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIcon)
              Row(
                children: [
                  SvgPicture.asset(ImageAssets.icUpFile),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              )
            else
              Container(),
            Text(
              title,
              style: textNormalCustom(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
