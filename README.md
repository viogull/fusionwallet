# Fusion Wallet [![Build Status](https://app.bitrise.io/app/078d4c59cda43563/status.svg?token=tovI3DjmdyFaFnGMXo7PQg)](https://app.bitrise.io/app/078d4c59cda43563)  

Fusion - Android/iOS wallet for Minter blockchain.



# Unified API for iOS/Android SDK









# How to use localization?

1. Add new text getter to lib/localizations.dart
2. After **lib/localizations.dart** appending, run next command in terminal to generate **.arb** files.  
`flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localizations.dart`
3. Open and edit **.arb** files **lib/l10n** with BabelEdit. After translation saving, run next command to generate localization files.  
`flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n \ --no-use-deferred-loading             lib/localizations.dart lib/l10n/intl_en.arb lib/l10n/intl_ru.arb`