import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static const LOCALE_ENGLISH = const Locale('en', '');
  static const LOCALE_RUSSIAN = const Locale('ru', '');

  static const Locales = const [LOCALE_ENGLISH, LOCALE_RUSSIAN];

  static fetchLanguages(BuildContext context) {
    return [
      AppLocalizations.of(context).localeEnglishItem(),
      AppLocalizations.of(context).localeRussianItem()
    ];
  }

  static Locale getLocaleBySelectionIndex(int index) {
    if (index == null) {
      return LOCALE_ENGLISH;
    } else {
      if (index == 1)
        return LOCALE_RUSSIAN;
      else
        return LOCALE_ENGLISH;
    }
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  appName() => Intl.message('Fusion', name: 'appName');

  buttonCreateAccount() =>
      Intl.message('Create account', name: 'buttonCreateAccount');

  buttonRecoverFromPassphrase() =>
      Intl.message('Recover account from passphrase',
          name: 'buttonRecoverFromPassphrase');

  labelAlreadyHaveAccount() =>
      Intl.message('Already have an account?', name: 'labelAlreadyHaveAccount');

  toolbarChoosePassTitle() =>
      Intl.message('Choose password', name: 'toolbarChoosePassTitle');

  labelChoosePassSubtitle() => Intl.message('Choose a six digit password',
      name: 'labelChoosePassSubtitle');

  labelChoosePassVerifySubtitle() => Intl.message('Enter the same six digits',
      name: 'labelChoosePassVerifySubtitle');

  labelEnableBiometricTitle() => Intl.message('Enable Touch ID/Face ID',
      name: 'labelEnableBiometricTitle');

  labelEnableBiometricSubtitle() =>
      Intl.message('We recommend this for improved security',
          name: 'labelEnableBiometricSubtitle');

  labelYes() => Intl.message('Yes', name: 'labelYes');

  labelNo() => Intl.message('No', name: 'labelNo');

  toolbarNewAccountTitle() =>
      Intl.message('New Account', name: 'toolbarNewAccountTitle');

  labelBackupPassphraseSubtitle() => Intl.message('Back up this Passphrase',
      name: 'labelBackupPassphraseSubtitle');

  buttonVerifyRecoveryPhrase() => Intl.message('Verify recovery phrase',
      name: 'buttonVerifyRecoveryPhrase');

  buttonShare() => Intl.message('Share', name: 'buttonShare');

  labelBackupPassphraseCaption() => Intl.message(
      'In order to access this accout if you lose this device, ciopy or print this phrase and keep it someplace safe.',
      name: 'labelBackupPassphraseCaption');

  labelQuestionIndicatorTitle(String current, String total) =>
      Intl.message('Question $current of $total',
          args: [current, total], name: 'labelQuestionIndicatorTitle');

  labelWordIndicatorSubtitle(int position) =>
      Intl.message('Select the ${position}th word of your passphrase',
          args: [position], name: 'labelWordIndicatorSubtitle');

  toastTryAgain() => Intl.message('Please, try again', name: 'toastTryAgain');

  popupPassVerifiedTitle() =>
      Intl.message('Passphrase Verified', name: 'popupPassVerifiedTitle');

  popupPassVerifiedBody() => Intl.message(
      'Your passphrase has been verified. Make sure that you have backed it up as you will needit to recover your account.',
      name: 'popupPassVerifiedBody');

  labelOk() => Intl.message('OK', name: 'labelOk');

  inputAccountNameHelperText() =>
      Intl.message('Account Name', name: 'inputAccountNameHelperText');

  inputAccountNameHintText() => Intl.message('Please, name your account',
      name: 'inputAccountNameHintText');

  checkboxTermsConditions() => Intl.message('I agree with terms&conditions',
      name: 'checkboxTermsConditions');

  buttonNext() => Intl.message('Next', name: 'buttonNext');

  toolbarTermsConditionsTitle() =>
      Intl.message('Terms and Conditions', name: 'toolbarTermsConditionsTitle');

  toolbarRecoverFromSeedTitle() =>
      Intl.message('Recover from seed', name: 'toolbarRecoverFromSeedTitle');

  inputEnterScanPasshpraseHintText() =>
      Intl.message('Enter passphrase or scan QR',
          name: 'inputEnterScanPasshpraseHintText');

  buttonVerify() => Intl.message('Verify', name: 'buttonVerify');

  toolbarScanQrTitle() =>
      Intl.message('Passphrase QR', name: 'toolbarScanQrTitle');

  buttonClose() => Intl.message('Close', name: 'buttonClose');

  popupAccVerificationWelcomeText() =>
      Intl.message('Welcome to Algorand! Your account is ready to use.',
          name: 'popupAccVerificationWelcomeText');

  labelUnlockTitle() => Intl.message('Unlock', name: 'labelUnlockTitle');

  buttonLogOut() => Intl.message('Log out', name: 'buttonLogOut');

  labelUnlockSubtitle() =>
      Intl.message('Enter six digit pin', name: 'labelUnlockSubtitle');

  labelTapToCopy() => Intl.message('Tap to copy', name: 'labelTapToCopy');

  toolbarViewPasshraseTitle() =>
      Intl.message('View Passphrase', name: 'toolbarViewPasshraseTitle');

  buttonSend() => Intl.message('Send', name: 'buttonSend');

  buttonRequest() => Intl.message('Request', name: 'buttonRequest');

  buttonDelegate() => Intl.message('Delegate', name: 'buttonDelegate');

  buttonUnbound() => Intl.message('Unbound', name: 'buttonUnbound');

  buttonPush() => Intl.message('Send Push', name: 'buttonPush');

  labelCryptoAvailable() =>
      Intl.message('Cryptocurrency Available', name: 'labelCryptoAvailable');

  labelTotalReward() =>
      Intl.message('Total Rewards Earned', name: 'labelTotalReward');

  labelTransanctionsHistoryTitle() => Intl.message('Transanctions History',
      name: 'labelTransanctionsHistoryTitle');

  navigationLabelAccounts() =>
      Intl.message('Accounts', name: 'navigationLabelAccounts');

  navigationLabelExchange() =>
      Intl.message('Exchange', name: 'navigationLabelExchange');

  navigationItemContacts() =>
      Intl.message('Contacts', name: 'navigationItemContacts');

  navigationItemHistory() =>
      Intl.message('History', name: 'navigationItemHistory');

  navigationItemSettings() =>
      Intl.message('Settings', name: 'navigationItemSettings');

  menuItemShowQR() =>
      Intl.message('Show QR and Address', name: 'menuItemShowQR');

  menuItemSetDefaults() =>
      Intl.message('Set as defaults', name: 'menuItemSetDefaults');

  menuItemViewPassphrase() =>
      Intl.message('View Passphrase', name: 'menuItemViewPassphrase');

  menuItemEditAccountName() =>
      Intl.message('Edit Account Name', name: 'menuItemEditAccountName');

  menuItemRemoveAccount() =>
      Intl.message('Remove Account', name: 'menuItemRemoveAccount');

  menuItemWithdrawFunds() =>
      Intl.message('Withdraw funds', name: 'menuItemWithdrawFunds');

  menuItemReferalLink() =>
      Intl.message('Referal link', name: 'menuItemReferalLink');

  labelTotalRewardTitle() =>
      Intl.message('Total Rewards Earned', name: 'labelTotalRewardTitle');

  labelPendingRewardTitle() =>
      Intl.message('Pending Rewards', name: 'labelPendingRewardTitle');

  labelPendingRewardSubtitle() => Intl.message(
      'Pending rewards become confirmed when you send or receive BIP',
      name: 'labelPendingRewardSubtitle');

  labelRewardsCaption() =>
      Intl.message('For more information on Fusion Rewards, visit our FAQ',
          name: 'labelRewardsCaption');

  buttonPreview() => Intl.message('Preview', name: 'buttonPreview');

  labelFrom() => Intl.message('From', name: 'labelFrom');

  labelTo() => Intl.message('To', name: 'labelTo');

  labelAmount() => Intl.message('Amount', name: 'labelAmount');

  labelAddress() => Intl.message('Address', name: 'labelAddress');

  labelMyContacts() => Intl.message('My Contacts', name: 'labelMyContacts');

  labelContacts() => Intl.message('Contacts', name: 'labelContacts');

  labelScanQr() => Intl.message('Scan QR', name: 'labelScanQr');

  toolbarSendTitle() => Intl.message('Send funds', name: 'toolbarSendTitle');

  inputMaxAmountSuffix() => Intl.message('MAX', name: 'inputMaxAmountSuffix');

  inputAddressHint() => Intl.message('Enter address', name: 'inputAddressHint');

  inputFundsStakeHint() => Intl.message('Stake', name: 'inputFundsStakeHint');

  labelSender() => Intl.message('Sender', name: 'labelSender');

  labelReceiver() => Intl.message('Receiver', name: 'labelReceiver');

  labelPubkeyOrDomain() =>
      Intl.message('Public key or domain', name: 'labelPubkeyOrDomain');

  labelCoin() => Intl.message('Coin', name: 'labelCoin');

  labelName() => Intl.message('Name', name: 'labelName');

  popupRemoveAccountTitle() =>
      Intl.message('Remove account', name: 'popupRemoveAccountTitle');

  popupRemoveAccountBody() => Intl.message(
      'You are about to remove an account. Are you sure you want to proceed with choice?',
      name: 'popupRemoveAccountBody');

  labelCancel() => Intl.message('Cancel', name: 'labelCancel');

  labelRemove() => Intl.message('Remove', name: 'labelRemove');

  labelSave() => Intl.message('Save', name: 'labelSave');

  inputEditAccountNameTitle() =>
      Intl.message('Edit Account Name', name: 'inputEditAccountNameTitle');

  inputEditAccountNameHint() => Intl.message('Please, name your account',
      name: 'inputEditAccountNameHint');

  toolbarHistoryTitle() => Intl.message('History', name: 'toolbarHistoryTitle');

  labelAccount() => Intl.message('Account:', name: 'labelAccount');

  labelStartDate() => Intl.message('Start Date', name: 'labelStartDate');

  labelEndDate() => Intl.message('End Date', name: 'labelEndDate');

  buttonViewResults() =>
      Intl.message('View results', name: 'buttonViewResults');

  settingsItemUiTheme() =>
      Intl.message('Dark/Light Theme', name: 'settingsItemUiTheme');

  settingsItemChgPassword() =>
      Intl.message('Set/Change password', name: 'settingsItemChgPassword');

  settingsItemBiometricFeature() =>
      Intl.message('Touch ID/Face ID', name: 'settingsItemBiometricFeature');

  settingsItemNotifications() =>
      Intl.message('Notifications', name: 'settingsItemNotifications');

  settingsItemShowRewards() =>
      Intl.message('Show rewards', name: 'settingsItemShowRewards');

  settingsItemLanguage() =>
      Intl.message('Language', name: 'settingsItemLanguage');

  settingsItemSendFeedback() =>
      Intl.message('Send feedback', name: 'settingsItemSendFeedback');

  settingsItemFaq() => Intl.message('FAQ', name: 'settingsItemFaq');

  labelFeedbackNoteTitle() =>
      Intl.message('Note', name: 'labelFeedbackNoteTitle');

  inputFeedbackCommentHint() =>
      Intl.message('What is on your mind', name: 'inputFeedbackCommentHint');

  labelFeedbackEmailSubtitle() =>
      Intl.message('Email (optionally)', name: 'labelFeedbackEmailSubtitle');

  toolbarContactsTitle() =>
      Intl.message('Contacts', name: 'toolbarContactsTitle');

  toolbarAddContactTitle() =>
      Intl.message('Add Contact', name: 'toolbarAddContactTitle');

  inputSearchContactHint() =>
      Intl.message('Search contacts', name: 'inputSearchContactHint');

  labelContactsNotFoundError() =>
      Intl.message('No Contact found', name: 'labelContactsNotFoundError');

  labelAddContactName() => Intl.message('Name', name: 'labelAddContactName');

  labelAddContactAddress() =>
      Intl.message('Address', name: 'labelAddContactAddress');

  inputAddContactNameHint() =>
      Intl.message('Contact Name', name: 'inputAddContactNameHint');

  inputAddContactAddressHint() =>
      Intl.message('Enter address', name: 'inputAddContactAddressHint');

  buttonAddContact() => Intl.message('Add contact', name: 'buttonAddContact');

  toolbarExchangeTitle() =>
      Intl.message('Exchange', name: 'toolbarExchangeTitle');

  toolbarRateTitle() => Intl.message('Rate', name: 'toolbarRateTitle');

  toolbarConvertTitle() => Intl.message('Convert', name: 'toolbarConvertTitle');

  labelExchangeCoins() => Intl.message('My Coins', name: 'labelExchangeCoins');

  buttonConvert() => Intl.message('Convert', name: 'buttonConvert');

  buttonRate() => Intl.message('Rate', name: 'buttonRate');

  buttonBuy() => Intl.message('Buy', name: 'buttonBuy');

  buttonSell() => Intl.message('Sell', name: 'buttonSell');

  labelExchangeUseCash() =>
      Intl.message('Use cash balance', name: 'labelExchangeUseCash');

  labelExchangeSimplex() =>
      Intl.message('Simplex', name: 'labelExchangeSimplex');

  labelBuy() => Intl.message('BUY', name: 'labelBuy');

  labelSell() => Intl.message('SELL', name: 'labelSell');

  labelConvertCoinHave() =>
      Intl.message('Coin You have', name: 'labelConvertCoinHave');

  labelConvertCoinWant() =>
      Intl.message('Coin you want', name: 'labelConvertCoinWant');

  labelConvertWillGet() =>
      Intl.message('You will get approximztely', name: 'labelConvertWillGet');

  labelConvertTransanctionFee() =>
      Intl.message('Transanction Fee:', name: 'labelConvertTransanctionFee');

  toolbarWidgetsTitle() =>
      Intl.message('Components', name: 'toolbarWidgetsTitle');

  toolbarSharePasshpraseQr() =>
      Intl.message('View Passphrase', name: 'toolbarSharePasshpraseQr');

  /// -- GENERIC ITEMS
  String get cancel {
    return Intl.message('Cancel', desc: 'dialog_cancel', name: 'cancel');
  }

  String get close {
    return Intl.message('Close', desc: 'dialog_close', name: 'close');
  }

  String get confirm {
    return Intl.message('Confirm', desc: 'dialog_confirm', name: 'confirm');
  }

  String get no {
    return Intl.message('No', desc: 'intro_new_wallet_backup_no', name: 'no');
  }

  String get yes {
    return Intl.message('Yes',
        desc: 'intro_new_wallet_backup_yes', name: 'yes');
  }

  String get onStr {
    return Intl.message('On', desc: 'generic_on', name: 'onStr');
  }

  String get off {
    return Intl.message('Off', desc: 'generic_off', name: 'off');
  }

  String get send {
    return Intl.message('Send', desc: 'home_send_cta', name: 'send');
  }

  String get receive {
    return Intl.message('Receive', desc: 'home_receive_cta', name: 'receive');
  }

  String get sent {
    return Intl.message('Sent', desc: 'history_sent', name: 'sent');
  }

  String get received {
    return Intl.message('Received', desc: 'history_received', name: 'received');
  }

  String get transactions {
    return Intl.message('Transactions',
        desc: 'transaction_header', name: 'transactions');
  }

  String get addressCopied {
    return Intl.message('Address Copied',
        desc: 'receive_copied', name: 'addressCopied');
  }

  String get copyAddress {
    return Intl.message('Copy Address',
        desc: 'receive_copy_cta', name: 'copyAddress');
  }

  String get addressShare {
    return Intl.message('Share Address',
        desc: 'receive_share_cta', name: 'addressShare');
  }

  String get addressHint {
    return Intl.message('Enter Address',
        desc: 'send_address_hint', name: 'addressHint');
  }

  String get seed {
    return Intl.message('Seed',
        desc: 'intro_new_wallet_seed_header', name: 'seed');
  }

  String get seedInvalid {
    return Intl.message('Seed is Invalid',
        desc: 'intro_seed_invalid', name: 'seedInvalid');
  }

  String get seedCopied {
    return Intl.message(
        'Seed Copied to Clipboard\nIt is pasteable for 2 minutes.',
        desc: 'intro_new_wallet_seed_copied',
        name: 'seedCopied');
  }

  String get scanQrCode {
    return Intl.message('Scan QR Code',
        desc: 'send_scan_qr', name: 'scanQrCode');
  }

  String get contactsImportErr {
    return Intl.message('Failed to import contacts',
        desc: 'contact_import_error', name: 'contactsImportErr');
  }

  String get viewDetails {
    return Intl.message("View Details",
        desc: "transaction_details", name: 'viewDetails');
  }

  String get qrInvalidSeed {
    return Intl.message("QR code does not contain a valid seed or private key",
        desc: "qr_invalid_seed", name: 'qrInvalidSeed');
  }

  String get qrInvalidAddress {
    return Intl.message("QR code does not contain a valid destination",
        desc: "qr_invalid_address", name: 'qrInvalidAddress');
  }

  String get qrInvalidPermissions {
    return Intl.message("Please Grant Camera Permissions to scan QR Codes",
        desc: "User did not grant camera permissions to the app",
        name: "qrInvalidPermissions");
  }

  String get qrUnknownError {
    return Intl.message("Could not Read QR Code",
        desc: "An unknown error occurred with the QR scanner",
        name: "qrUnknownError");
  }

  /// -- END GENERIC ITEMS
  /// -- CONTACT ITEMS
  String get removeContact {
    return Intl.message('Remove Contact',
        desc: 'contact_remove_btn', name: 'removeContact');
  }

  String get removeContactConfirmation {
    return Intl.message('Are you sure you want to delete %1?',
        desc: 'contact_remove_sure', name: 'removeContactConfirmation');
  }

  String get contactHeader {
    return Intl.message('Contact',
        desc: 'contact_view_header', name: 'contactHeader');
  }

  String get contactsHeader {
    return Intl.message('Contacts',
        desc: 'contact_header', name: 'contactsHeader');
  }

  String get addContact {
    return Intl.message('Add Contact',
        desc: 'contact_add_button', name: 'addContact');
  }

  String get contactNameHint {
    return Intl.message('Enter a Name @',
        desc: 'contact_name_hint', name: 'contactNameHint');
  }

  String get contactInvalid {
    return Intl.message("Invalid Contact Name",
        desc: 'contact_invalid_name', name: 'contactInvalid');
  }

  String get noContactsExport {
    return Intl.message("There's no contacts to export.",
        desc: 'contact_export_none', name: 'noContactsExport');
  }

  String get noContactsImport {
    return Intl.message("No new contacts to import.",
        desc: 'contact_import_none', name: 'noContactsImport');
  }

  String get contactsImportSuccess {
    return Intl.message("Sucessfully imported %1 contacts.",
        desc: 'contact_import_success', name: 'contactsImportSuccess');
  }

  String get contactAdded {
    return Intl.message("%1 added to contacts.",
        desc: 'contact_added', name: 'contactAdded');
  }

  String get contactRemoved {
    return Intl.message("%1 has been removed from contacts!",
        desc: 'contact_removed', name: 'contactRemoved');
  }

  String get contactNameMissing {
    return Intl.message("Choose a Name for this Contact",
        desc: 'contact_name_missing', name: 'contactNameMissing');
  }

  String get contactExists {
    return Intl.message("Contact Already Exists",
        desc: 'contact_name_exists', name: 'contactExists');
  }

  /// -- END CONTACT ITEMS
  /// -- INTRO ITEMS
  String get backupYourSeed {
    return Intl.message('Backup your seed',
        desc: 'intro_new_wallet_seed_backup_header', name: 'backupYourSeed');
  }

  String get backupSeedConfirm {
    return Intl.message('Are you sure that you backed up your wallet seed?',
        desc: 'intro_new_wallet_backup', name: 'backupSeedConfirm');
  }

  String get seedBackupInfo {
    return Intl.message(
        "Below is your wallet's seed. It is crucial that you backup your seed and never store it as plaintext or a screenshot.",
        desc: 'intro_new_wallet_seed',
        name: 'seedBackupInfo');
  }

  String get copySeed {
    return Intl.message("Copy Seed", desc: 'copy_seed_btn', name: 'copySeed');
  }

  String get seedCopiedShort {
    return Intl.message("Seed Copied",
        desc: 'seed_copied_btn', name: 'seedCopiedShort');
  }

  String get importSeed {
    return Intl.message("Import Seed",
        desc: 'intro_seed_header', name: 'importSeed');
  }

  String get importSeedHint {
    return Intl.message("Please enter your seed below.",
        desc: 'intro_seed_info', name: 'importSeedHint');
  }

  String get welcomeText {
    return Intl.message(
        "Welcome to Natrium. To begin, you may create a new wallet or import an existing one.",
        desc: 'intro_welcome_title',
        name: 'welcomeText');
  }

  String get newWallet {
    return Intl.message("New Wallet",
        desc: 'intro_welcome_new_wallet', name: 'newWallet');
  }

  String get importWallet {
    return Intl.message("Import Wallet",
        desc: 'intro_welcome_have_wallet', name: 'importWallet');
  }

  /// -- END INTRO ITEMS
  /// -- SEND ITEMS
  String get sentTo {
    return Intl.message("Sent To", desc: 'sent_to', name: 'sentTo');
  }

  String get sending {
    return Intl.message("Sending", desc: 'send_sending', name: 'sending');
  }

  String get to {
    return Intl.message("To", desc: 'send_to', name: 'to');
  }

  String get sendAmountConfirm {
    return Intl.message("Send %1 NANO",
        desc: 'send_pin_description', name: 'sendAmountConfirm');
  }

  String get sendAmountConfirmPin {
    return sendAmountConfirm;
  }

  String get sendError {
    return Intl.message("An error occured. Try again later.",
        desc: 'send_generic_error', name: 'sendError');
  }

  String get mantaError {
    return Intl.message("Couldn't Verify Request",
        desc:
            'Was unable to verify the manta/appia payment request (from scanning QR code, etc.)',
        name: 'mantaError');
  }

  String get enterAmount {
    return Intl.message("Enter Amount",
        desc: 'send_amount_hint', name: 'enterAmount');
  }

  String get enterAddress {
    return Intl.message("Enter Address",
        desc: 'enter_address', name: 'enterAddress');
  }

  String get invalidAddress {
    return Intl.message("Address entered was invalid",
        desc: 'send_invalid_address', name: 'invalidAddress');
  }

  String get addressMising {
    return Intl.message("Please Enter an Address",
        desc: 'send_enter_address', name: 'addressMising');
  }

  String get amountMissing {
    return Intl.message("Please Enter an Amount",
        desc: 'send_enter_amount', name: 'amountMissing');
  }

  String get minimumSend {
    return Intl.message("Minimum send amount is %1 NANO",
        desc: 'send_minimum_error', name: 'minimumSend');
  }

  String get insufficientBalance {
    return Intl.message("Insufficient Balance",
        desc: 'send_insufficient_balance', name: 'insufficientBalance');
  }

  String get sendFrom {
    return Intl.message("Send From", desc: 'send_title', name: 'sendFrom');
  }

  /// -- END SEND ITEMS
  /// -- PIN SCREEN
  String get pinCreateTitle {
    return Intl.message("Create a 6-digit pin",
        desc: 'pin_create_title', name: 'pinCreateTitle');
  }

  String get pinConfirmTitle {
    return Intl.message("Confirm your pin",
        desc: 'pin_confirm_title', name: 'pinConfirmTitle');
  }

  String get pinEnterTitle {
    return Intl.message("Enter pin",
        desc: 'pin_enter_title', name: 'pinEnterTitle');
  }

  String get pinConfirmError {
    return Intl.message("Pins do not match",
        desc: 'pin_confirm_error', name: 'pinConfirmError');
  }

  String get pinInvalid {
    return Intl.message("Invalid pin entered",
        desc: 'pin_error', name: 'pinInvalid');
  }

  /// -- END PIN SCREEN
  /// -- SETTINGS ITEMS
  String get themeHeader {
    return Intl.message("Theme", desc: 'theme_header', name: 'themeHeader');
  }

  String get changeRepButton {
    return Intl.message("Change",
        desc: 'change_representative_change', name: 'changeRepButton');
  }

  String get changeRepAuthenticate {
    return Intl.message("Change Representative",
        desc: 'settings_change_rep', name: 'changeRepAuthenticate');
  }

  String get currentlyRepresented {
    return Intl.message("Currently Represented By",
        desc: 'change_representative_current_header',
        name: 'currentlyRepresented');
  }

  String get changeRepSucces {
    return Intl.message("Representative Changed Successfully",
        desc: 'change_representative_success', name: 'changeRepSucces');
  }

  String get repInfoHeader {
    return Intl.message("What is a representative?",
        desc: 'change_representative_info_header', name: 'repInfoHeader');
  }

  String get repInfo {
    return Intl.message(
        "A representative is an account that votes for network consensus. Voting power is weighted by balance, you may delegate your balance to increase the voting weight of a representative you trust. Your representative does not have spending power over your funds. You should choose a representative that has little downtime and is trustworthy.",
        desc: 'change_representative_info',
        name: 'repInfo');
  }

  String get pinRepChange {
    return Intl.message("Enter PIN to change representative.",
        desc: 'change_representative_pin', name: 'pinRepChange');
  }

  String get changeRepHint {
    return Intl.message("Enter New Representative",
        desc: 'change_representative_hint', name: 'changeRepHint');
  }

  String get representatives {
    return Intl.message("Representatives",
        desc: 'representatives', name: 'representatives');
  }

  String get pickFromList {
    return Intl.message("Pick From a List",
        desc: 'pick rep from list', name: 'pickFromList');
  }

  String get votingWeight {
    return Intl.message("Voting Weight",
        desc: 'Representative Voting Weight', name: 'votingWeight');
  }

  String get uptime {
    return Intl.message("Uptime", desc: 'Rep uptime', name: 'uptime');
  }

  String get authMethod {
    return Intl.message("Authentication Method",
        desc: 'settings_disable_fingerprint', name: 'authMethod');
  }

  String get pinMethod {
    return Intl.message("PIN", desc: 'settings_pin_method', name: 'pinMethod');
  }

  String get privacyPolicy {
    return Intl.message("Privacy Policy",
        desc: 'settings_privacy_policy', name: 'privacyPolicy');
  }

  String get biometricsMethod {
    return Intl.message("Biometrics",
        desc: 'settings_fingerprint_method', name: 'biometricsMethod');
  }

  String get currency {
    return Intl.message("Currency",
        desc: 'A settings menu item for changing currency', name: 'currency');
  }

  String get changeCurrency {
    return Intl.message("Change Currency",
        desc: 'settings_local_currency', name: 'changeCurrency');
  }

  String get language {
    return Intl.message("Language",
        desc: 'settings_change_language', name: 'language');
  }

  String get shareNatrium {
    return Intl.message("Share Natrium",
        desc: 'settings_share', name: 'shareNatrium');
  }

  String get shareNatriumText {
    return Intl.message("Check out Natrium! A premier NANO mobile wallet!",
        desc: 'share_extra', name: 'shareNatriumText');
  }

  String get logout {
    return Intl.message("Logout", desc: 'settings_logout', name: 'logout');
  }

  String get rootWarning {
    return Intl.message(
        'It appears your device is "rooted", "jailbroken", or modified in a way that compromises security. It is recommended that you reset your device to its original state before proceeding.',
        desc:
            "Shown to users if they have a rooted Android device or jailbroken iOS device",
        name: 'rootWarning');
  }

  String get iUnderstandTheRisks {
    return Intl.message("I Understand the Risks",
        desc:
            "Shown to users if they have a rooted Android device or jailbroken iOS device",
        name: 'iUnderstandTheRisks');
  }

  String get exit {
    return Intl.message("Exit",
        desc: "Exit action, like a button", name: 'exit');
  }

  String get warning {
    return Intl.message("Warning",
        desc: 'settings_logout_alert_title', name: 'warning');
  }

  String get logoutDetail {
    return Intl.message(
        "Logging out will remove your seed and all Natrium-related data from this device. If your seed is not backed up, you will never be able to access your funds again",
        desc: 'settings_logout_alert_message',
        name: 'logoutDetail');
  }

  String get logoutAction {
    return Intl.message("Delete Seed and Logout",
        desc: 'settings_logout_alert_confirm_cta', name: 'logoutAction');
  }

  String get logoutAreYouSure {
    return Intl.message("Are you sure?",
        desc: 'settings_logout_warning_title', name: 'logoutAreYouSure');
  }

  String get logoutReassurance {
    return Intl.message(
        "As long as you've backed up your seed you have nothing to worry about.",
        desc: 'settings_logout_warning_message',
        name: 'logoutReassurance');
  }

  String get settingsHeader {
    return Intl.message("Settings",
        desc: 'settings_title', name: 'settingsHeader');
  }

  String get preferences {
    return Intl.message("Preferences",
        desc: 'settings_preferences_header', name: 'preferences');
  }

  String get manage {
    return Intl.message("Manage",
        desc: 'settings_manage_header', name: 'manage');
  }

  String get backupSeed {
    return Intl.message("Backup Seed",
        desc: 'settings_backup_seed', name: 'backupSeed');
  }

  String get fingerprintSeedBackup {
    return Intl.message("Authenticate to backup seed.",
        desc: 'settings_fingerprint_title', name: 'fingerprintSeedBackup');
  }

  String get pinSeedBackup {
    return Intl.message("Enter PIN to Backup Seed",
        desc: 'settings_pin_title', name: 'pinSeedBackup');
  }

  String get systemDefault {
    return Intl.message("System Default",
        desc: 'settings_default_language_string', name: 'systemDefault');
  }

  String get notifications {
    return Intl.message("Notifications",
        desc: 'notifications_settings', name: 'notifications');
  }

  String get notificationTitle {
    return Intl.message("Received %1 NANO",
        desc: 'notification_title', name: 'notificationTitle');
  }

  String get notificationBody {
    return Intl.message("Open Natrium to view this transaction",
        desc: 'notification_body', name: 'notificationBody');
  }

  String get notificationHeaderSupplement {
    return Intl.message("Tap to open",
        desc: 'notificaiton_header_suplement',
        name: 'notificationHeaderSupplement');
  }

  /// -- END SETTINGS ITEMS
  /// -- TRANSFER
  // Settings
  String get settingsTransfer {
    return Intl.message("Load from Paper Wallet",
        desc: 'settings_transfer', name: 'settingsTransfer');
  }

  String get transferError {
    return Intl.message(
        "An error has occurred during the transfer. Please try again later.",
        desc: 'transfer_error',
        name: 'transferError');
  }

  String get paperWallet {
    return Intl.message("Paper Wallet",
        desc: 'paper_wallet', name: 'paperWallet');
  }

  String get kaliumWallet {
    return Intl.message("Natrium Wallet",
        desc: 'kalium_wallet', name: 'kaliumWallet');
  }

  String get manualEntry {
    return Intl.message("Manual Entry",
        desc: 'transfer_manual_entry', name: 'manualEntry');
  }

  String get mnemonicPhrase {
    return Intl.message("Mnemonic Phrase",
        desc: 'mnemonic_phrase', name: 'mnemonicPhrase');
  }

  String get rawSeed {
    return Intl.message("Raw Seed", desc: 'raw_seed', name: 'rawSeed');
  }

  // Initial Screen

  String get transferHeader {
    return Intl.message("Transfer Funds",
        desc: 'transfer_header', name: 'transferHeader');
  }

  String get transfer {
    return Intl.message("Transfer", desc: 'transfer_btn', name: 'transfer');
  }

  String get transferManualHint {
    return Intl.message("Please enter the seed below.",
        desc: 'transfer_hint', name: 'transferManualHint');
  }

  String get transferIntro {
    return Intl.message(
        "This process will transfer the funds from a paper wallet to your Natrium wallet.\n\nTap the \"%1\" button to start.",
        desc: 'transfer_intro',
        name: 'transferIntro');
  }

  String get transferQrScanHint {
    return Intl.message("Scan a Nano \nseed or private key",
        desc: 'transfer_qr_scan_hint', name: 'transferQrScanHint');
  }

  String get transferQrScanError {
    return Intl.message("This QR code does not contain a valid seed.",
        desc: 'transfer_qr_scan_error', name: 'transferQrScanError');
  }

  String get transferNoFunds {
    return Intl.message("This seed does not have any NANO on it",
        desc: 'transfer_no_funds_toast', name: 'transferNoFunds');
  }

  // Confirm screen

  String get transferConfirmInfo {
    return Intl.message(
        "A wallet with a balance of %1 NANO has been detected.\n",
        desc: 'transfer_confirm_info_first',
        name: 'transferConfirmInfo');
  }

  String get transferConfirmInfoSecond {
    return Intl.message("Tap confirm to transfer the funds.\n",
        desc: 'transfer_confirm_info_second',
        name: 'transferConfirmInfoSecond');
  }

  String get transferConfirmInfoThird {
    return Intl.message("Transfer may take several seconds to complete.",
        desc: 'transfer_confirm_info_third', name: 'transferConfirmInfoThird');
  }

  String get transferLoading {
    return Intl.message("Transferring",
        desc: 'transfer_loading_text', name: 'transferLoading');
  }

  // Compelte screen

  String get transferComplete {
    return Intl.message(
        "%1 NANO successfully transferred to your Natrium Wallet.\n",
        desc: 'transfer_complete_text',
        name: 'transferComplete');
  }

  String get transferClose {
    return Intl.message("Tap anywhere to close the window.",
        desc: 'transfer_close_text', name: 'transferClose');
  }

  // -- END TRANSFER ITEMS

  // Scan

  String get scanInstructions {
    return Intl.message("Scan a Nano \naddress QR code",
        desc: 'scan_send_instruction_label', name: 'scanInstructions');
  }

  /// -- LOCK SCREEN
  String get unlockPin {
    return Intl.message("Enter PIN to Unlock Natrium",
        desc: 'unlock_kalium_pin', name: 'unlockPin');
  }

  String get unlockBiometrics {
    return Intl.message("Authenticate to Unlock Natrium",
        desc: 'unlock_kalium_bio', name: 'unlockBiometrics');
  }

  String get lockAppSetting {
    return Intl.message("Authenticate on Launch",
        desc: 'authenticate_on_launch', name: 'lockAppSetting');
  }

  String get locked {
    return Intl.message("Locked", desc: 'lockedtxt', name: 'locked');
  }

  String get unlock {
    return Intl.message("Unlock", desc: 'unlocktxt', name: 'unlock');
  }

  String get tooManyFailedAttempts {
    return Intl.message("Too many failed unlock attempts.",
        desc: 'fail_toomany_attempts', name: 'tooManyFailedAttempts');
  }

  /// -- END LOCK SCREEN
  /// -- SECURITY SETTINGS SUBMENU
  String get securityHeader {
    return Intl.message("Security",
        desc: 'security_header', name: 'securityHeader');
  }

  String get autoLockHeader {
    return Intl.message("Automatically Lock",
        desc: 'auto_lock_header', name: 'autoLockHeader');
  }

  String get xMinutes {
    return Intl.message("After %1 minutes",
        desc: 'after_minutes', name: 'xMinutes');
  }

  String get xMinute {
    return Intl.message("After %1 minute",
        desc: 'after_minute', name: 'xMinute');
  }

  String get instantly {
    return Intl.message("Instantly", desc: 'insantly', name: 'instantly');
  }

  String get setWalletPassword {
    return Intl.message("Set Wallet Password",
        desc: 'Allows user to encrypt wallet with a password',
        name: 'setWalletPassword');
  }

  String get setPassword {
    return Intl.message("Set Password",
        desc: 'A button that sets the wallet password', name: 'setPassword');
  }

  String get disableWalletPassword {
    return Intl.message("Disable Wallet Password",
        desc: 'Allows user to deencrypt wallet with a password',
        name: 'disableWalletPassword');
  }

  String get encryptionFailedError {
    return Intl.message("Failed to set a wallet password",
        desc: 'If encrypting a wallet raised an error',
        name: 'encryptionFailedError');
  }

  String get setPasswordSuccess {
    return Intl.message("Password has been set successfully",
        desc: 'Setting a Wallet Password was successful',
        name: 'setPasswordSuccess');
  }

  String get disablePasswordSuccess {
    return Intl.message("Password has been disabled",
        desc: 'Disabling a Wallet Password was successful',
        name: 'disablePasswordSuccess');
  }

  /// -- END SECURITY SETTINGS SUBMENU
  /// -- EXAMPLE HOME SCREEN CARDS
  String get exampleCardIntro {
    return Intl.message(
        "Welcome to Natrium. Once you receive NANO, transactions will show up like this:",
        desc: 'example_card_intro',
        name: 'exampleCardIntro');
  }

  String get exampleCardLittle {
    return Intl.message("A little",
        desc: 'example_card_little', name: 'exampleCardLittle');
  }

  String get exampleCardLot {
    return Intl.message("A lot of",
        desc: 'example_card_lot', name: 'exampleCardLot');
  }

  String get exampleCardTo {
    return Intl.message("to someone",
        desc: 'example_card_to', name: 'exampleCardTo');
  }

  String get exampleCardFrom {
    return Intl.message("from someone",
        desc: 'example_card_from', name: 'exampleCardFrom');
  }

  /// -- END EXAMPLE HOME SCREEN CARDS
  /// -- START MULTI-ACCOUNT
  String get defaultAccountName {
    return Intl.message("Main Account",
        desc: "Default account name", name: 'defaultAccountName');
  }

  String get defaultNewAccountName {
    return Intl.message("Account %1",
        desc: "Default new account name - e.g. Account 1",
        name: 'defaultNewAccountName');
  }

  String get newAccountIntro {
    return Intl.message(
        "This is your new account. Once you receive NANO, transactions will show up like this:",
        desc: 'Alternate account intro card',
        name: 'newAccountIntro');
  }

  String get account {
    return Intl.message("Account", desc: "Account text", name: 'account');
  }

  String get accounts {
    return Intl.message("Accounts", desc: "Accounts header", name: 'accounts');
  }

  String get addAccount {
    return Intl.message("Add Account",
        desc: "Default new account name - e.g. Account 1", name: 'addAccount');
  }

  String get hideAccountHeader {
    return Intl.message("Hide Account?",
        desc: "Confirmation dialog header", name: 'hideAccountHeader');
  }

  String get removeAccountText {
    return Intl.message(
        "Are you sure you want to hide this account? You can re-add it later by tapping the \"%1\" button.",
        desc: "Remove account dialog body",
        name: 'removeAccountText');
  }

  /// -- END MULTI-ACCOUNT
  String get tapToReveal {
    return Intl.message("Tap to reveal",
        desc: "Tap to reveal hidden content", name: 'tapToReveal');
  }

  String get tapToHide {
    return Intl.message("Tap to hide",
        desc: "Tap to hide content", name: 'tapToHide');
  }

  String get copied {
    return Intl.message("Copied",
        desc: "Copied (to clipboard)", name: 'copied');
  }

  String get copy {
    return Intl.message("Copy", desc: "Copy (to clipboard)", name: 'copy');
  }

  String get seedDescription {
    return Intl.message(
        "A seed bears the same information as a secret phrase, but in a machine-readable way. As long as you have one of them backed up, you'll have access to your funds.",
        desc: "Describing what a seed is",
        name: 'seedDescription');
  }

  String get importSecretPhrase {
    return Intl.message("Import Secret Phrase",
        desc: "Header for restoring using mnemonic",
        name: 'importSecretPhrase');
  }

  String get importSecretPhraseHint {
    return Intl.message(
        "Please enter your 24-word secret phrase below. Each word should be separated by a space.",
        desc: 'helper message for importing mnemnic',
        name: 'importSecretPhraseHint');
  }

  String get qrMnemonicError {
    return Intl.message("QR does not contain a valid secret phrase",
        desc: 'When QR does not contain a valid mnemonic phrase',
        name: 'qrMnemonicError');
  }

  String get mnemonicInvalidWord {
    return Intl.message("%1 is not a valid word",
        desc: 'A word that is not part of bip39', name: 'mnemonicInvalidWord');
  }

  String get mnemonicSizeError {
    return Intl.message("Secret phrase may only contain 24 words",
        desc: 'err', name: 'mnemonicSizeError');
  }

  String get secretPhrase {
    return Intl.message("Secret Phrase",
        desc: 'Secret (mnemonic) phrase', name: 'secretPhrase');
  }

  String get backupConfirmButton {
    return Intl.message("I've Backed It Up",
        desc: 'Has backed up seed confirmation button',
        name: 'backupConfirmButton');
  }

  String get secretInfoHeader {
    return Intl.message("Safety First!",
        desc: 'secret info header', name: 'secretInfoHeader');
  }

  String get secretInfo {
    return Intl.message(
        "In the next screen, you will see your secret phrase. It is a password to access your funds. It is crucial that you back it up and never share it with anyone.",
        desc: 'Description for seed',
        name: 'secretInfo');
  }

  String get secretWarning {
    return Intl.message(
        "If you lose your device or uninstall the application, you'll need your secret phrase or seed to recover your funds!",
        desc: 'Secret warning',
        name: 'secretWarning');
  }

  String get gotItButton {
    return Intl.message("Got It!",
        desc: 'Got It! Acknowledgement button', name: 'gotItButton');
  }

  String get ackBackedUp {
    return Intl.message(
        "Are you sure that you've backed up your secret phrase or seed?",
        desc: 'Ack backed up',
        name: 'ackBackedUp');
  }

  String get secretPhraseCopy {
    return Intl.message("Copy Secret Phrase",
        desc: 'Copy secret phrase to clipboard', name: 'secretPhraseCopy');
  }

  String get secretPhraseCopied {
    return Intl.message("Secret Phrase Copied",
        desc: 'Copied secret phrase to clipboard', name: 'secretPhraseCopied');
  }

  String get import {
    return Intl.message("Import", desc: "Generic import", name: 'import');
  }

  String get importSeedInstead {
    return Intl.message("Import Seed Instead",
        desc: "importSeedInstead", name: 'importSeedInstead');
  }

  String get switchToSeed {
    return Intl.message("Switch to Seed",
        desc: "switchToSeed", name: 'switchToSeed');
  }

  String get backupSecretPhrase {
    return Intl.message("Backup Secret Phrase",
        desc: 'backup seed', name: 'backupSecretPhrase');
  }

  /// -- SEED PROCESS
  /// -- END SEED PROCESS

  /// HINTS
  String get createPasswordHint {
    return Intl.message("Create a password",
        desc: 'A text field hint that tells the user to create a password',
        name: 'createPasswordHint');
  }

  String get confirmPasswordHint {
    return Intl.message("Confirm the password",
        desc: 'A text field hint that tells the user to confirm the password',
        name: 'confirmPasswordHint');
  }

  String get enterPasswordHint {
    return Intl.message("Enter your password",
        desc: 'A text field hint that tells the users to enter their password',
        name: 'enterPasswordHint');
  }

  String get passwordsDontMatch {
    return Intl.message("Passwords do not match",
        desc: 'An error indicating a password has been confirmed incorrectly',
        name: 'passwordsDontMatch');
  }

  String get passwordBlank {
    return Intl.message("Password cannot be empty",
        desc: 'An error indicating a password has been entered incorrectly',
        name: 'passwordBlank');
  }

  String get invalidPassword {
    return Intl.message("Invalid Password",
        desc: 'An error indicating a password has been entered incorrectly',
        name: 'invalidPassword');
  }

  /// HINTS END

  /// PARAGRAPS
  String get passwordWillBeRequiredToOpenParagraph {
    return Intl.message("This password will be required to open Natrium.",
        desc:
            'A paragraph that tells the users that the created password will be required to open Natrium.',
        name: 'passwordWillBeRequiredToOpenParagraph');
  }

  String get passwordNoLongerRequiredToOpenParagraph {
    return Intl.message("You will not need a password to open Natrium anymore.",
        desc:
            'An info paragraph that tells the user a password will no longer be needed to open Natrium',
        name: 'passwordNoLongerRequiredToOpenParagraph');
  }

  String get createPasswordFirstParagraph {
    return Intl.message(
        "You can create a password to add additional security to your wallet.",
        desc:
            'A paragraph that tells the users that they can create a password for additional security.',
        name: 'createPasswordFirstParagraph');
  }

  String get createPasswordSecondParagraph {
    return Intl.message(
        "Password is optional, and your wallet will be protected with your PIN or biometrics regardless.",
        desc:
            'A paragraph that tells the users that the password creation is optional and the wallet will be still protected with biometrics or PIN regardless.',
        name: 'createPasswordSecondParagraph');
  }

  /// PARAGRAPS END

  /// HEADERS
  String get createAPasswordHeader {
    return Intl.message("Create a password.",
        desc: 'A paragraph that tells the users to create a password.',
        name: 'createAPasswordHeader');
  }

  String get createPasswordSheetHeader {
    return Intl.message("Create",
        desc: 'Prompt user to create a new password',
        name: 'createPasswordSheetHeader');
  }

  String get disablePasswordSheetHeader {
    return Intl.message("Disable",
        desc: 'Prompt user to disable their password',
        name: 'disablePasswordSheetHeader');
  }

  String get requireAPasswordToOpenHeader {
    return Intl.message("Require a password to open Natrium?",
        desc:
            'A paragraph that asks the users if they would like a password to be required to open Natrium.',
        name: 'requireAPasswordToOpenHeader');
  }

  /// HEADERS END

  /// BUTTONS
  String get noSkipButton {
    return Intl.message("No, Skip",
        desc: 'A button that declines and skips the mentioned process.',
        name: 'noSkipButton');
  }

  String get yesButton {
    return Intl.message("Yes",
        desc: 'A button that accepts the mentioned process.',
        name: 'yesButton');
  }

  String get nextButton {
    return Intl.message("Next",
        desc: 'A button that goes to the next screen.', name: 'nextButton');
  }

  String get goBackButton {
    return Intl.message("Go Back",
        desc: 'A button that goes to the previous screen.',
        name: 'goBackButton');
  }

  String get supportButton {
    return Intl.message("Support",
        desc: 'A button to open up the live support window',
        name: 'supportButton');
  }

  String get liveSupportButton {
    return Intl.message("Support",
        desc: 'A button to open up the live support window',
        name: 'liveSupportButton');
  }

  /// BUTTONS END
  /// Live chat
  String get connectingHeader {
    return Intl.message("Connecting",
        desc:
            'A header to let the user now that Natrium is currently connecting to (or loading) live chat.',
        name: 'connectingHeader');
  }

  /// -- NON-TRANSLATABLE ITEMS
  String getBlockExplorerUrl(String hash) {
    return 'https://nanocrawler.cc/explorer/block/$hash';
  }

  String getAccountExplorerUrl(String account) {
    return 'https://nanocrawler.cc/explorer/account/$account';
  }

  String get eulaUrl {
    return 'https://avengemedia.github.io/kalium/eula_natrium.html';
  }

  String get privacyUrl {
    return 'https://avengemedia.github.io/kalium/privacy.html';
  }

  String localeEnglishItem() =>
      Intl.message('English', name: 'localeEnglishItem');

  String localeRussianItem() =>
      Intl.message('Russian', name: 'localeRussianItem');

  String generatingWalletMessage() =>
      Intl.message("Creating wallet", name: 'generatingWalletMessage');

  String toolbarRewards() => Intl.message('Rewards', name: 'toolbarRewards');

  String toolbarTitleShowPassphrase() =>
      Intl.message('Passphrase', name: 'toolbarTitleShowPassphrase');

  String errorCameraRestriction() =>
      Intl.message('The user did not grant the camera permission!',
          name: 'errorCameraRestriction');

  String noContactsTitle() =>
      Intl.message('No any contacts yet.', name: 'noContactsTitle');

  String flashOperationSuccess() =>
      Intl.message("Operation was completed succesfully",
          name: "flashOperationSuccess");
  String flashOperationFailed() =>
      Intl.message("Operation was completed with failure.",
          name: "flashOperationFailed");

  String flashFundsSended() =>
      Intl.message("Succesfully sended", name: "flashFundsSended");

  String flashAddressCopied() =>
      Intl.message("Address was copied to clipboard.",
          name: "flashAddressCopied");

  String accessBlocked() =>
      Intl.message("Access was blocked. Please, contact with administration",
          name: 'accessBlocked');

  String pushLinkWasCopied() =>
      Intl.message("Link was copied to clipboard.", name: 'pushLinkWasCopied');

  String sendFundsToPushWallet(num qty, String wallet) =>
      Intl.message('Send $qty funds to $wallet',
          name: 'sendFundsToPushWallet', args: [qty, wallet]);

  String copiedSuccesfullyMessage() =>
      Intl.message('Succesfully saved passhprase.',
          name: 'copiedSuccesfullyMessage');

  String flashIncorrectWordMessage() =>
      Intl.message("Incorrect word. Please try again",
          name: 'flashIncorrectWordMessage');

  String labelAgain() => Intl.message('Again', name: 'labelAgain');

  String hintSendedFrom() =>
      Intl.message("Sending from", name: 'hintSendedFrom');

  String errorInvalidInputsPush() =>
      Intl.message("Invalid values for push transaction",
          name: 'errorInvalidInputsPush');

  String successfullySavedPin() =>
      Intl.message("Succesfully saved PIN", name: 'successfullySavedPin');
  String errorOnPinInput() =>
      Intl.message("Invalid PIN", name: 'errorOnPinInput');

  String sharePushLink() => Intl.message("Share Push", name: 'sharePushLink');

  String authSuccess() =>
      Intl.message("Succesfully authenticated", name: 'authSuccess');

  String invalidInput() =>
      Intl.message("Invalid input. Check your params and try again",
          name: 'invalidInput');

  String chooseContactTitle() =>
      Intl.message("Choose contact", name: 'chooseContactTitle');

  String chooseAccountTitle() =>
      Intl.message("Choose account", name: 'chooseAccountTitle');

  String validateAddressError() =>
      Intl.message("Must be valid Minter address with Mx prefix",
          name: 'validateAddressError');

  String authenticateToViewTransaction() =>
      Intl.message("Please authenticate to view your transaction overview",
          name: 'authenticateToViewTransaction');

  String userAuthorized() =>
      Intl.message("User is authenticated", name: 'userAuthorized');

  String userNotAuthorized() =>
      Intl.message("User is not authorized", name: 'userNotAuthorized');

  String cannotRecoverAccount() => Intl.message("Cannot recover that account.",
      name: 'cannotRecoverAccount');

  String cardCurrencyMode() => Intl.message("Switched to currency values mode.",
      name: 'cardCurrencyMode');

  String cardUsdMode() =>
      Intl.message("Switched to USD mode", name: 'cardUsdMode');

  String noNotificationsAvailable() =>
      Intl.message("No any notifications were received",
          name: 'noNotificationsAvailable');

  String feedbackWasSended() =>
      Intl.message("Successfully sended. Thanks for feedback.",
          name: 'feedbackWasSended');

  String applyPushTitle() =>
      Intl.message("Apply Push funds", name: 'applyPushTitle');

  String applyPushBody(String coin, String qty, String address) =>
      Intl.message('Do you want to apply $qty $coin to address $address',
          args: [coin, qty, address], name: 'applyPushBody');

  String pushFundsSuccesfullyApplied() =>
      Intl.message("Funds were succesfully added to your wallet.",
          name: 'pushFundsSuccesfullyApplied');
  String pushFundsNotApplied() =>
      Intl.message("Applying of funds was finished with unexpectable error.",
          name: 'pushFundsNotApplied');

  String labelMinterWallet() =>
      Intl.message("Minter",
          name: 'labelMinterWallet');

  String labelErc20Wallet() =>
      Intl.message("ERC20 Wallet",
          name: 'labelErc20Wallet');

  String labelChooseAccType() =>
      Intl.message("Choose wallet type",
          name: 'labelChooseAccType');

 String  historyNoAccountError() =>
     Intl.message("Please, choose account to explore history.",
         name: 'historyNoAccountError');

 String  createWallet()  =>
     Intl.message("Create wallet",
         name: 'createWallet');

  String ercWalletNoExists()  =>
      Intl.message("No any ERC20 wallets detected.",
          name: 'ercWalletNoExists');

  String showErcPrivateKeyDrawerLabel()   =>
      Intl.message("ERC20 Keys",
          name: 'showErcPrivateKeyDrawerLabel');

  String privateKeyCopied()  =>
      Intl.message("Private key was copied",
          name: 'privateKeyCopied');

  String chooseCurrency() =>
      Intl.message("Choose currency",
          name: 'chooseCurrency');

 String instabugInfoMessage() => Intl.message("Shake device to open special bug report tool.", name: 'instabugInfoMessage');

  String cardLabelAddition() =>  Intl.message("Card ", name: 'cardLabelAddition');

  String invoiceStatusLabel() =>  Intl.message("Status:  ", name: 'invoiceStatusLabel');

  String selectFiatHint() =>  Intl.message('Choose currency to receive' ,
      name: 'selectFiatHint');

  String cardNumberLabel() =>  Intl.message('Card Number' ,
      name: 'cardNumberLabel');


  String amountWithdrawLabel() =>  Intl.message('Amount to withdraw' ,
      name: 'amountWithdrawLabel');
  String erc20ErrorHint() =>  Intl.message(  'Create new ERC20 Wallet in addresses to see balances', name: 'erc20ErrorHint');


  String  maximumQtyLabel(String maximum) =>
     Intl.message('Max amount is $maximum',
  args: [maximum], name: 'maximumQtyLabel');

  String coinWithdrawLabel() => Intl.message('Select coin to withdraw',
  name: 'coinWithdrawLabel');



  String noInvoicesLabel() => Intl.message('No any invoices',
      name: 'noInvoicesLabel');

  String createInvoiceBtn() => Intl.message('Create invoice',
      name: 'createInvoiceBtn');

  String createInvoiceTitle() => Intl.message('New invoice',
      name: 'createInvoiceTitle');
  String myInvoicesTitle() => Intl.message('My invoices',
      name: 'myInvoicesTitle');
  String chooseBlockchainLabel() => Intl.message('Choose blockchain',
      name: 'chooseBlockchainLabel');

  String coinTransfer() => Intl.message('Transfer', name: 'coinTransfer');

  String coinConvertation() => Intl.message('Exchange', name: 'coinConvertation');

  String coinDelegation() => Intl.message('Delegation', name: 'coinDelegation');
  String coinUnbounding() => Intl.message('Ubounding', name: 'coinUnbounding');

  String aboutBuildLabel() => Intl.message("About build", name: 'aboutBuildLabel');

  String labelBuildsAbout()=> Intl.message("About app", name: 'labelBuildsAbout');

  String labelBuildName() => Intl.message("Platform", name: 'labelBuildName');

  String labelBuildRunningOn() => Intl.message("Running on", name: 'labelBuildRunningOn');

  String labelBuildVersion()=> Intl.message("Version", name: 'labelBuildVersion');

  String labelBuildVersionCode() => Intl.message("Build number", name: 'labelBuildVersionCode');

  String labelBuildAppId() => Intl.message("App Id", name: 'labelBuildAppId');

  String newsCannotBeEmpty() => Intl.message( "Name cannot be empty",  name :"newsCannotBeEmpty");
  
  


}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
