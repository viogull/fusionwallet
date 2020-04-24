import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'core/account_service.dart';
import 'utils/biometric.dart';
import 'utils/haptic.dart';
import 'utils/shared_prefs.dart';
import 'utils/vault.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<AccountService>(() => AccountService());
  sl.registerLazySingleton<HapticUtil>(() => HapticUtil());
  sl.registerLazySingleton<BiometricUtil>(() => BiometricUtil());
  sl.registerLazySingleton<Vault>(() => Vault());
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
  sl.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
}
