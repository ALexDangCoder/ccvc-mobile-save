import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/bloc/chuyen_giong_noi_thanh_van_ban_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/ui/widget/voice_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChuyenGiongNoiThanhVanBanTablet extends StatefulWidget {
  const ChuyenGiongNoiThanhVanBanTablet({Key? key}) : super(key: key);

  @override
  _ChuyenGiongNoiThanhVanBanTabletState createState() =>
      _ChuyenGiongNoiThanhVanBanTabletState();
}

class _ChuyenGiongNoiThanhVanBanTabletState
    extends State<ChuyenGiongNoiThanhVanBanTablet> {
  ChuyenGiongNoiThanhVanBanCubit cubit = ChuyenGiongNoiThanhVanBanCubit();

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    cubit.isVoiceSubject.add(!cubit.isVoiceSubject.value);

    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    cubit.isVoiceSubject.add(!cubit.isVoiceSubject.value);

    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<bool>(
                  stream: cubit.isVoiceStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? false;
                    return Expanded(
                      child: data
                          ? VoiceWidget(
                              cubit: cubit,
                            )
                          : Container(),
                    );
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: _speechToText.isNotListening
                      ? _startListening
                      : _stopListening,
                  child: SvgPicture.asset(
                    ImageAssets.icVoice,
                    color: AppTheme.getInstance().colorField(),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                StreamBuilder<bool>(
                  stream: cubit.isVoiceStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? false;
                    return Expanded(
                      child: data
                          ? VoiceWidget(
                              cubit: cubit,
                            )
                          : Container(),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(24.0.textScale(space: 4)),
            child: Text(
              S.current.thay_doi_giong_noi,
              style: textNormalCustom(
                color: infoColor,
                fontWeight: FontWeight.w400,
                fontSize: 16.0.textScale(),
              ),
            ),
          ),
          if (_lastWords.isNotEmpty)
            Container(
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
                _lastWords,
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
