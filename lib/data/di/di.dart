import 'package:get_it/get_it.dart';
import 'di_config.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() => $initGetIt(getIt, environment: '');
