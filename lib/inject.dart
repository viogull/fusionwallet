import 'package:alice/alice.dart';
import 'package:fusion_wallet/core/abstract/preferences.dart';
import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import 'core/minter_channel.dart';
import 'utils/biometric.dart';
import 'utils/haptic.dart';
import 'utils/shared_prefs.dart';
import 'utils/vault.dart';

export 'package:logger/logger.dart';

export './core/minter_rest.dart';
export './utils/haptic.dart';
export './utils/vault.dart';


/*
  Base Service Locator (DI)
 */

GetIt injector = GetIt.instance;

void setupServiceLocator() {
  injector.registerLazySingleton<Preferences>(() =>
      Hive.box<Preferences>(preferencesBox).getAt(0));
  injector.registerLazySingleton<HapticUtil>(() => HapticUtil());
  injector.registerLazySingleton<BiometricUtil>(() => BiometricUtil());
  injector.registerLazySingleton<Vault>(() => Vault());
  injector.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
  injector.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
  injector.registerLazySingleton<MinterChannel>(() => MinterChannel());
  injector.registerLazySingleton<MinterRest>(() => MinterRest());
  injector.registerLazySingleton<Alice>(() => Alice(showInspectorOnShake: true,
      showNotification: true));
}


