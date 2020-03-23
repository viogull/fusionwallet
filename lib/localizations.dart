import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';


class AppLocalizations {

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });

  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }


  // Return localized string

  appName() => Intl.message(
      'Fusion',
      name: 'appName'
  );


  buttonCreateAccount() => Intl.message(
    'Create account',
    name: 'buttonCreateAccount'
  );

    buttonRecoverFromPassphrase() => Intl.message(
      'Recover account from passphrase',
      name: 'buttonRecoverFromPassphrase'
     );


     labelAlreadyHaveAccount() => Intl.message(
      'Already have an account?',
      name: 'labelAlreadyHaveAccount'
     );



     toolbarChoosePassTitle () => Intl.message(
       'Choose password',
       name: 'toolbarChoosePassTitle'
     );


     labelChoosePassSubtitle() => Intl.message(
       'Choose a six digit password',
       name: 'labelChoosePassSubtitle'
     );

    labelChoosePassVerifySubtitle() => Intl.message(
      'Enter the same six digits',
      name: 'labelChoosePassVerifySubtitle'
  );


  labelEnableBiometricTitle() => Intl.message(
      'Enable Touch ID/Face ID',
      name: 'labelEnableBiometricTitle'
  );

  labelEnableBiometricSubtitle() => Intl.message(
      'We recommend this for improved security',
      name: 'labelEnableBiometricSubtitle'
  );


  labelYes() => Intl.message(
    'Yes',
    name: 'labelYes'
  );

  labelNo() => Intl.message(
    'No',
    name: 'labelNo'
  );


  toolbarNewAccountTitle() => Intl.message(
    'New Account',
    name: 'toolbarNewAccountTitle'
  );

  labelBackupPassphraseSubtitle() => Intl.message(
    'Back up this Passphrase',
    name: 'labelBackupPassphraseSubtitle'
  );

  buttonVerifyRecoveryPhrase() => Intl.message(
    'Verify recovery phrase',
    name: 'buttonVerifyRecoveryPhrase'
  );


  buttonShare() => Intl.message(
    'Share',
    name: 'buttonShare'
  );


  labelBackupPassphraseCaption() => Intl.message(
    'In order to access this accout if you lose this device, ciopy or print this phrase and keep it someplace safe.',
    name: 'labelBackupPassphraseCaption'
  );


  labelQuestionIndicatorTitle(String current, String total) => Intl.message(
    'Question $current of $total',
    args: [current, total],
    name: 'labelQuestionIndicatorTitle'
  );

  labelWordIndicatorSubtitle(String position) => Intl.message(
      'Select the $position word of your passphrase',
      args: [position],
      name: 'labelWordIndicatorSubtitle'
  );


  toastTryAgain() => Intl.message(
    'Please, try again',
    name: 'toastTryAgain'
  );


  popupPassVerifiedTitle() => Intl.message(
    'Passphrase Verified',
    name: 'popupPassVerifiedTitle'
  );


  popupPassVerifiedBody() => Intl.message(
    'Your passphrase has been verified. Make sure that you have backed it up as you will needit to recover your account.',
    name: 'popupPassVerifiedBody'
  );


  labelOk() => Intl.message(
    'OK',
    name: 'labelOk'
  );

  inputAccountNameHelperText() => Intl.message(
    'Account Name',
    name: 'inputAccountNameHelperText'
  );

  inputAccountNameHintText() => Intl.message(
      'Please, name your account',
      name: 'inputAccountNameHintText'
  );

  checkboxTermsConditions() => Intl.message(
      'I agree with terms&conditions',
      name: 'checkboxTermsConditions'
  );

  buttonNext() => Intl.message(
      'Next',
      name: 'buttonNext'
  );


  toolbarTermsConditionsTitle() => Intl.message(
      'Terms and Conditions',
      name: 'toolbarTermsConditionsTitle'
  );


  toolbarRecoverFromSeedTitle() => Intl.message(
      'Recover from seed',
      name: 'toolbarRecoverFromSeedTitle'
  );


  inputEnterScanPasshpraseHintText() => Intl.message(
      'Enter passphrase or scan QR',
      name: 'inputEnterScanPasshpraseHintText'
  );


  buttonVerify() => Intl.message(
      'Verify',
      name: 'buttonVerify'
  );


  toolbarScanQrTitle() => Intl.message(
      'Scan QR',
      name: 'toolbarScanQrTitle'
  );


  buttonClose() => Intl.message(
      'Close',
      name: 'buttonClose'
  );

  popupAccVerificationWelcomeText() => Intl.message(
      'Welcome to Algorand! Your account is ready to use.',
      name: 'popupAccVerificationWelcomeText'
  );


  labelUnlockTitle() => Intl.message(
    'Unlock',
    name: 'labelUnlockTitle'
  );


  buttonLogOut() => Intl.message(
      'Log out',
      name: 'buttonLogOut'
  );


  labelUnlockSubtitle() => Intl.message(
      'Enter six digit pin',
      name: 'labelUnlockSubtitle'
  );


  labelTapToCopy() => Intl.message(
      'Tap to copy',
      name: 'labelTapToCopy'
  );


  toolbarViewPasshraseTitle() => Intl.message(
      'View Passphrase',
      name: 'toolbarViewPasshraseTitle'
  );


  buttonSend() => Intl.message(
      'Send',
      name: 'buttonSend'
  );


  buttonRequest() => Intl.message(
      'Request',
      name: 'buttonRequest'
  );


  buttonDelegate() => Intl.message(
      'Delegate',
      name: 'buttonDelegate'
  );


  buttonUnbound() => Intl.message(
      'Unbound',
      name: 'buttonUnbound'
  );



  buttonPush() => Intl.message(
      'Push',
      name: 'buttonPush'
  );

  labelCryptoAvailable() => Intl.message(
      'Cryptocurrency Available',
      name: 'labelCryptoAvailable'
  );

  labelTotalReward() => Intl.message(
      'Total Rewards Earned',
      name: 'labelTotalReward'
  );

  labelTransanctionsHistoryTitle() => Intl.message(
      'Transanctions History',
      name: 'labelTransanctionsHistoryTitle'
  );


  navigationLabelAccounts() => Intl.message(
      'Accounts',
      name: 'navigationLabelAccounts'
  );

  navigationLabelExchange() => Intl.message(
      'Exchange',
      name: 'navigationLabelExchange'
  );

  navigationItemContacts() => Intl.message(
      'Contacts',
      name: 'navigationItemContacts'
  );

  navigationItemHistory() => Intl.message(
      'History',
      name: 'navigationItemHistory'
  );


  navigationItemSettings() => Intl.message(
      'Settings',
      name: 'navigationItemSettings'
  );



  menuItemShowQR() => Intl.message(
      'Show QR and Address',
      name: 'menuItemShowQR'
  );

  menuItemSetDefaults() => Intl.message(
      'Set as defaults',
      name: 'menuItemSetDefaults'
  );

  menuItemViewPassphrase() => Intl.message(
      'View Passphrase',
      name: 'menuItemViewPassphrase'
  );


  menuItemEditAccountName() => Intl.message(
      'Edit Account Name',
      name: 'menuItemEditAccountName'
  );

  menuItemRemoveAccount() => Intl.message(
      'Remove Account',
      name: 'menuItemRemoveAccount'
  );


  menuItemWithdrawFunds() => Intl.message(
      'Withdraw funds',
      name: 'menuItemWithdrawFunds'
  );

  menuItemReferalLink() => Intl.message(
      'Referal link',
      name: 'menuItemReferalLink'
  );


  labelTotalRewardTitle() => Intl.message(
      'Total Rewards Earned',
      name: 'labelTotalRewardTitle'
  );

  labelPendingRewardTitle() => Intl.message(
      'Pending Rewards',
      name: 'labelPendingRewardTitle'
  );

  labelPendingRewardSubtitle() => Intl.message(
      'Pending rewards become confirmed when you send or receive BIP',
      name: 'labelPendingRewardSubtitle'
  );

  labelRewardsCaption() => Intl.message(
      'For more information on Fusion Rewards, visit our FAQ',
      name: 'labelRewardsCaption'
  );

  buttonPreview() => Intl.message(
      'Preview',
      name: 'buttonPreview'
  );


  labelFrom() => Intl.message(
      'From',
      name: 'labelFrom'
  );

  labelTo() => Intl.message(
      'To',
      name: 'labelTo'
  );

  labelAmount() => Intl.message(
      'Amount',
      name: 'labelAmount'
  );


  labelAddress() => Intl.message(
      'Address',
      name: 'labelAddress'
  );

  labelMyContacts() => Intl.message(
      'My Contacts',
      name: 'labelMyContacts'
  );


  labelContacts() => Intl.message(
      'Contacts',
      name: 'labelContacts'
  );


  labelScanQr() => Intl.message(
      'Scan QR',
      name: 'labelScanQr'
  );


  toolbarSendTitle() => Intl.message(
      'Send funds',
      name: 'toolbarSendTitle'
  );

  inputMaxAmountSuffix() => Intl.message(
      'MAX',
      name: 'inputMaxAmountSuffix'
  );

  inputAddressHint() => Intl.message(
      'Enter address',
      name: 'inputAddressHint'
  );

  inputFundsStakeHint() => Intl.message(
      'Stake',
      name: 'inputFundsStakeHint'
  );

  labelSender() => Intl.message(
      'Sender',
      name: 'labelSender'
  );

  labelReceiver() => Intl.message(
    'Receiver',
    name: 'labelReceiver'
  );

  labelPubkeyOrDomain() => Intl.message(
      'Public key or domain',
      name: 'labelPubkeyOrDomain'
  );

  labelCoin() => Intl.message(
      'Coin',
      name: 'labelCoin'
  );

  labelName() => Intl.message(
      'Name',
      name: 'labelName'
  );

  popupRemoveAccountTitle() => Intl.message(
      'Remove account',
      name: 'popupRemoveAccountTitle'
  );

  popupRemoveAccountBody() => Intl.message(
      'You are about to remove an account. Are you sure you want to proceed with choice?',
      name: 'popupRemoveAccountBody'
  );

  labelCancel() => Intl.message(
      'Cancel',
      name: 'labelCancel'
  );

  labelRemove() => Intl.message(
      'Remove',
      name: 'labelRemove'
  );

  labelSave() => Intl.message(
      'Save',
      name: 'labelSave'
  );

  inputEditAccountNameTitle() => Intl.message(
      'Edit Account Name',
      name: 'inputEditAccountNameTitle'
  );

  inputEditAccountNameHint() => Intl.message(
      'Please, name your account',
      name: 'inputEditAccountNameHint'
  );

  toolbarHistoryTitle() => Intl.message(
      'History',
      name: 'toolbarHistoryTitle'
  );

  labelAccount() => Intl.message(
      'Account:',
      name: 'labelAccount'
  );

  labelStartDate() => Intl.message(
      'Start Date',
      name: 'labelStartDate'
  );

  labelEndDate() => Intl.message(
      'End Date',
      name: 'labelEndDate'
  );


  buttonViewResults() => Intl.message(
      'View results',
      name: 'buttonViewResults'
  );


  settingsItemUiTheme() => Intl.message(
      'Dark/Light Theme',
      name: 'settingsItemUiTheme'
  );

  settingsItemChgPassword() => Intl.message(
      'Set/Change password',
      name: 'settingsItemChgPassword'
  );

  settingsItemBiometricFeature() => Intl.message(
      'Touch ID/Face ID',
      name: 'settingsItemBiometricFeature'
  );

  settingsItemNotifications() => Intl.message(
      'Notifications',
      name: 'settingsItemNotifications'
  );

  settingsItemShowRewards() => Intl.message(
      'Show rewards',
      name: 'settingsItemShowRewards'
  );

  settingsItemLanguage() => Intl.message(
      'Language',
      name: 'settingsItemLanguage'
  );

  settingsItemSendFeedback() => Intl.message(
      'Send feedback',
      name: 'settingsItemSendFeedback'
  );

  settingsItemFaq() => Intl.message(
      'FAQ',
      name: 'settingsItemFaq'
  );

  labelFeedbackNoteTitle() => Intl.message(
      'Note',
      name: 'labelFeedbackNoteTitle'
  );

  inputFeedbackCommentHint() => Intl.message(
      'What is on your mind',
      name: 'inputFeedbackCommentHint'
  );

  labelFeedbackEmailSubtitle() => Intl.message(
      'Email (optionally)',
      name: 'labelFeedbackEmailSubtitle'
  );

  toolbarContactsTitle() => Intl.message(
      'Contacts',
      name: 'toolbarContactsTitle'
  );

  toolbarAddContactTitle() => Intl.message(
      'Add Contact',
      name: 'toolbarAddContactTitle'
  );

  inputSearchContactHint() => Intl.message(
      'Search contacts',
      name: 'inputSearchContactHint'
  );

  labelContactsNotFoundError() => Intl.message(
      'No Contact found',
      name: 'labelContactsNotFoundError'
  );

  labelAddContactName() => Intl.message(
      'Name',
      name: 'labelAddContactName'
  );

  labelAddContactAddress() => Intl.message(
      'Address',
      name: 'labelAddContactAddress'
  );

  inputAddContactNameHint()  => Intl.message(
      'Contact Name',
      name: 'inputAddContactNameHint'
  );

  inputAddContactAddressHint() => Intl.message(
      'Enter address',
      name: 'inputAddContactAddressHint'
  );

  buttonAddContact() => Intl.message(
      'Add contact',
      name: 'buttonAddContact'
  );


  toolbarExchangeTitle() => Intl.message(
      'Exchange',
      name: 'toolbarExchangeTitle'
  );

  toolbarRateTitle() => Intl.message(
      'Rate',
      name: 'toolbarRateTitle'
  );

  toolbarConvertTitle() => Intl.message(
      'Convert',
      name: 'toolbarConvertTitle'
  );

  labelExchangeCoins() => Intl.message(
      'My Coins',
      name: 'labelExchangeCoins'
  );

  buttonConvert() => Intl.message(
      'Convert',
      name: 'buttonConvert'
  );

  buttonRate() => Intl.message(
      'Rate',
      name: 'buttonRate'
  );

  buttonBuy() => Intl.message(
      'Buy',
      name: 'buttonBuy'
  );

  buttonSell() => Intl.message(
      'Sell',
      name: 'buttonSell'
  );

  labelExchangeUseCash() => Intl.message(
      'Use cash balance',
      name: 'labelExchangeUseCash'
  );

  labelExchangeSimplex()  => Intl.message(
      'Simplex',
      name: 'labelExchangeSimplex'
  );

  labelBuy() => Intl.message(
      'BUY',
      name: 'labelBuy'
  );

  labelSell() => Intl.message(
      'SELL',
      name: 'labelSell'
  );


  labelConvertCoinHave() => Intl.message(
      'Coin You have',
      name: 'labelConvertCoinHave'
  );

  labelConvertCoinWant() => Intl.message(
      'Coin you want',
      name: 'labelConvertCoinWant'
  );

  labelConvertWillGet() => Intl.message(
      'You will get approximztely',
      name: 'labelConvertWillGet'
  );

  labelConvertTransanctionFee() => Intl.message(
      'Transanction Fee:',
      name: 'labelConvertTransanctionFee'
  );



















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

