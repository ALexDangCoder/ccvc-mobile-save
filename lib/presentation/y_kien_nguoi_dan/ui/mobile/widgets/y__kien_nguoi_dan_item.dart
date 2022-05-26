import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YKienNguoiDanCell extends StatelessWidget {
  final String title;
  final String dateTime;
  final String userImage;
  final String userName;
  final int status;
  final Function onTap;

  const YKienNguoiDanCell({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.userImage,
    required this.userName,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        height: 107,
        decoration: BoxDecoration(
          border: Border.all(color: borderItemCalender),
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColorApp,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 6.0),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: statusCalenderRed,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: titleAppbar(fontSize: 16.0),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            DateTime.parse(dateTime).toStringWithListFormat,
                            style: textNormalCustom(
                              color: textBodyTime,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(userImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: Text(
                                  userName,
                                  style: textNormalCustom(
                                    color: color667793,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: status < 0
                                      ? statusCalenderRed
                                      : textColorForum,
                                ),
                                child: Center(
                                  child: Text(
                                    status < 0
                                        ? S.current.qua_han
                                        : S.current.dang_xu_ly,
                                    style: textNormalCustom(fontSize: 12.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
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
