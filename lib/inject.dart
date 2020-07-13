import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'core/minter_channel.dart';
import 'utils/biometric.dart';
import 'utils/haptic.dart';
import 'utils/shared_prefs.dart';
import 'utils/vault.dart';

/*
  Base Service Locator (DI)
 */

GetIt injector = GetIt.instance;

void setupServiceLocator() {
  injector.registerLazySingleton<HapticUtil>(() => HapticUtil());
  injector.registerLazySingleton<BiometricUtil>(() => BiometricUtil());
  injector.registerLazySingleton<Vault>(() => Vault());
  injector.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
  injector
      .registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
  injector.registerLazySingleton<MinterChannel>(() => MinterChannel());
  injector.registerLazySingleton<MinterRest>(() => MinterRest());
}