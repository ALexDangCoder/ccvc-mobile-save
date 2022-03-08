import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';

class NhiemVuCellTablet extends StatelessWidget {
  final String title;
  final String dateTimeStart;
  final String dateTimeEnd;
  final String userImage;
  final String userName;
  final String noiDung;
  final String status;
  final int index;
  final Function onTap;

  const NhiemVuCellTablet({
    Key? key,
    required this.title,
    required this.dateTimeStart,
    required this.dateTimeEnd,
    required this.userImage,
    required this.userName,
    required this.noiDung,
    required this.status,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24.0),
        height: 137,
        decoration: BoxDecoration(
          border: Border.all(color: borderItemCalender),
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColorApp,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 5,
              spreadRadius: 2,
            )
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
                        SizedBox(
                          width: 30,
                          child: Text(
                            '${index.toString().padLeft(2, '0')}.',
                            style: textNormalCustom(
                                fontSize: 16.0,
                                color: titleItemEdit,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: titleAppbar(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                '${DateTime.parse(dateTimeStart).toStringWithAMPM}-${DateTime.parse(dateTimeEnd).toStringWithAMPM}',
                                style: textNormalCustom(
                                  color: textBodyTime,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Text(
                              noiDung,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textNormalCustom(
                                color: unselectedLabelColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
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
                                    color: unselectedLabelColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              Container(
                                width: 101.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: textColorForum,
                                ),
                                child: Center(
                                  child: Text(
                                    status,
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
