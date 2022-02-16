import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';

mixin AccountRepository {
  Future<Result<DataUser>> login(
    String userName,
    String passWord,
    String appCode,
  );
}
