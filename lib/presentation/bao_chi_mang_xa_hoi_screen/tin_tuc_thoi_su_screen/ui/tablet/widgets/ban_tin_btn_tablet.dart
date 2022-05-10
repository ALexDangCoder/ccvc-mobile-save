import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/phat_ban_tin/bloc/phat_ban_tin_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/phat_ban_tin/ui/mobile/phat_radio.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/item_list_bang_tin_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

class BanTinBtnSheetTablet extends StatefulWidget {
  final List<TinTucRadioModel> listTinTuc;
  final int index;

  const BanTinBtnSheetTablet({
    Key? key,
    required this.listTinTuc,
    this.index = 0,
  }) : super(key: key);

  @override
  _BanTinBtnSheetTabletState createState() => _BanTinBtnSheetTabletState();
}

class _BanTinBtnSheetTabletState extends State<BanTinBtnSheetTablet> {
  PhatBanTinBloc phatBanTinBloc = PhatBanTinBloc();
  AudioPlayer player = AudioPlayer();
  bool isLoopMode = false;

  @override
  void initState() {
    super.initState();
    phatBanTinBloc.setIndexRadio(widget.index, widget.listTinTuc.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 28,
          ),
          Row(
            children: [
              Row(
                children: [
                  StreamBuilder<bool>(
                    stream: phatBanTinBloc.isRePlay,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? false;
                      return IconButton(
                        color: unselectLabelColor,
                        onPressed: () {
                          phatBanTinBloc.setRePlayMode();
                          player.seek(
                            Duration.zero,
                            index: phatBanTinBloc.getIndexRadio(),
                          );
                        },
                        icon: SvgPicture.asset(
                          ImageAssets.ic_replay,
                          color: data
                              ? AppTheme.getInstance().colorField()
                              : unselectLabelColor,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    color: unselectLabelColor,
                    onPressed: () {
                      phatBanTinBloc.setIndexRadio(
                        phatBanTinBloc.getIndexRadio() - 1,
                        widget.listTinTuc.length - 1,
                      );
                      player.seekToPrevious();
                    },
                    icon: const Icon(Icons.skip_previous),
                  ),
                  StreamBuilder<bool>(
                    stream: phatBanTinBloc.streamPlay,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? true;
                      data ? player.play() : player.pause();
                      return GestureDetector(
                        onTap: () {
                          phatBanTinBloc.changePlay();
                        },
                        child: data
                            ? SizedBox(
                                height: 30.0,
                                width: 30.0,
                                child: SvgPicture.asset(
                                  ImageAssets.ic_pasue.svgToTheme(),
                                ),
                              )
                            : SizedBox(
                                height: 30.0,
                                width: 30.0,
                                child: SvgPicture.asset(
                                  ImageAssets.icPlay.svgToTheme(),
                                ),
                              ),
                      );
                    },
                  ),
                  IconButton(
                    color: unselectLabelColor,
                    onPressed: () {
                      phatBanTinBloc.setIndexRadio(
                        phatBanTinBloc.getIndexRadio() + 1,
                        widget.listTinTuc.length - 1,
                      );
                      player.seekToNext();
                    },
                    icon: const Icon(Icons.skip_next),
                  ),
                  StreamBuilder<bool>(
                    stream: phatBanTinBloc.isLoopMode,
                    builder: (context, snapshot) {
                      isLoopMode = snapshot.data ?? false;
                      isLoopMode
                          ? player.setLoopMode(LoopMode.one)
                          : player.setLoopMode(LoopMode.off);
                      return IconButton(
                        onPressed: () {
                          phatBanTinBloc.setLoopMode();
                        },
                        icon: SvgPicture.asset(
                          ImageAssets.ic_loop_mode,
                          color: isLoopMode
                              ? AppTheme.getInstance().colorField()
                              : unselectLabelColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 56,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<Duration?>(
                      stream: player.positionStream,
                      builder: (context, snapshot) {
                        final timeData = snapshot.data?.inSeconds ?? 0;
                        return Text(
                          phatBanTinBloc.intToDate(timeData),
                          style: textNormalCustom(
                            color: AqiColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: PlayRadio(
                        player: player,
                        listLinkRadio:
                            widget.listTinTuc.map((e) => e.audioUrl).toList(),
                        initPlay: widget.index,
                        onChangeEnd: () {
                          print('-----------------------current index ${phatBanTinBloc.getIndexRadio()}');
                          print('------------------------- isLoop ${isLoopMode}---------');
                          if (isLoopMode) {
                            print('------------------- co lap');
                            phatBanTinBloc.setIndexRadio(
                              phatBanTinBloc.getIndexRadio(),
                              widget.listTinTuc.length - 1,
                            );
                          } else {
                            print('-------------------- khong lap-------------------------');
                            phatBanTinBloc.setIndexRadio(
                              phatBanTinBloc.getIndexRadio() + 1,
                              widget.listTinTuc.length - 1,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    StreamBuilder<Duration?>(
                      stream: player.durationStream,
                      builder: (context, snapshot) {
                        final timeData = snapshot.data?.inSeconds ?? 0;
                        return Text(
                          phatBanTinBloc.intToDate(timeData),
                          style: textNormalCustom(
                            color: AqiColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 56,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.volume_up),
                            color: unselectLabelColor,
                          ),
                          SizedBox(
                            width: 60,
                            child: StreamBuilder<double>(
                              stream: player.volumeStream,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? 0.5;
                                return Container(
                                  color: borderButtomColor,
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackShape: CustomTrackShape(),
                                      trackHeight: 4,
                                      thumbColor:
                                          AppTheme.getInstance().colorField(),
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 60,
                                      height: 4,
                                      child: Slider(
                                        value: data,
                                        activeColor:  AppTheme.getInstance().colorField(),
                                        inactiveColor:borderButtomColor,
                                        onChanged: (double value) {
                                          player.setVolume(value);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          Expanded(
            child: StreamBuilder<int>(
              stream: phatBanTinBloc.indexRadio,
              builder: (context, snapshot) {
                final data = snapshot.data ?? 0;
                return ListView.builder(
                  itemCount: widget.listTinTuc.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print('----------------------load Index ${data}-----------');
                    return (index == data)
                        ? ItemListBangTinTablet(
                            onclick: () {
                              phatBanTinBloc.setIndexRadio(
                                index,
                                widget.listTinTuc.length,
                              );
                            },
                            tin: widget.listTinTuc[index].title,
                            isCheck: true,
                          )
                        : ItemListBangTinTablet(
                            onclick: () {
                              phatBanTinBloc.setIndexRadio(
                                index,
                                widget.listTinTuc.length,
                              );
                              player.seek(
                                Duration.zero,
                                index: index,
                              );
                            },
                            tin: widget.listTinTuc[index].title,
                            isCheck: false,
                          );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
