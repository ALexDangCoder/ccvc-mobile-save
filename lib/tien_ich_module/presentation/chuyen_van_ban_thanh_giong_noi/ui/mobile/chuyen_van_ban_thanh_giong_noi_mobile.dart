import 'dart:async';
import 'dart:io' show Platform;

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class ChuyenVanBanThanhGiongNoi extends StatefulWidget {
  const ChuyenVanBanThanhGiongNoi({Key? key}) : super(key: key);

  @override
  _ChuyenVanBanThanhGiongNoiState createState() =>
      _ChuyenVanBanThanhGiongNoiState();
}

class _ChuyenVanBanThanhGiongNoiState extends State<ChuyenVanBanThanhGiongNoi> {
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
      appBar: AppBarDefaultBack(
        S.current.chuyen_van_ban_thanh_giong_noi,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
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
              height: 80,
            ),
            btnListen(
              onTap: () {
                _speak();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget btnListen({required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().colorField(),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.current.doc_ngay,
              style: textNormalCustom(
                fontSize: 14,
                color: Colors.white,
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
