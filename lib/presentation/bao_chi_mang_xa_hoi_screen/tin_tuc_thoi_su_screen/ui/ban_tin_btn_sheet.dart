import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/item_list_bang_tin.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/phat_ban_tin/bloc/phat_ban_tin_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/phat_ban_tin/ui/mobile/phat_radio.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

class BanTinBtnSheet extends StatefulWidget {
  final List<TinTucRadioModel> listTinTuc;
  final int index;

  const BanTinBtnSheet({Key? key, required this.listTinTuc, this.index = 0})
      : super(key: key);

  @override
  _BanTinBtnSheetState createState() => _BanTinBtnSheetState();
}

class _BanTinBtnSheetState extends State<BanTinBtnSheet> {
  PhatBanTinBloc phatBanTinBloc = PhatBanTinBloc();
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    phatBanTinBloc.setIndexRadio(widget.index, widget.listTinTuc.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.93,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 6,
              width: 57,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
          Text(
            S.current.ban_tin_trua_ngay,
            style: textNormalCustom(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: titleColor,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          PlayRadio(
            player: player,
            listLinkRadio: widget.listTinTuc.map((e) => e.audioUrl).toList(),
            initPlay: widget.index,
          ),
          SizedBox(height: 30,),
          GestureDetector(
            child:  const Icon(Icons.add),
            onTap: (){
              player.seek(const Duration( seconds: 180), index: 1);

            },
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Row(
                children: [
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
                        child: SvgPicture.asset(ImageAssets.icPlay),
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
                  const SizedBox(
                    width: 10,
                  ),

                ],
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
                                      thumbColor: labelColor,
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6,),
                                    ),
                                    child: SizedBox(
                                      width: 60,
                                      height: 4,
                                      child: Slider(
                                        value: data,
                                        activeColor: labelColor,
                                        inactiveColor: borderButtomColor,
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
                    const SizedBox(
                      width: 10,
                    ),
                    StreamBuilder<Duration?>(
                      stream: player.positionStream,
                      builder: (context, snapshot) {
                        final timeData = snapshot.data?.inSeconds ?? 0;
                        return Text(
                          '${phatBanTinBloc.intToDate(timeData)}/',
                          style: textNormalCustom(
                            color: AqiColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
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
            ],
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
                    return (index == data)
                        ? ItemListBangTin(
                            onclick: () {
                              phatBanTinBloc.setIndexRadio(
                                index,
                                widget.listTinTuc.length,
                              );
                            },
                            tin: widget.listTinTuc[index].title,
                            isCheck: true,
                          )
                        : ItemListBangTin(
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
