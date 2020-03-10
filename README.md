# Fusion Wallet

Fusion - Android/iOS wallet for Minter blockchain.


# How to use localization?

1. Add new text getter to lib/localizations.dart
2. After **lib/localizations.dart** appending, run next command in terminal to generate **.arb** files.  
`flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localizations.dart`
3. Open and edit **.arb** files **lib/l10n** with BabelEdit. After translation saving, run next command to generate localization files.  
`flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n \ --no-use-deferred-loading             lib/localizations.dart lib/l10n/intl_en.arb lib/l10n/intl_ru.arb`