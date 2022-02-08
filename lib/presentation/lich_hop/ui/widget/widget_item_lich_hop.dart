import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetItemLichHop extends StatelessWidget {
  final String title;
  final String dateTimeFrom;
  final String dateTimeTo;
  final List<String> urlImage;
  final Function ontap;

  const WidgetItemLichHop({
    Key? key,
    required this.title,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.urlImage,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap(),
      child: Container(
        height: 99.0.textScale(space: 37),
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.textScale()),
          color: backgroundColorApp,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(color: borderItemCalender),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 11.0.textScale(space: 14),
            bottom: 11.0.textScale(space: 13),
            left: 16.0.textScale(space: 4.0),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 6.0),
                    child: Container(
                      width: 8.0.textScale(space: 4.0),
                      height: 8.0.textScale(space: 4.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusCalenderRed,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textNormalCustom(
                        color: titleCalenderWork,
                        fontSize: 16.0.textScale(),
                      ),
                    ),
                    Text(
                      '$dateTimeFrom - $dateTimeTo',
                      style: textNormalCustom(
                        color: textBodyTime,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0.textScale(),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 24.0.textScale(space: 4.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: urlImage.length,
                              itemBuilder: (context, index) {
                                return WidgetImage(
                                  urlImage: urlImage[index],
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 14.0.textScale(space: 10.0),
                          ),
                          height: 24,
                          width: 79,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: textDefault,
                          ),
                          child: Center(
                            child: Text(
                              S.current.truc_tiep,
                              style: textNormalCustom(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetImage extends StatelessWidget {
  final String urlImage;

  const WidgetImage({Key? key, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4.0.textScale(space: 4.0)),
      height: 24.0.textScale(space: 4.0),
      width: 24.0.textScale(space: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(urlImage),
        ),
      ),
    );
  }
}
