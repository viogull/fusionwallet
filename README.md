<<<<<<< HEAD
# Fusion 
[![Build Status](https://app.bitrise.io/app/352c71b99d029dd1/status.svg?token=KSQQzlyYuEdaMvrak9Yjhw&branch=releases)](https://app.bitrise.io/app/352c71b99d029dd1)
 
#### Android/iOS wallet for Minter blockchain.
=======
# Fusion Wallet 
[![Codemagic build status](https://api.codemagic.io/apps/5f317971cfa936e4b9f461b7/5f317971cfa936e4b9f461b6/status_badge.svg)](https://codemagic.io/apps/5f317971cfa936e4b9f461b7/5f317971cfa936e4b9f461b6/latest_build)

[![Build Status](https://app.bitrise.io/app/352c71b99d029dd1/status.svg?token=KSQQzlyYuEdaMvrak9Yjhw&branch=releases)](https://app.bitrise.io/app/352c71b99d029dd1)

Android/iOS wallet for Minter blockchain.
>>>>>>> cd180e4137c8cdb523f254b7824ef545ac37ce9b
##
`[✓] Flutter (Channel stable, 1.20.0, macOS 11.0 20A5323l,ru-UA)`


## Generate App Icons
`flutter pub run flutter_launcher_icons:main`

## Generate models
`flutter packages pub run build_runner build --delete-conflicting-outputs`

## How to use localization?

1. Add new text getter to lib/localizations.dart
2. After **lib/localizations.dart** appending, run next command in terminal to generate **.arb** files.  
`flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localizations.dart`
3. Open and edit **.arb** files **lib/l10n** with BabelEdit. After translation saving, run next command to generate localization files.  
`flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n \ --no-use-deferred-loading             lib/localizations.dart lib/l10n/intl_en.arb lib/l10n/intl_ru.arb`