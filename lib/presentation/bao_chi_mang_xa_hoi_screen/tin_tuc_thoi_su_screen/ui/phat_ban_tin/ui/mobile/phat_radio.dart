import 'package:audio_session/audio_session.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PlayRadio extends StatefulWidget {
  final AudioPlayer player;
  final List<String> listLinkRadio;
  final int initPlay;
  final Function() onChangeEnd;

  const PlayRadio({
    Key? key,
    required this.player,
    required this.onChangeEnd,
    required this.listLinkRadio,
    this.initPlay = 0,
  }) : super(key: key);

  @override
  _PlayRadioState createState() => _PlayRadioState();
}

class _PlayRadioState extends State<PlayRadio> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(),
    );
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    widget.player.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace stackTrace) {},
    );
    try {
      await widget.player.setAudioSource(
        ConcatenatingAudioSource(
          shuffleOrder: DefaultShuffleOrder(),
          children: widget.listLinkRadio
              .map((e) => AudioSource.uri(Uri.parse(e)))
              .toList(),
        ),
        initialIndex: widget.initPlay, // default
        initialPosition: Duration.zero, // default
      );
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    widget.player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.player.stop();
    } else {
      widget.player.play();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        widget.player.positionStream,
        widget.player.bufferedPositionStream,
        widget.player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position: position,
          bufferedPosition: bufferedPosition,
          duration: duration,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: _positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SeekBar(
          duration: positionData?.duration ?? Duration.zero,
          position: positionData?.position ?? Duration.zero,
          bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
          onChange: (value) {
            widget.player.seek(Duration(seconds: value));
          },
          onChangeEnd: () {
            widget.onChangeEnd();
          },
        );
      },
    );
  }
}

class PositionData {
  final Duration? position;
  final Duration? bufferedPosition;
  final Duration? duration;

  PositionData({
    this.position,
    this.bufferedPosition,
    this.duration,
  });
}

class SeekBar extends StatefulWidget {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  final Function(int value) onChange;
  final Function() onChangeEnd;

  const SeekBar({
    Key? key,
    required this.position,
    required this.onChange,
    required this.onChangeEnd,
    required this.bufferedPosition,
    required this.duration,
  }) : super(key: key);

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nextItemCallBack(widget.position.inSeconds, widget.duration.inSeconds);
    return Container(
      color: borderButtomColor,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackShape: CustomTrackShape(),
          trackHeight: 6,
          thumbColor: AppTheme.getInstance().colorField(),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        ),
        child: SizedBox(
          width: double.maxFinite,
          height: 6,
          child: Slider(
            value: widget.position.inSeconds.toDouble(),
            max: widget.duration.inSeconds.toDouble(),
            activeColor: AppTheme.getInstance().colorField(),
            inactiveColor: borderButtomColor,
            onChanged: (double value) {
              widget.onChange(value.round());
            },
          ),
        ),
      ),
    );
  }

  void nextItemCallBack(int currentTime, int endTime) {
    if (currentTime == endTime) {
      count++;
      if (count == 3) {
        widget.onChangeEnd();
        count = 0;
      }
    }
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
