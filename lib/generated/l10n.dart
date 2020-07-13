// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Fusion`
  String get appName {
    return Intl.message(
      'Fusion',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get buttonCreateAccount {
    return Intl.message(
      'Create account',
      name: 'buttonCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Recover account from passphrase`
  String get buttonRecoverFromPassphrase {
    return Intl.message(
      'Recover account from passphrase',
      name: 'buttonRecoverFromPassphrase',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get labelAlreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'labelAlreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Choose password`
  String get toolbarChoosePassTitle {
    return Intl.message(
      'Choose password',
      name: 'toolbarChoosePassTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a six digit password`
  String get labelChoosePassSubtitle {
    return Intl.message(
      'Choose a six digit password',
      name: 'labelChoosePassSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the same six digits`
  String get labelChoosePassVerifySubtitle {
    return Intl.message(
      'Enter the same six digits',
      name: 'labelChoosePassVerifySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enable Touch ID/Face ID`
  String get labelEnableBiometricTitle {
    return Intl.message(
      'Enable Touch ID/Face ID',
      name: 'labelEnableBiometricTitle',
      desc: '',
      args: [],
    );
  }

  /// `We recommend this for improved security`
  String get labelEnableBiometricSubtitle {
    return Intl.message(
      'We recommend this for improved security',
      name: 'labelEnableBiometricSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get labelYes {
    return Intl.message(
      'Yes',
      name: 'labelYes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get labelNo {
    return Intl.message(
      'No',
      name: 'labelNo',
      desc: '',
      args: [],
    );
  }

  /// `New Account`
  String get toolbarNewAccountTitle {
    return Intl.message(
      'New Account',
      name: 'toolbarNewAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Back up this Passphrase`
  String get labelBackupPassphraseSubtitle {
    return Intl.message(
      'Back up this Passphrase',
      name: 'labelBackupPassphraseSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Verify recovery phrase`
  String get buttonVerifyRecoveryPhrase {
    return Intl.message(
      'Verify recovery phrase',
      name: 'buttonVerifyRecoveryPhrase',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get buttonShare {
    return Intl.message(
      'Share',
      name: 'buttonShare',
      desc: '',
      args: [],
    );
  }

  /// `In order to access this accout if you lose this device, ciopy or print this phrase and keep it someplace safe.`
  String get labelBackupPassphraseCaption {
    return Intl.message(
      'In order to access this accout if you lose this device, ciopy or print this phrase and keep it someplace safe.',
      name: 'labelBackupPassphraseCaption',
      desc: '',
      args: [],
    );
  }

  /// `Question {current} of {total}`
  String labelQuestionIndicatorTitle(Object current, Object total) {
    return Intl.message(
      'Question $current of $total',
      name: 'labelQuestionIndicatorTitle',
      desc: '',
      args: [current, total],
    );
  }

  /// `Select the {position}th word of your passphrase`
  String labelWordIndicatorSubtitle(Object position) {
    return Intl.message(
      'Select the ${position}th word of your passphrase',
      name: 'labelWordIndicatorSubtitle',
      desc: '',
      args: [position],
    );
  }

  /// `Please, try again`
  String get toastTryAgain {
    return Intl.message(
      'Please, try again',
      name: 'toastTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Passphrase Verified`
  String get popupPassVerifiedTitle {
    return Intl.message(
      'Passphrase Verified',
      name: 'popupPassVerifiedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your passphrase has been verified. Make sure that you have backed it up as you will needit to recover your account.`
  String get popupPassVerifiedBody {
    return Intl.message(
      'Your passphrase has been verified. Make sure that you have backed it up as you will needit to recover your account.',
      name: 'popupPassVerifiedBody',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get labelOk {
    return Intl.message(
      'OK',
      name: 'labelOk',
      desc: '',
      args: [],
    );
  }

  /// `Account Name`
  String get inputAccountNameHelperText {
    return Intl.message(
      'Account Name',
      name: 'inputAccountNameHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Please, name your account`
  String get inputAccountNameHintText {
    return Intl.message(
      'Please, name your account',
      name: 'inputAccountNameHintText',
      desc: '',
      args: [],
    );
  }

  /// `I agree with terms&conditions`
  String get checkboxTermsConditions {
    return Intl.message(
      'I agree with terms&conditions',
      name: 'checkboxTermsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get buttonNext {
    return Intl.message(
      'Next',
      name: 'buttonNext',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get toolbarTermsConditionsTitle {
    return Intl.message(
      'Terms and Conditions',
      name: 'toolbarTermsConditionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recover from seed`
  String get toolbarRecoverFromSeedTitle {
    return Intl.message(
      'Recover from seed',
      name: 'toolbarRecoverFromSeedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter passphrase or scan QR`
  String get inputEnterScanPasshpraseHintText {
    return Intl.message(
      'Enter passphrase or scan QR',
      name: 'inputEnterScanPasshpraseHintText',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get buttonVerify {
    return Intl.message(
      'Verify',
      name: 'buttonVerify',
      desc: '',
      args: [],
    );
  }

  /// `Passphrase QR`
  String get toolbarScanQrTitle {
    return Intl.message(
      'Passphrase QR',
      name: 'toolbarScanQrTitle',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get buttonClose {
    return Intl.message(
      'Close',
      name: 'buttonClose',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Algorand! Your account is ready to use.`
  String get popupAccVerificationWelcomeText {
    return Intl.message(
      'Welcome to Algorand! Your account is ready to use.',
      name: 'popupAccVerificationWelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Unlock`
  String get labelUnlockTitle {
    return Intl.message(
      'Unlock',
      name: 'labelUnlockTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get buttonLogOut {
    return Intl.message(
      'Log out',
      name: 'buttonLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Enter six digit pin`
  String get labelUnlockSubtitle {
    return Intl.message(
      'Enter six digit pin',
      name: 'labelUnlockSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap to copy`
  String get labelTapToCopy {
    return Intl.message(
      'Tap to copy',
      name: 'labelTapToCopy',
      desc: '',
      args: [],
    );
  }

  /// `View Passphrase`
  String get toolbarViewPasshraseTitle {
    return Intl.message(
      'View Passphrase',
      name: 'toolbarViewPasshraseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get buttonSend {
    return Intl.message(
      'Send',
      name: 'buttonSend',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get buttonRequest {
    return Intl.message(
      'Request',
      name: 'buttonRequest',
      desc: '',
      args: [],
    );
  }

  /// `Delegate`
  String get buttonDelegate {
    return Intl.message(
      'Delegate',
      name: 'buttonDelegate',
      desc: '',
      args: [],
    );
  }

  /// `Unbound`
  String get buttonUnbound {
    return Intl.message(
      'Unbound',
      name: 'buttonUnbound',
      desc: '',
      args: [],
    );
  }

  /// `Push`
  String get buttonPush {
    return Intl.message(
      'Push',
      name: 'buttonPush',
      desc: '',
      args: [],
    );
  }

  /// `Cryptocurrency Available`
  String get labelCryptoAvailable {
    return Intl.message(
      'Cryptocurrency Available',
      name: 'labelCryptoAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Total Rewards Earned`
  String get labelTotalReward {
    return Intl.message(
      'Total Rewards Earned',
      name: 'labelTotalReward',
      desc: '',
      args: [],
    );
  }

  /// `Transanctions History`
  String get labelTransanctionsHistoryTitle {
    return Intl.message(
      'Transanctions History',
      name: 'labelTransanctionsHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Accounts`
  String get navigationLabelAccounts {
    return Intl.message(
      'Accounts',
      name: 'navigationLabelAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Exchange`
  String get navigationLabelExchange {
    return Intl.message(
      'Exchange',
      name: 'navigationLabelExchange',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get navigationItemContacts {
    return Intl.message(
      'Contacts',
      name: 'navigationItemContacts',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get navigationItemHistory {
    return Intl.message(
      'History',
      name: 'navigationItemHistory',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get navigationItemSettings {
    return Intl.message(
      'Settings',
      name: 'navigationItemSettings',
      desc: '',
      args: [],
    );
  }

  /// `Show QR and Address`
  String get menuItemShowQR {
    return Intl.message(
      'Show QR and Address',
      name: 'menuItemShowQR',
      desc: '',
      args: [],
    );
  }

  /// `Set as defaults`
  String get menuItemSetDefaults {
    return Intl.message(
      'Set as defaults',
      name: 'menuItemSetDefaults',
      desc: '',
      args: [],
    );
  }

  /// `View Passphrase`
  String get menuItemViewPassphrase {
    return Intl.message(
      'View Passphrase',
      name: 'menuItemViewPassphrase',
      desc: '',
      args: [],
    );
  }

  /// `Edit Account Name`
  String get menuItemEditAccountName {
    return Intl.message(
      'Edit Account Name',
      name: 'menuItemEditAccountName',
      desc: '',
      args: [],
    );
  }

  /// `Remove Account`
  String get menuItemRemoveAccount {
    return Intl.message(
      'Remove Account',
      name: 'menuItemRemoveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw funds`
  String get menuItemWithdrawFunds {
    return Intl.message(
      'Withdraw funds',
      name: 'menuItemWithdrawFunds',
      desc: '',
      args: [],
    );
  }

  /// `Referal link`
  String get menuItemReferalLink {
    return Intl.message(
      'Referal link',
      name: 'menuItemReferalLink',
      desc: '',
      args: [],
    );
  }

  /// `Total Rewards Earned`
  String get labelTotalRewardTitle {
    return Intl.message(
      'Total Rewards Earned',
      name: 'labelTotalRewardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pending Rewards`
  String get labelPendingRewardTitle {
    return Intl.message(
      'Pending Rewards',
      name: 'labelPendingRewardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pending rewards become confirmed when you send or receive BIP`
  String get labelPendingRewardSubtitle {
    return Intl.message(
      'Pending rewards become confirmed when you send or receive BIP',
      name: 'labelPendingRewardSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `For more information on Fusion Rewards, visit our FAQ`
  String get labelRewardsCaption {
    return Intl.message(
      'For more information on Fusion Rewards, visit our FAQ',
      name: 'labelRewardsCaption',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get buttonPreview {
    return Intl.message(
      'Preview',
      name: 'buttonPreview',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get labelFrom {
    return Intl.message(
      'From',
      name: 'labelFrom',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get labelTo {
    return Intl.message(
      'To',
      name: 'labelTo',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get labelAmount {
    return Intl.message(
      'Amount',
      name: 'labelAmount',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get labelAddress {
    return Intl.message(
      'Address',
      name: 'labelAddress',
      desc: '',
      args: [],
    );
  }

  /// `My Contacts`
  String get labelMyContacts {
    return Intl.message(
      'My Contacts',
      name: 'labelMyContacts',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get labelContacts {
    return Intl.message(
      'Contacts',
      name: 'labelContacts',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR`
  String get labelScanQr {
    return Intl.message(
      'Scan QR',
      name: 'labelScanQr',
      desc: '',
      args: [],
    );
  }

  /// `Send funds`
  String get toolbarSendTitle {
    return Intl.message(
      'Send funds',
      name: 'toolbarSendTitle',
      desc: '',
      args: [],
    );
  }

  /// `MAX`
  String get inputMaxAmountSuffix {
    return Intl.message(
      'MAX',
      name: 'inputMaxAmountSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Enter address`
  String get inputAddressHint {
    return Intl.message(
      'Enter address',
      name: 'inputAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Stake`
  String get inputFundsStakeHint {
    return Intl.message(
      'Stake',
      name: 'inputFundsStakeHint',
      desc: '',
      args: [],
    );
  }

  /// `Sender`
  String get labelSender {
    return Intl.message(
      'Sender',
      name: 'labelSender',
      desc: '',
      args: [],
    );
  }

  /// `Receiver`
  String get labelReceiver {
    return Intl.message(
      'Receiver',
      name: 'labelReceiver',
      desc: '',
      args: [],
    );
  }

  /// `Public key or domain`
  String get labelPubkeyOrDomain {
    return Intl.message(
      'Public key or domain',
      name: 'labelPubkeyOrDomain',
      desc: '',
      args: [],
    );
  }

  /// `Coin`
  String get labelCoin {
    return Intl.message(
      'Coin',
      name: 'labelCoin',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get labelName {
    return Intl.message(
      'Name',
      name: 'labelName',
      desc: '',
      args: [],
    );
  }

  /// `Remove account`
  String get popupRemoveAccountTitle {
    return Intl.message(
      'Remove account',
      name: 'popupRemoveAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `You are about to remove an account. Are you sure you want to proceed with choice?`
  String get popupRemoveAccountBody {
    return Intl.message(
      'You are about to remove an account. Are you sure you want to proceed with choice?',
      name: 'popupRemoveAccountBody',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get labelCancel {
    return Intl.message(
      'Cancel',
      name: 'labelCancel',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get labelRemove {
    return Intl.message(
      'Remove',
      name: 'labelRemove',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get labelSave {
    return Intl.message(
      'Save',
      name: 'labelSave',
      desc: '',
      args: [],
    );
  }

  /// `Edit Account Name`
  String get inputEditAccountNameTitle {
    return Intl.message(
      'Edit Account Name',
      name: 'inputEditAccountNameTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please, name your account`
  String get inputEditAccountNameHint {
    return Intl.message(
      'Please, name your account',
      name: 'inputEditAccountNameHint',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get toolbarHistoryTitle {
    return Intl.message(
      'History',
      name: 'toolbarHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Account:`
  String get labelAccount {
    return Intl.message(
      'Account:',
      name: 'labelAccount',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get labelStartDate {
    return Intl.message(
      'Start Date',
      name: 'labelStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get labelEndDate {
    return Intl.message(
      'End Date',
      name: 'labelEndDate',
      desc: '',
      args: [],
    );
  }

  /// `View results`
  String get buttonViewResults {
    return Intl.message(
      'View results',
      name: 'buttonViewResults',
      desc: '',
      args: [],
    );
  }

  /// `Dark/Light Theme`
  String get settingsItemUiTheme {
    return Intl.message(
      'Dark/Light Theme',
      name: 'settingsItemUiTheme',
      desc: '',
      args: [],
    );
  }

  /// `Set/Change password`
  String get settingsItemChgPassword {
    return Intl.message(
      'Set/Change password',
      name: 'settingsItemChgPassword',
      desc: '',
      args: [],
    );
  }

  /// `Touch ID/Face ID`
  String get settingsItemBiometricFeature {
    return Intl.message(
      'Touch ID/Face ID',
      name: 'settingsItemBiometricFeature',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get settingsItemNotifications {
    return Intl.message(
      'Notifications',
      name: 'settingsItemNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Show rewards`
  String get settingsItemShowRewards {
    return Intl.message(
      'Show rewards',
      name: 'settingsItemShowRewards',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsItemLanguage {
    return Intl.message(
      'Language',
      name: 'settingsItemLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Send feedback`
  String get settingsItemSendFeedback {
    return Intl.message(
      'Send feedback',
      name: 'settingsItemSendFeedback',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get settingsItemFaq {
    return Intl.message(
      'FAQ',
      name: 'settingsItemFaq',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get labelFeedbackNoteTitle {
    return Intl.message(
      'Note',
      name: 'labelFeedbackNoteTitle',
      desc: '',
      args: [],
    );
  }

  /// `What is on your mind`
  String get inputFeedbackCommentHint {
    return Intl.message(
      'What is on your mind',
      name: 'inputFeedbackCommentHint',
      desc: '',
      args: [],
    );
  }

  /// `Email (optionally)`
  String get labelFeedbackEmailSubtitle {
    return Intl.message(
      'Email (optionally)',
      name: 'labelFeedbackEmailSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get toolbarContactsTitle {
    return Intl.message(
      'Contacts',
      name: 'toolbarContactsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Contact`
  String get toolbarAddContactTitle {
    return Intl.message(
      'Add Contact',
      name: 'toolbarAddContactTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search contacts`
  String get inputSearchContactHint {
    return Intl.message(
      'Search contacts',
      name: 'inputSearchContactHint',
      desc: '',
      args: [],
    );
  }

  /// `No Contact found`
  String get labelContactsNotFoundError {
    return Intl.message(
      'No Contact found',
      name: 'labelContactsNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get labelAddContactName {
    return Intl.message(
      'Name',
      name: 'labelAddContactName',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get labelAddContactAddress {
    return Intl.message(
      'Address',
      name: 'labelAddContactAddress',
      desc: '',
      args: [],
    );
  }

  /// `Contact Name`
  String get inputAddContactNameHint {
    return Intl.message(
      'Contact Name',
      name: 'inputAddContactNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter address`
  String get inputAddContactAddressHint {
    return Intl.message(
      'Enter address',
      name: 'inputAddContactAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Add contact`
  String get buttonAddContact {
    return Intl.message(
      'Add contact',
      name: 'buttonAddContact',
      desc: '',
      args: [],
    );
  }

  /// `Exchange`
  String get toolbarExchangeTitle {
    return Intl.message(
      'Exchange',
      name: 'toolbarExchangeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get toolbarRateTitle {
    return Intl.message(
      'Rate',
      name: 'toolbarRateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Convert`
  String get toolbarConvertTitle {
    return Intl.message(
      'Convert',
      name: 'toolbarConvertTitle',
      desc: '',
      args: [],
    );
  }

  /// `My Coins`
  String get labelExchangeCoins {
    return Intl.message(
      'My Coins',
      name: 'labelExchangeCoins',
      desc: '',
      args: [],
    );
  }

  /// `Convert`
  String get buttonConvert {
    return Intl.message(
      'Convert',
      name: 'buttonConvert',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get buttonRate {
    return Intl.message(
      'Rate',
      name: 'buttonRate',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buttonBuy {
    return Intl.message(
      'Buy',
      name: 'buttonBuy',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get buttonSell {
    return Intl.message(
      'Sell',
      name: 'buttonSell',
      desc: '',
      args: [],
    );
  }

  /// `Use cash balance`
  String get labelExchangeUseCash {
    return Intl.message(
      'Use cash balance',
      name: 'labelExchangeUseCash',
      desc: '',
      args: [],
    );
  }

  /// `Simplex`
  String get labelExchangeSimplex {
    return Intl.message(
      'Simplex',
      name: 'labelExchangeSimplex',
      desc: '',
      args: [],
    );
  }

  /// `BUY`
  String get labelBuy {
    return Intl.message(
      'BUY',
      name: 'labelBuy',
      desc: '',
      args: [],
    );
  }

  /// `SELL`
  String get labelSell {
    return Intl.message(
      'SELL',
      name: 'labelSell',
      desc: '',
      args: [],
    );
  }

  /// `Coin You have`
  String get labelConvertCoinHave {
    return Intl.message(
      'Coin You have',
      name: 'labelConvertCoinHave',
      desc: '',
      args: [],
    );
  }

  /// `Coin you want`
  String get labelConvertCoinWant {
    return Intl.message(
      'Coin you want',
      name: 'labelConvertCoinWant',
      desc: '',
      args: [],
    );
  }

  /// `You will get approximztely`
  String get labelConvertWillGet {
    return Intl.message(
      'You will get approximztely',
      name: 'labelConvertWillGet',
      desc: '',
      args: [],
    );
  }

  /// `Transanction Fee:`
  String get labelConvertTransanctionFee {
    return Intl.message(
      'Transanction Fee:',
      name: 'labelConvertTransanctionFee',
      desc: '',
      args: [],
    );
  }

  /// `Components`
  String get toolbarWidgetsTitle {
    return Intl.message(
      'Components',
      name: 'toolbarWidgetsTitle',
      desc: '',
      args: [],
    );
  }

  /// `View Passphrase`
  String get toolbarSharePasshpraseQr {
    return Intl.message(
      'View Passphrase',
      name: 'toolbarSharePasshpraseQr',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'dialog_cancel',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: 'dialog_close',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: 'dialog_confirm',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: 'intro_new_wallet_backup_no',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: 'intro_new_wallet_backup_yes',
      args: [],
    );
  }

  /// `On`
  String get onStr {
    return Intl.message(
      'On',
      name: 'onStr',
      desc: 'generic_on',
      args: [],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: 'generic_off',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: 'home_send_cta',
      args: [],
    );
  }

  /// `Receive`
  String get receive {
    return Intl.message(
      'Receive',
      name: 'receive',
      desc: 'home_receive_cta',
      args: [],
    );
  }

  /// `Sent`
  String get sent {
    return Intl.message(
      'Sent',
      name: 'sent',
      desc: 'history_sent',
      args: [],
    );
  }

  /// `Received`
  String get received {
    return Intl.message(
      'Received',
      name: 'received',
      desc: 'history_received',
      args: [],
    );
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: 'transaction_header',
      args: [],
    );
  }

  /// `Address Copied`
  String get addressCopied {
    return Intl.message(
      'Address Copied',
      name: 'addressCopied',
      desc: 'receive_copied',
      args: [],
    );
  }

  /// `Copy Address`
  String get copyAddress {
    return Intl.message(
      'Copy Address',
      name: 'copyAddress',
      desc: 'receive_copy_cta',
      args: [],
    );
  }

  /// `Share Address`
  String get addressShare {
    return Intl.message(
      'Share Address',
      name: 'addressShare',
      desc: 'receive_share_cta',
      args: [],
    );
  }

  /// `Enter Address`
  String get addressHint {
    return Intl.message(
      'Enter Address',
      name: 'addressHint',
      desc: 'send_address_hint',
      args: [],
    );
  }

  /// `Seed`
  String get seed {
    return Intl.message(
      'Seed',
      name: 'seed',
      desc: 'intro_new_wallet_seed_header',
      args: [],
    );
  }

  /// `Seed is Invalid`
  String get seedInvalid {
    return Intl.message(
      'Seed is Invalid',
      name: 'seedInvalid',
      desc: 'intro_seed_invalid',
      args: [],
    );
  }

  /// `Seed Copied to Clipboard\nIt is pasteable for 2 minutes.`
  String get seedCopied {
    return Intl.message(
      'Seed Copied to Clipboard\nIt is pasteable for 2 minutes.',
      name: 'seedCopied',
      desc: 'intro_new_wallet_seed_copied',
      args: [],
    );
  }

  /// `Scan QR Code`
  String get scanQrCode {
    return Intl.message(
      'Scan QR Code',
      name: 'scanQrCode',
      desc: 'send_scan_qr',
      args: [],
    );
  }

  /// `Failed to import contacts`
  String get contactsImportErr {
    return Intl.message(
      'Failed to import contacts',
      name: 'contactsImportErr',
      desc: 'contact_import_error',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: 'transaction_details',
      args: [],
    );
  }

  /// `QR code does not contain a valid seed or private key`
  String get qrInvalidSeed {
    return Intl.message(
      'QR code does not contain a valid seed or private key',
      name: 'qrInvalidSeed',
      desc: 'qr_invalid_seed',
      args: [],
    );
  }

  /// `QR code does not contain a valid destination`
  String get qrInvalidAddress {
    return Intl.message(
      'QR code does not contain a valid destination',
      name: 'qrInvalidAddress',
      desc: 'qr_invalid_address',
      args: [],
    );
  }

  /// `Please Grant Camera Permissions to scan QR Codes`
  String get qrInvalidPermissions {
    return Intl.message(
      'Please Grant Camera Permissions to scan QR Codes',
      name: 'qrInvalidPermissions',
      desc: 'User did not grant camera permissions to the app',
      args: [],
    );
  }

  /// `Could not Read QR Code`
  String get qrUnknownError {
    return Intl.message(
      'Could not Read QR Code',
      name: 'qrUnknownError',
      desc: 'An unknown error occurred with the QR scanner',
      args: [],
    );
  }

  /// `Remove Contact`
  String get removeContact {
    return Intl.message(
      'Remove Contact',
      name: 'removeContact',
      desc: 'contact_remove_btn',
      args: [],
    );
  }

  /// `Are you sure you want to delete %1?`
  String get removeContactConfirmation {
    return Intl.message(
      'Are you sure you want to delete %1?',
      name: 'removeContactConfirmation',
      desc: 'contact_remove_sure',
      args: [],
    );
  }

  /// `Contact`
  String get contactHeader {
    return Intl.message(
      'Contact',
      name: 'contactHeader',
      desc: 'contact_view_header',
      args: [],
    );
  }

  /// `Contacts`
  String get contactsHeader {
    return Intl.message(
      'Contacts',
      name: 'contactsHeader',
      desc: 'contact_header',
      args: [],
    );
  }

  /// `Add Contact`
  String get addContact {
    return Intl.message(
      'Add Contact',
      name: 'addContact',
      desc: 'contact_add_button',
      args: [],
    );
  }

  /// `Enter a Name @`
  String get contactNameHint {
    return Intl.message(
      'Enter a Name @',
      name: 'contactNameHint',
      desc: 'contact_name_hint',
      args: [],
    );
  }

  /// `Invalid Contact Name`
  String get contactInvalid {
    return Intl.message(
      'Invalid Contact Name',
      name: 'contactInvalid',
      desc: 'contact_invalid_name',
      args: [],
    );
  }

  /// `There's no contacts to export.`
  String get noContactsExport {
    return Intl.message(
      'There\'s no contacts to export.',
      name: 'noContactsExport',
      desc: 'contact_export_none',
      args: [],
    );
  }

  /// `No new contacts to import.`
  String get noContactsImport {
    return Intl.message(
      'No new contacts to import.',
      name: 'noContactsImport',
      desc: 'contact_import_none',
      args: [],
    );
  }

  /// `Sucessfully imported %1 contacts.`
  String get contactsImportSuccess {
    return Intl.message(
      'Sucessfully imported %1 contacts.',
      name: 'contactsImportSuccess',
      desc: 'contact_import_success',
      args: [],
    );
  }

  /// `%1 added to contacts.`
  String get contactAdded {
    return Intl.message(
      '%1 added to contacts.',
      name: 'contactAdded',
      desc: 'contact_added',
      args: [],
    );
  }

  /// `%1 has been removed from contacts!`
  String get contactRemoved {
    return Intl.message(
      '%1 has been removed from contacts!',
      name: 'contactRemoved',
      desc: 'contact_removed',
      args: [],
    );
  }

  /// `Choose a Name for this Contact`
  String get contactNameMissing {
    return Intl.message(
      'Choose a Name for this Contact',
      name: 'contactNameMissing',
      desc: 'contact_name_missing',
      args: [],
    );
  }

  /// `Contact Already Exists`
  String get contactExists {
    return Intl.message(
      'Contact Already Exists',
      name: 'contactExists',
      desc: 'contact_name_exists',
      args: [],
    );
  }

  /// `Backup your seed`
  String get backupYourSeed {
    return Intl.message(
      'Backup your seed',
      name: 'backupYourSeed',
      desc: 'intro_new_wallet_seed_backup_header',
      args: [],
    );
  }

  /// `Are you sure that you backed up your wallet seed?`
  String get backupSeedConfirm {
    return Intl.message(
      'Are you sure that you backed up your wallet seed?',
      name: 'backupSeedConfirm',
      desc: 'intro_new_wallet_backup',
      args: [],
    );
  }

  /// `Below is your wallet's seed. It is crucial that you backup your seed and never store it as plaintext or a screenshot.`
  String get seedBackupInfo {
    return Intl.message(
      'Below is your wallet\'s seed. It is crucial that you backup your seed and never store it as plaintext or a screenshot.',
      name: 'seedBackupInfo',
      desc: 'intro_new_wallet_seed',
      args: [],
    );
  }

  /// `Copy Seed`
  String get copySeed {
    return Intl.message(
      'Copy Seed',
      name: 'copySeed',
      desc: 'copy_seed_btn',
      args: [],
    );
  }

  /// `Seed Copied`
  String get seedCopiedShort {
    return Intl.message(
      'Seed Copied',
      name: 'seedCopiedShort',
      desc: 'seed_copied_btn',
      args: [],
    );
  }

  /// `Import Seed`
  String get importSeed {
    return Intl.message(
      'Import Seed',
      name: 'importSeed',
      desc: 'intro_seed_header',
      args: [],
    );
  }

  /// `Please enter your seed below.`
  String get importSeedHint {
    return Intl.message(
      'Please enter your seed below.',
      name: 'importSeedHint',
      desc: 'intro_seed_info',
      args: [],
    );
  }

  /// `Welcome to Natrium. To begin, you may create a new wallet or import an existing one.`
  String get welcomeText {
    return Intl.message(
      'Welcome to Natrium. To begin, you may create a new wallet or import an existing one.',
      name: 'welcomeText',
      desc: 'intro_welcome_title',
      args: [],
    );
  }

  /// `New Wallet`
  String get newWallet {
    return Intl.message(
      'New Wallet',
      name: 'newWallet',
      desc: 'intro_welcome_new_wallet',
      args: [],
    );
  }

  /// `Import Wallet`
  String get importWallet {
    return Intl.message(
      'Import Wallet',
      name: 'importWallet',
      desc: 'intro_welcome_have_wallet',
      args: [],
    );
  }

  /// `Sent To`
  String get sentTo {
    return Intl.message(
      'Sent To',
      name: 'sentTo',
      desc: 'sent_to',
      args: [],
    );
  }

  /// `Sending`
  String get sending {
    return Intl.message(
      'Sending',
      name: 'sending',
      desc: 'send_sending',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: 'send_to',
      args: [],
    );
  }

  /// `Send %1 NANO`
  String get sendAmountConfirm {
    return Intl.message(
      'Send %1 NANO',
      name: 'sendAmountConfirm',
      desc: 'send_pin_description',
      args: [],
    );
  }

  /// `An error occured. Try again later.`
  String get sendError {
    return Intl.message(
      'An error occured. Try again later.',
      name: 'sendError',
      desc: 'send_generic_error',
      args: [],
    );
  }

  /// `Couldn't Verify Request`
  String get mantaError {
    return Intl.message(
      'Couldn\'t Verify Request',
      name: 'mantaError',
      desc: 'Was unable to verify the manta/appia payment request (from scanning QR code, etc.)',
      args: [],
    );
  }

  /// `Enter Amount`
  String get enterAmount {
    return Intl.message(
      'Enter Amount',
      name: 'enterAmount',
      desc: 'send_amount_hint',
      args: [],
    );
  }

  /// `Enter Address`
  String get enterAddress {
    return Intl.message(
      'Enter Address',
      name: 'enterAddress',
      desc: 'enter_address',
      args: [],
    );
  }

  /// `Address entered was invalid`
  String get invalidAddress {
    return Intl.message(
      'Address entered was invalid',
      name: 'invalidAddress',
      desc: 'send_invalid_address',
      args: [],
    );
  }

  /// `Please Enter an Address`
  String get addressMising {
    return Intl.message(
      'Please Enter an Address',
      name: 'addressMising',
      desc: 'send_enter_address',
      args: [],
    );
  }

  /// `Please Enter an Amount`
  String get amountMissing {
    return Intl.message(
      'Please Enter an Amount',
      name: 'amountMissing',
      desc: 'send_enter_amount',
      args: [],
    );
  }

  /// `Minimum send amount is %1 NANO`
  String get minimumSend {
    return Intl.message(
      'Minimum send amount is %1 NANO',
      name: 'minimumSend',
      desc: 'send_minimum_error',
      args: [],
    );
  }

  /// `Insufficient Balance`
  String get insufficientBalance {
    return Intl.message(
      'Insufficient Balance',
      name: 'insufficientBalance',
      desc: 'send_insufficient_balance',
      args: [],
    );
  }

  /// `Send From`
  String get sendFrom {
    return Intl.message(
      'Send From',
      name: 'sendFrom',
      desc: 'send_title',
      args: [],
    );
  }

  /// `Create a 6-digit pin`
  String get pinCreateTitle {
    return Intl.message(
      'Create a 6-digit pin',
      name: 'pinCreateTitle',
      desc: 'pin_create_title',
      args: [],
    );
  }

  /// `Confirm your pin`
  String get pinConfirmTitle {
    return Intl.message(
      'Confirm your pin',
      name: 'pinConfirmTitle',
      desc: 'pin_confirm_title',
      args: [],
    );
  }

  /// `Enter pin`
  String get pinEnterTitle {
    return Intl.message(
      'Enter pin',
      name: 'pinEnterTitle',
      desc: 'pin_enter_title',
      args: [],
    );
  }

  /// `Pins do not match`
  String get pinConfirmError {
    return Intl.message(
      'Pins do not match',
      name: 'pinConfirmError',
      desc: 'pin_confirm_error',
      args: [],
    );
  }

  /// `Invalid pin entered`
  String get pinInvalid {
    return Intl.message(
      'Invalid pin entered',
      name: 'pinInvalid',
      desc: 'pin_error',
      args: [],
    );
  }

  /// `Theme`
  String get themeHeader {
    return Intl.message(
      'Theme',
      name: 'themeHeader',
      desc: 'theme_header',
      args: [],
    );
  }

  /// `Change`
  String get changeRepButton {
    return Intl.message(
      'Change',
      name: 'changeRepButton',
      desc: 'change_representative_change',
      args: [],
    );
  }

  /// `Change Representative`
  String get changeRepAuthenticate {
    return Intl.message(
      'Change Representative',
      name: 'changeRepAuthenticate',
      desc: 'settings_change_rep',
      args: [],
    );
  }

  /// `Currently Represented By`
  String get currentlyRepresented {
    return Intl.message(
      'Currently Represented By',
      name: 'currentlyRepresented',
      desc: 'change_representative_current_header',
      args: [],
    );
  }

  /// `Representative Changed Successfully`
  String get changeRepSucces {
    return Intl.message(
      'Representative Changed Successfully',
      name: 'changeRepSucces',
      desc: 'change_representative_success',
      args: [],
    );
  }

  /// `What is a representative?`
  String get repInfoHeader {
    return Intl.message(
      'What is a representative?',
      name: 'repInfoHeader',
      desc: 'change_representative_info_header',
      args: [],
    );
  }

  /// `A representative is an account that votes for network consensus. Voting power is weighted by balance, you may delegate your balance to increase the voting weight of a representative you trust. Your representative does not have spending power over your funds. You should choose a representative that has little downtime and is trustworthy.`
  String get repInfo {
    return Intl.message(
      'A representative is an account that votes for network consensus. Voting power is weighted by balance, you may delegate your balance to increase the voting weight of a representative you trust. Your representative does not have spending power over your funds. You should choose a representative that has little downtime and is trustworthy.',
      name: 'repInfo',
      desc: 'change_representative_info',
      args: [],
    );
  }

  /// `Enter PIN to change representative.`
  String get pinRepChange {
    return Intl.message(
      'Enter PIN to change representative.',
      name: 'pinRepChange',
      desc: 'change_representative_pin',
      args: [],
    );
  }

  /// `Enter New Representative`
  String get changeRepHint {
    return Intl.message(
      'Enter New Representative',
      name: 'changeRepHint',
      desc: 'change_representative_hint',
      args: [],
    );
  }

  /// `Representatives`
  String get representatives {
    return Intl.message(
      'Representatives',
      name: 'representatives',
      desc: 'representatives',
      args: [],
    );
  }

  /// `Pick From a List`
  String get pickFromList {
    return Intl.message(
      'Pick From a List',
      name: 'pickFromList',
      desc: 'pick rep from list',
      args: [],
    );
  }

  /// `Voting Weight`
  String get votingWeight {
    return Intl.message(
      'Voting Weight',
      name: 'votingWeight',
      desc: 'Representative Voting Weight',
      args: [],
    );
  }

  /// `Uptime`
  String get uptime {
    return Intl.message(
      'Uptime',
      name: 'uptime',
      desc: 'Rep uptime',
      args: [],
    );
  }

  /// `Authentication Method`
  String get authMethod {
    return Intl.message(
      'Authentication Method',
      name: 'authMethod',
      desc: 'settings_disable_fingerprint',
      args: [],
    );
  }

  /// `PIN`
  String get pinMethod {
    return Intl.message(
      'PIN',
      name: 'pinMethod',
      desc: 'settings_pin_method',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: 'settings_privacy_policy',
      args: [],
    );
  }

  /// `Biometrics`
  String get biometricsMethod {
    return Intl.message(
      'Biometrics',
      name: 'biometricsMethod',
      desc: 'settings_fingerprint_method',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: 'A settings menu item for changing currency',
      args: [],
    );
  }

  /// `Change Currency`
  String get changeCurrency {
    return Intl.message(
      'Change Currency',
      name: 'changeCurrency',
      desc: 'settings_local_currency',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'settings_change_language',
      args: [],
    );
  }

  /// `Share Natrium`
  String get shareNatrium {
    return Intl.message(
      'Share Natrium',
      name: 'shareNatrium',
      desc: 'settings_share',
      args: [],
    );
  }

  /// `Check out Natrium! A premier NANO mobile wallet!`
  String get shareNatriumText {
    return Intl.message(
      'Check out Natrium! A premier NANO mobile wallet!',
      name: 'shareNatriumText',
      desc: 'share_extra',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'settings_logout',
      args: [],
    );
  }

  /// `It appears your device is "rooted", "jailbroken", or modified in a way that compromises security. It is recommended that you reset your device to its original state before proceeding.`
  String get rootWarning {
    return Intl.message(
      'It appears your device is "rooted", "jailbroken", or modified in a way that compromises security. It is recommended that you reset your device to its original state before proceeding.',
      name: 'rootWarning',
      desc: 'Shown to users if they have a rooted Android device or jailbroken iOS device',
      args: [],
    );
  }

  /// `I Understand the Risks`
  String get iUnderstandTheRisks {
    return Intl.message(
      'I Understand the Risks',
      name: 'iUnderstandTheRisks',
      desc: 'Shown to users if they have a rooted Android device or jailbroken iOS device',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: 'Exit action, like a button',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: 'settings_logout_alert_title',
      args: [],
    );
  }

  /// `Logging out will remove your seed and all Natrium-related data from this device. If your seed is not backed up, you will never be able to access your funds again`
  String get logoutDetail {
    return Intl.message(
      'Logging out will remove your seed and all Natrium-related data from this device. If your seed is not backed up, you will never be able to access your funds again',
      name: 'logoutDetail',
      desc: 'settings_logout_alert_message',
      args: [],
    );
  }

  /// `Delete Seed and Logout`
  String get logoutAction {
    return Intl.message(
      'Delete Seed and Logout',
      name: 'logoutAction',
      desc: 'settings_logout_alert_confirm_cta',
      args: [],
    );
  }

  /// `Are you sure?`
  String get logoutAreYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'logoutAreYouSure',
      desc: 'settings_logout_warning_title',
      args: [],
    );
  }

  /// `As long as you've backed up your seed you have nothing to worry about.`
  String get logoutReassurance {
    return Intl.message(
      'As long as you\'ve backed up your seed you have nothing to worry about.',
      name: 'logoutReassurance',
      desc: 'settings_logout_warning_message',
      args: [],
    );
  }

  /// `Settings`
  String get settingsHeader {
    return Intl.message(
      'Settings',
      name: 'settingsHeader',
      desc: 'settings_title',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message(
      'Preferences',
      name: 'preferences',
      desc: 'settings_preferences_header',
      args: [],
    );
  }

  /// `Manage`
  String get manage {
    return Intl.message(
      'Manage',
      name: 'manage',
      desc: 'settings_manage_header',
      args: [],
    );
  }

  /// `Backup Seed`
  String get backupSeed {
    return Intl.message(
      'Backup Seed',
      name: 'backupSeed',
      desc: 'settings_backup_seed',
      args: [],
    );
  }

  /// `Authenticate to backup seed.`
  String get fingerprintSeedBackup {
    return Intl.message(
      'Authenticate to backup seed.',
      name: 'fingerprintSeedBackup',
      desc: 'settings_fingerprint_title',
      args: [],
    );
  }

  /// `Enter PIN to Backup Seed`
  String get pinSeedBackup {
    return Intl.message(
      'Enter PIN to Backup Seed',
      name: 'pinSeedBackup',
      desc: 'settings_pin_title',
      args: [],
    );
  }

  /// `System Default`
  String get systemDefault {
    return Intl.message(
      'System Default',
      name: 'systemDefault',
      desc: 'settings_default_language_string',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: 'notifications_settings',
      args: [],
    );
  }

  /// `Received %1 NANO`
  String get notificationTitle {
    return Intl.message(
      'Received %1 NANO',
      name: 'notificationTitle',
      desc: 'notification_title',
      args: [],
    );
  }

  /// `Open Natrium to view this transaction`
  String get notificationBody {
    return Intl.message(
      'Open Natrium to view this transaction',
      name: 'notificationBody',
      desc: 'notification_body',
      args: [],
    );
  }

  /// `Tap to open`
  String get notificationHeaderSupplement {
    return Intl.message(
      'Tap to open',
      name: 'notificationHeaderSupplement',
      desc: 'notificaiton_header_suplement',
      args: [],
    );
  }

  /// `Load from Paper Wallet`
  String get settingsTransfer {
    return Intl.message(
      'Load from Paper Wallet',
      name: 'settingsTransfer',
      desc: 'settings_transfer',
      args: [],
    );
  }

  /// `An error has occurred during the transfer. Please try again later.`
  String get transferError {
    return Intl.message(
      'An error has occurred during the transfer. Please try again later.',
      name: 'transferError',
      desc: 'transfer_error',
      args: [],
    );
  }

  /// `Paper Wallet`
  String get paperWallet {
    return Intl.message(
      'Paper Wallet',
      name: 'paperWallet',
      desc: 'paper_wallet',
      args: [],
    );
  }

  /// `Natrium Wallet`
  String get kaliumWallet {
    return Intl.message(
      'Natrium Wallet',
      name: 'kaliumWallet',
      desc: 'kalium_wallet',
      args: [],
    );
  }

  /// `Manual Entry`
  String get manualEntry {
    return Intl.message(
      'Manual Entry',
      name: 'manualEntry',
      desc: 'transfer_manual_entry',
      args: [],
    );
  }

  /// `Mnemonic Phrase`
  String get mnemonicPhrase {
    return Intl.message(
      'Mnemonic Phrase',
      name: 'mnemonicPhrase',
      desc: 'mnemonic_phrase',
      args: [],
    );
  }

  /// `Raw Seed`
  String get rawSeed {
    return Intl.message(
      'Raw Seed',
      name: 'rawSeed',
      desc: 'raw_seed',
      args: [],
    );
  }

  /// `Transfer Funds`
  String get transferHeader {
    return Intl.message(
      'Transfer Funds',
      name: 'transferHeader',
      desc: 'transfer_header',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: 'transfer_btn',
      args: [],
    );
  }

  /// `Please enter the seed below.`
  String get transferManualHint {
    return Intl.message(
      'Please enter the seed below.',
      name: 'transferManualHint',
      desc: 'transfer_hint',
      args: [],
    );
  }

  /// `This process will transfer the funds from a paper wallet to your Natrium wallet.\n\nTap the "%1" button to start.`
  String get transferIntro {
    return Intl.message(
      'This process will transfer the funds from a paper wallet to your Natrium wallet.\n\nTap the "%1" button to start.',
      name: 'transferIntro',
      desc: 'transfer_intro',
      args: [],
    );
  }

  /// `Scan a Nano \nseed or private key`
  String get transferQrScanHint {
    return Intl.message(
      'Scan a Nano \nseed or private key',
      name: 'transferQrScanHint',
      desc: 'transfer_qr_scan_hint',
      args: [],
    );
  }

  /// `This QR code does not contain a valid seed.`
  String get transferQrScanError {
    return Intl.message(
      'This QR code does not contain a valid seed.',
      name: 'transferQrScanError',
      desc: 'transfer_qr_scan_error',
      args: [],
    );
  }

  /// `This seed does not have any NANO on it`
  String get transferNoFunds {
    return Intl.message(
      'This seed does not have any NANO on it',
      name: 'transferNoFunds',
      desc: 'transfer_no_funds_toast',
      args: [],
    );
  }

  /// `A wallet with a balance of %1 NANO has been detected.\n`
  String get transferConfirmInfo {
    return Intl.message(
      'A wallet with a balance of %1 NANO has been detected.\n',
      name: 'transferConfirmInfo',
      desc: 'transfer_confirm_info_first',
      args: [],
    );
  }

  /// `Tap confirm to transfer the funds.\n`
  String get transferConfirmInfoSecond {
    return Intl.message(
      'Tap confirm to transfer the funds.\n',
      name: 'transferConfirmInfoSecond',
      desc: 'transfer_confirm_info_second',
      args: [],
    );
  }

  /// `Transfer may take several seconds to complete.`
  String get transferConfirmInfoThird {
    return Intl.message(
      'Transfer may take several seconds to complete.',
      name: 'transferConfirmInfoThird',
      desc: 'transfer_confirm_info_third',
      args: [],
    );
  }

  /// `Transferring`
  String get transferLoading {
    return Intl.message(
      'Transferring',
      name: 'transferLoading',
      desc: 'transfer_loading_text',
      args: [],
    );
  }

  /// `%1 NANO successfully transferred to your Natrium Wallet.\n`
  String get transferComplete {
    return Intl.message(
      '%1 NANO successfully transferred to your Natrium Wallet.\n',
      name: 'transferComplete',
      desc: 'transfer_complete_text',
      args: [],
    );
  }

  /// `Tap anywhere to close the window.`
  String get transferClose {
    return Intl.message(
      'Tap anywhere to close the window.',
      name: 'transferClose',
      desc: 'transfer_close_text',
      args: [],
    );
  }

  /// `Scan a Nano \naddress QR code`
  String get scanInstructions {
    return Intl.message(
      'Scan a Nano \naddress QR code',
      name: 'scanInstructions',
      desc: 'scan_send_instruction_label',
      args: [],
    );
  }

  /// `Enter PIN to Unlock Natrium`
  String get unlockPin {
    return Intl.message(
      'Enter PIN to Unlock Natrium',
      name: 'unlockPin',
      desc: 'unlock_kalium_pin',
      args: [],
    );
  }

  /// `Authenticate to Unlock Natrium`
  String get unlockBiometrics {
    return Intl.message(
      'Authenticate to Unlock Natrium',
      name: 'unlockBiometrics',
      desc: 'unlock_kalium_bio',
      args: [],
    );
  }

  /// `Authenticate on Launch`
  String get lockAppSetting {
    return Intl.message(
      'Authenticate on Launch',
      name: 'lockAppSetting',
      desc: 'authenticate_on_launch',
      args: [],
    );
  }

  /// `Locked`
  String get locked {
    return Intl.message(
      'Locked',
      name: 'locked',
      desc: 'lockedtxt',
      args: [],
    );
  }

  /// `Unlock`
  String get unlock {
    return Intl.message(
      'Unlock',
      name: 'unlock',
      desc: 'unlocktxt',
      args: [],
    );
  }

  /// `Too many failed unlock attempts.`
  String get tooManyFailedAttempts {
    return Intl.message(
      'Too many failed unlock attempts.',
      name: 'tooManyFailedAttempts',
      desc: 'fail_toomany_attempts',
      args: [],
    );
  }

  /// `Security`
  String get securityHeader {
    return Intl.message(
      'Security',
      name: 'securityHeader',
      desc: 'security_header',
      args: [],
    );
  }

  /// `Automatically Lock`
  String get autoLockHeader {
    return Intl.message(
      'Automatically Lock',
      name: 'autoLockHeader',
      desc: 'auto_lock_header',
      args: [],
    );
  }

  /// `After %1 minutes`
  String get xMinutes {
    return Intl.message(
      'After %1 minutes',
      name: 'xMinutes',
      desc: 'after_minutes',
      args: [],
    );
  }

  /// `After %1 minute`
  String get xMinute {
    return Intl.message(
      'After %1 minute',
      name: 'xMinute',
      desc: 'after_minute',
      args: [],
    );
  }

  /// `Instantly`
  String get instantly {
    return Intl.message(
      'Instantly',
      name: 'instantly',
      desc: 'insantly',
      args: [],
    );
  }

  /// `Set Wallet Password`
  String get setWalletPassword {
    return Intl.message(
      'Set Wallet Password',
      name: 'setWalletPassword',
      desc: 'Allows user to encrypt wallet with a password',
      args: [],
    );
  }

  /// `Set Password`
  String get setPassword {
    return Intl.message(
      'Set Password',
      name: 'setPassword',
      desc: 'A button that sets the wallet password',
      args: [],
    );
  }

  /// `Disable Wallet Password`
  String get disableWalletPassword {
    return Intl.message(
      'Disable Wallet Password',
      name: 'disableWalletPassword',
      desc: 'Allows user to deencrypt wallet with a password',
      args: [],
    );
  }

  /// `Failed to set a wallet password`
  String get encryptionFailedError {
    return Intl.message(
      'Failed to set a wallet password',
      name: 'encryptionFailedError',
      desc: 'If encrypting a wallet raised an error',
      args: [],
    );
  }

  /// `Password has been set successfully`
  String get setPasswordSuccess {
    return Intl.message(
      'Password has been set successfully',
      name: 'setPasswordSuccess',
      desc: 'Setting a Wallet Password was successful',
      args: [],
    );
  }

  /// `Password has been disabled`
  String get disablePasswordSuccess {
    return Intl.message(
      'Password has been disabled',
      name: 'disablePasswordSuccess',
      desc: 'Disabling a Wallet Password was successful',
      args: [],
    );
  }

  /// `Welcome to Natrium. Once you receive NANO, transactions will show up like this:`
  String get exampleCardIntro {
    return Intl.message(
      'Welcome to Natrium. Once you receive NANO, transactions will show up like this:',
      name: 'exampleCardIntro',
      desc: 'example_card_intro',
      args: [],
    );
  }

  /// `A little`
  String get exampleCardLittle {
    return Intl.message(
      'A little',
      name: 'exampleCardLittle',
      desc: 'example_card_little',
      args: [],
    );
  }

  /// `A lot of`
  String get exampleCardLot {
    return Intl.message(
      'A lot of',
      name: 'exampleCardLot',
      desc: 'example_card_lot',
      args: [],
    );
  }

  /// `to someone`
  String get exampleCardTo {
    return Intl.message(
      'to someone',
      name: 'exampleCardTo',
      desc: 'example_card_to',
      args: [],
    );
  }

  /// `from someone`
  String get exampleCardFrom {
    return Intl.message(
      'from someone',
      name: 'exampleCardFrom',
      desc: 'example_card_from',
      args: [],
    );
  }

  /// `Main Account`
  String get defaultAccountName {
    return Intl.message(
      'Main Account',
      name: 'defaultAccountName',
      desc: 'Default account name',
      args: [],
    );
  }

  /// `Account %1`
  String get defaultNewAccountName {
    return Intl.message(
      'Account %1',
      name: 'defaultNewAccountName',
      desc: 'Default new account name - e.g. Account 1',
      args: [],
    );
  }

  /// `This is your new account. Once you receive NANO, transactions will show up like this:`
  String get newAccountIntro {
    return Intl.message(
      'This is your new account. Once you receive NANO, transactions will show up like this:',
      name: 'newAccountIntro',
      desc: 'Alternate account intro card',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: 'Account text',
      args: [],
    );
  }

  /// `Accounts`
  String get accounts {
    return Intl.message(
      'Accounts',
      name: 'accounts',
      desc: 'Accounts header',
      args: [],
    );
  }

  /// `Add Account`
  String get addAccount {
    return Intl.message(
      'Add Account',
      name: 'addAccount',
      desc: 'Default new account name - e.g. Account 1',
      args: [],
    );
  }

  /// `Hide Account?`
  String get hideAccountHeader {
    return Intl.message(
      'Hide Account?',
      name: 'hideAccountHeader',
      desc: 'Confirmation dialog header',
      args: [],
    );
  }

  /// `Are you sure you want to hide this account? You can re-add it later by tapping the "%1" button.`
  String get removeAccountText {
    return Intl.message(
      'Are you sure you want to hide this account? You can re-add it later by tapping the "%1" button.',
      name: 'removeAccountText',
      desc: 'Remove account dialog body',
      args: [],
    );
  }

  /// `Tap to reveal`
  String get tapToReveal {
    return Intl.message(
      'Tap to reveal',
      name: 'tapToReveal',
      desc: 'Tap to reveal hidden content',
      args: [],
    );
  }

  /// `Tap to hide`
  String get tapToHide {
    return Intl.message(
      'Tap to hide',
      name: 'tapToHide',
      desc: 'Tap to hide content',
      args: [],
    );
  }

  /// `Copied`
  String get copied {
    return Intl.message(
      'Copied',
      name: 'copied',
      desc: 'Copied (to clipboard)',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: 'Copy (to clipboard)',
      args: [],
    );
  }

  /// `A seed bears the same information as a secret phrase, but in a machine-readable way. As long as you have one of them backed up, you'll have access to your funds.`
  String get seedDescription {
    return Intl.message(
      'A seed bears the same information as a secret phrase, but in a machine-readable way. As long as you have one of them backed up, you\'ll have access to your funds.',
      name: 'seedDescription',
      desc: 'Describing what a seed is',
      args: [],
    );
  }

  /// `Import Secret Phrase`
  String get importSecretPhrase {
    return Intl.message(
      'Import Secret Phrase',
      name: 'importSecretPhrase',
      desc: 'Header for restoring using mnemonic',
      args: [],
    );
  }

  /// `Please enter your 24-word secret phrase below. Each word should be separated by a space.`
  String get importSecretPhraseHint {
    return Intl.message(
      'Please enter your 24-word secret phrase below. Each word should be separated by a space.',
      name: 'importSecretPhraseHint',
      desc: 'helper message for importing mnemnic',
      args: [],
    );
  }

  /// `QR does not contain a valid secret phrase`
  String get qrMnemonicError {
    return Intl.message(
      'QR does not contain a valid secret phrase',
      name: 'qrMnemonicError',
      desc: 'When QR does not contain a valid mnemonic phrase',
      args: [],
    );
  }

  /// `%1 is not a valid word`
  String get mnemonicInvalidWord {
    return Intl.message(
      '%1 is not a valid word',
      name: 'mnemonicInvalidWord',
      desc: 'A word that is not part of bip39',
      args: [],
    );
  }

  /// `Secret phrase may only contain 24 words`
  String get mnemonicSizeError {
    return Intl.message(
      'Secret phrase may only contain 24 words',
      name: 'mnemonicSizeError',
      desc: 'err',
      args: [],
    );
  }

  /// `Secret Phrase`
  String get secretPhrase {
    return Intl.message(
      'Secret Phrase',
      name: 'secretPhrase',
      desc: 'Secret (mnemonic) phrase',
      args: [],
    );
  }

  /// `I've Backed It Up`
  String get backupConfirmButton {
    return Intl.message(
      'I\'ve Backed It Up',
      name: 'backupConfirmButton',
      desc: 'Has backed up seed confirmation button',
      args: [],
    );
  }

  /// `Safety First!`
  String get secretInfoHeader {
    return Intl.message(
      'Safety First!',
      name: 'secretInfoHeader',
      desc: 'secret info header',
      args: [],
    );
  }

  /// `In the next screen, you will see your secret phrase. It is a password to access your funds. It is crucial that you back it up and never share it with anyone.`
  String get secretInfo {
    return Intl.message(
      'In the next screen, you will see your secret phrase. It is a password to access your funds. It is crucial that you back it up and never share it with anyone.',
      name: 'secretInfo',
      desc: 'Description for seed',
      args: [],
    );
  }

  /// `If you lose your device or uninstall the application, you'll need your secret phrase or seed to recover your funds!`
  String get secretWarning {
    return Intl.message(
      'If you lose your device or uninstall the application, you\'ll need your secret phrase or seed to recover your funds!',
      name: 'secretWarning',
      desc: 'Secret warning',
      args: [],
    );
  }

  /// `Got It!`
  String get gotItButton {
    return Intl.message(
      'Got It!',
      name: 'gotItButton',
      desc: 'Got It! Acknowledgement button',
      args: [],
    );
  }

  /// `Are you sure that you've backed up your secret phrase or seed?`
  String get ackBackedUp {
    return Intl.message(
      'Are you sure that you\'ve backed up your secret phrase or seed?',
      name: 'ackBackedUp',
      desc: 'Ack backed up',
      args: [],
    );
  }

  /// `Copy Secret Phrase`
  String get secretPhraseCopy {
    return Intl.message(
      'Copy Secret Phrase',
      name: 'secretPhraseCopy',
      desc: 'Copy secret phrase to clipboard',
      args: [],
    );
  }

  /// `Secret Phrase Copied`
  String get secretPhraseCopied {
    return Intl.message(
      'Secret Phrase Copied',
      name: 'secretPhraseCopied',
      desc: 'Copied secret phrase to clipboard',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: 'Generic import',
      args: [],
    );
  }

  /// `Import Seed Instead`
  String get importSeedInstead {
    return Intl.message(
      'Import Seed Instead',
      name: 'importSeedInstead',
      desc: 'importSeedInstead',
      args: [],
    );
  }

  /// `Switch to Seed`
  String get switchToSeed {
    return Intl.message(
      'Switch to Seed',
      name: 'switchToSeed',
      desc: 'switchToSeed',
      args: [],
    );
  }

  /// `Backup Secret Phrase`
  String get backupSecretPhrase {
    return Intl.message(
      'Backup Secret Phrase',
      name: 'backupSecretPhrase',
      desc: 'backup seed',
      args: [],
    );
  }

  /// `Create a password`
  String get createPasswordHint {
    return Intl.message(
      'Create a password',
      name: 'createPasswordHint',
      desc: 'A text field hint that tells the user to create a password',
      args: [],
    );
  }

  /// `Confirm the password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm the password',
      name: 'confirmPasswordHint',
      desc: 'A text field hint that tells the user to confirm the password',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterPasswordHint {
    return Intl.message(
      'Enter your password',
      name: 'enterPasswordHint',
      desc: 'A text field hint that tells the users to enter their password',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDontMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDontMatch',
      desc: 'An error indicating a password has been confirmed incorrectly',
      args: [],
    );
  }

  /// `Password cannot be empty`
  String get passwordBlank {
    return Intl.message(
      'Password cannot be empty',
      name: 'passwordBlank',
      desc: 'An error indicating a password has been entered incorrectly',
      args: [],
    );
  }

  /// `Invalid Password`
  String get invalidPassword {
    return Intl.message(
      'Invalid Password',
      name: 'invalidPassword',
      desc: 'An error indicating a password has been entered incorrectly',
      args: [],
    );
  }

  /// `This password will be required to open Natrium.`
  String get passwordWillBeRequiredToOpenParagraph {
    return Intl.message(
      'This password will be required to open Natrium.',
      name: 'passwordWillBeRequiredToOpenParagraph',
      desc: 'A paragraph that tells the users that the created password will be required to open Natrium.',
      args: [],
    );
  }

  /// `You will not need a password to open Natrium anymore.`
  String get passwordNoLongerRequiredToOpenParagraph {
    return Intl.message(
      'You will not need a password to open Natrium anymore.',
      name: 'passwordNoLongerRequiredToOpenParagraph',
      desc: 'An info paragraph that tells the user a password will no longer be needed to open Natrium',
      args: [],
    );
  }

  /// `You can create a password to add additional security to your wallet.`
  String get createPasswordFirstParagraph {
    return Intl.message(
      'You can create a password to add additional security to your wallet.',
      name: 'createPasswordFirstParagraph',
      desc: 'A paragraph that tells the users that they can create a password for additional security.',
      args: [],
    );
  }

  /// `Password is optional, and your wallet will be protected with your PIN or biometrics regardless.`
  String get createPasswordSecondParagraph {
    return Intl.message(
      'Password is optional, and your wallet will be protected with your PIN or biometrics regardless.',
      name: 'createPasswordSecondParagraph',
      desc: 'A paragraph that tells the users that the password creation is optional and the wallet will be still protected with biometrics or PIN regardless.',
      args: [],
    );
  }

  /// `Create a password.`
  String get createAPasswordHeader {
    return Intl.message(
      'Create a password.',
      name: 'createAPasswordHeader',
      desc: 'A paragraph that tells the users to create a password.',
      args: [],
    );
  }

  /// `Create`
  String get createPasswordSheetHeader {
    return Intl.message(
      'Create',
      name: 'createPasswordSheetHeader',
      desc: 'Prompt user to create a new password',
      args: [],
    );
  }

  /// `Disable`
  String get disablePasswordSheetHeader {
    return Intl.message(
      'Disable',
      name: 'disablePasswordSheetHeader',
      desc: 'Prompt user to disable their password',
      args: [],
    );
  }

  /// `Require a password to open Natrium?`
  String get requireAPasswordToOpenHeader {
    return Intl.message(
      'Require a password to open Natrium?',
      name: 'requireAPasswordToOpenHeader',
      desc: 'A paragraph that asks the users if they would like a password to be required to open Natrium.',
      args: [],
    );
  }

  /// `No, Skip`
  String get noSkipButton {
    return Intl.message(
      'No, Skip',
      name: 'noSkipButton',
      desc: 'A button that declines and skips the mentioned process.',
      args: [],
    );
  }

  /// `Yes`
  String get yesButton {
    return Intl.message(
      'Yes',
      name: 'yesButton',
      desc: 'A button that accepts the mentioned process.',
      args: [],
    );
  }

  /// `Next`
  String get nextButton {
    return Intl.message(
      'Next',
      name: 'nextButton',
      desc: 'A button that goes to the next screen.',
      args: [],
    );
  }

  /// `Go Back`
  String get goBackButton {
    return Intl.message(
      'Go Back',
      name: 'goBackButton',
      desc: 'A button that goes to the previous screen.',
      args: [],
    );
  }

  /// `Support`
  String get supportButton {
    return Intl.message(
      'Support',
      name: 'supportButton',
      desc: 'A button to open up the live support window',
      args: [],
    );
  }

  /// `Support`
  String get liveSupportButton {
    return Intl.message(
      'Support',
      name: 'liveSupportButton',
      desc: 'A button to open up the live support window',
      args: [],
    );
  }

  /// `Connecting`
  String get connectingHeader {
    return Intl.message(
      'Connecting',
      name: 'connectingHeader',
      desc: 'A header to let the user now that Natrium is currently connecting to (or loading) live chat.',
      args: [],
    );
  }

  /// `English`
  String get localeEnglishItem {
    return Intl.message(
      'English',
      name: 'localeEnglishItem',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get localeRussianItem {
    return Intl.message(
      'Russian',
      name: 'localeRussianItem',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'messages'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}