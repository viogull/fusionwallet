import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import 'core/abstract/preferences.dart';
import 'core/minter_channel.dart';
import 'core/minter_rest.dart';
import 'core/models.dart';
import 'utils/biometric.dart';
import 'utils/haptic.dart';
import 'utils/shared_prefs.dart';
import 'utils/vault.dart';

export 'package:logger/logger.dart';

export './core/minter_rest.dart';
export './utils/biometric.dart';
export './utils/flasher.dart';
export './utils/haptic.dart';
export './utils/vault.dart';

/*
  Base Service Locator (DI)
 */

GetIt injector = GetIt.instance;

void setupServiceLocator() {
  injector.registerLazySingleton<Preferences>(() => Hive.box<Preferences>(preferencesBox).getAt(0));
  injector.registerLazySingleton<HapticUtil>(() => HapticUtil());
  injector.registerLazySingleton<BiometricUtil>(() => BiometricUtil());
  injector.registerLazySingleton<Vault>(() => Vault());
  injector.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
  injector.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter(printTime: true)));
  injector.registerLazySingleton<MinterChannel>(() => MinterChannel());
  injector.registerLazySingleton<MinterRest>(() => MinterRest());
}
