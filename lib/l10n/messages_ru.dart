// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static m0(coin, qty, address) => "Использовать push-ссылку и зачислить ${qty} ${coin} на ваш счет?";

  static m1(current, total) => "Вопрос ${current} с ${total}";

  static m2(position) => "Выберите ${position}-е слово вашей контрольной фразы.";

  static m3(qty, wallet) => "Отправить ${qty} средства на ${wallet}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "accessBlocked" : MessageLookupByLibrary.simpleMessage("Доступ заблокирован.  Пожалуйста, свяжитесь с администрацией."),
    "account" : MessageLookupByLibrary.simpleMessage("Профиль"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Счета"),
    "ackBackedUp" : MessageLookupByLibrary.simpleMessage("Вы уверены, что сохранили свою секретную фразу?"),
    "addAccount" : MessageLookupByLibrary.simpleMessage("Добавить счет"),
    "addContact" : MessageLookupByLibrary.simpleMessage("Добавить контакт"),
    "addressCopied" : MessageLookupByLibrary.simpleMessage("Адрес скопирован в буфер обмена"),
    "addressHint" : MessageLookupByLibrary.simpleMessage("Введите адрес"),
    "addressMising" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите адрес"),
    "addressShare" : MessageLookupByLibrary.simpleMessage("Поделиться адресом"),
    "amountMissing" : MessageLookupByLibrary.simpleMessage("Пожалуйста,  введите сумму"),
    "appName" : MessageLookupByLibrary.simpleMessage("Fusion"),
    "applyPushBody" : m0,
    "applyPushTitle" : MessageLookupByLibrary.simpleMessage("Зачислить средства"),
    "authMethod" : MessageLookupByLibrary.simpleMessage("Метод проверки подлинности"),
    "authSuccess" : MessageLookupByLibrary.simpleMessage("Успешная авторизация"),
    "authenticateToViewTransaction" : MessageLookupByLibrary.simpleMessage("Пожалуйста,  авторизуйтесь, чтобы просмотреть транзакцию"),
    "autoLockHeader" : MessageLookupByLibrary.simpleMessage("Автоматическая блокировка"),
    "backupConfirmButton" : MessageLookupByLibrary.simpleMessage("Я сделал резервную копию"),
    "backupSecretPhrase" : MessageLookupByLibrary.simpleMessage("Резервное копирование секретной фразы"),
    "backupSeed" : MessageLookupByLibrary.simpleMessage("Резервный seed"),
    "backupSeedConfirm" : MessageLookupByLibrary.simpleMessage("Вы уверены, что сделали резервную копию своего кошелька?"),
    "backupYourSeed" : MessageLookupByLibrary.simpleMessage("Сделайте резервную копию своего seed"),
    "biometricsMethod" : MessageLookupByLibrary.simpleMessage("Биометрия"),
    "buttonAddContact" : MessageLookupByLibrary.simpleMessage("Новый контакт"),
    "buttonBuy" : MessageLookupByLibrary.simpleMessage("Покупка"),
    "buttonClose" : MessageLookupByLibrary.simpleMessage("Закрыть"),
    "buttonConvert" : MessageLookupByLibrary.simpleMessage("Конвертировать"),
    "buttonCreateAccount" : MessageLookupByLibrary.simpleMessage("Создать аккаунт"),
    "buttonDelegate" : MessageLookupByLibrary.simpleMessage("Делегировать"),
    "buttonLogOut" : MessageLookupByLibrary.simpleMessage("Выйти"),
    "buttonNext" : MessageLookupByLibrary.simpleMessage("Далее"),
    "buttonPreview" : MessageLookupByLibrary.simpleMessage("Просмотр"),
    "buttonPush" : MessageLookupByLibrary.simpleMessage("Отправить Push"),
    "buttonRate" : MessageLookupByLibrary.simpleMessage("Курс"),
    "buttonRecoverFromPassphrase" : MessageLookupByLibrary.simpleMessage("Восстановление по фразе"),
    "buttonRequest" : MessageLookupByLibrary.simpleMessage("Получить"),
    "buttonSell" : MessageLookupByLibrary.simpleMessage("Продажа"),
    "buttonSend" : MessageLookupByLibrary.simpleMessage("Отправить"),
    "buttonShare" : MessageLookupByLibrary.simpleMessage("Поделиться"),
    "buttonUnbound" : MessageLookupByLibrary.simpleMessage("Освободить"),
    "buttonVerify" : MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "buttonVerifyRecoveryPhrase" : MessageLookupByLibrary.simpleMessage("Подтвердить контр.фразу"),
    "buttonViewResults" : MessageLookupByLibrary.simpleMessage("Показать результаты"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Отменить"),
    "cannotRecoverAccount" : MessageLookupByLibrary.simpleMessage("Невозможно восстановить эту учетную запись."),
    "cardCurrencyMode" : MessageLookupByLibrary.simpleMessage("Режим отображения в токенах"),
    "cardUsdMode" : MessageLookupByLibrary.simpleMessage("Отображение в долларах США"),
    "changeCurrency" : MessageLookupByLibrary.simpleMessage("Изменить валюту"),
    "changeRepAuthenticate" : MessageLookupByLibrary.simpleMessage("Сменить представителя"),
    "changeRepButton" : MessageLookupByLibrary.simpleMessage("+ Изменить"),
    "changeRepHint" : MessageLookupByLibrary.simpleMessage("Введите нового представителя"),
    "changeRepSucces" : MessageLookupByLibrary.simpleMessage("Представитель успешно изменен"),
    "checkboxTermsConditions" : MessageLookupByLibrary.simpleMessage("Я согласен с условиями"),
    "chooseAccountTitle" : MessageLookupByLibrary.simpleMessage("Выберите аккаунт"),
    "chooseContactTitle" : MessageLookupByLibrary.simpleMessage("Выберите контакт"),
    "chooseCurrency" : MessageLookupByLibrary.simpleMessage("Выберите валюту"),
    "close" : MessageLookupByLibrary.simpleMessage("Закрыть"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "confirmPasswordHint" : MessageLookupByLibrary.simpleMessage("Подтвердите Пароль"),
    "connectingHeader" : MessageLookupByLibrary.simpleMessage("Подключение ..."),
    "contactAdded" : MessageLookupByLibrary.simpleMessage("%1 добавлен в контакты."),
    "contactExists" : MessageLookupByLibrary.simpleMessage("Контакт уже существует"),
    "contactHeader" : MessageLookupByLibrary.simpleMessage("Контакт"),
    "contactInvalid" : MessageLookupByLibrary.simpleMessage("Неверное имя контакта"),
    "contactNameHint" : MessageLookupByLibrary.simpleMessage("Введите имя @"),
    "contactNameMissing" : MessageLookupByLibrary.simpleMessage("Выберите имя для этого контакта"),
    "contactRemoved" : MessageLookupByLibrary.simpleMessage("%1 удален из контактов!"),
    "contactsHeader" : MessageLookupByLibrary.simpleMessage("Контакты"),
    "contactsImportErr" : MessageLookupByLibrary.simpleMessage("Не удалось импортировать контакты"),
    "contactsImportSuccess" : MessageLookupByLibrary.simpleMessage("Успешно импортировано %1 контактов."),
    "copied" : MessageLookupByLibrary.simpleMessage("Скопировано"),
    "copiedSuccesfullyMessage" : MessageLookupByLibrary.simpleMessage("Фраза сохранена."),
    "copy" : MessageLookupByLibrary.simpleMessage("Копировать"),
    "copyAddress" : MessageLookupByLibrary.simpleMessage("Копировать адрес"),
    "copySeed" : MessageLookupByLibrary.simpleMessage("Копировать seed"),
    "createAPasswordHeader" : MessageLookupByLibrary.simpleMessage("Создайте пароль."),
    "createPasswordFirstParagraph" : MessageLookupByLibrary.simpleMessage("Вы можете создать пароль, чтобы повысить безопасность своего кошелька."),
    "createPasswordHint" : MessageLookupByLibrary.simpleMessage("Создайте пароль"),
    "createPasswordSecondParagraph" : MessageLookupByLibrary.simpleMessage("Пароль не является обязательным, и ваш кошелек будет защищен вашим PIN-кодом или биометрическими данными в любом случае."),
    "createPasswordSheetHeader" : MessageLookupByLibrary.simpleMessage("Создайте"),
    "createWallet" : MessageLookupByLibrary.simpleMessage("Создать кошелек"),
    "currency" : MessageLookupByLibrary.simpleMessage("Валюта"),
    "currentlyRepresented" : MessageLookupByLibrary.simpleMessage("В настоящее время представлен"),
    "defaultAccountName" : MessageLookupByLibrary.simpleMessage("Основной аккаунт"),
    "defaultNewAccountName" : MessageLookupByLibrary.simpleMessage("Аккаунт %1"),
    "disablePasswordSheetHeader" : MessageLookupByLibrary.simpleMessage("Запретить"),
    "disablePasswordSuccess" : MessageLookupByLibrary.simpleMessage("Пароль был отключен"),
    "disableWalletPassword" : MessageLookupByLibrary.simpleMessage("Отключить пароль кошелька"),
    "encryptionFailedError" : MessageLookupByLibrary.simpleMessage("Не удалось установить пароль кошелька"),
    "enterAddress" : MessageLookupByLibrary.simpleMessage("Введите адрес"),
    "enterAmount" : MessageLookupByLibrary.simpleMessage("Введите количество"),
    "enterPasswordHint" : MessageLookupByLibrary.simpleMessage("Введите ваш пароль"),
    "ercWalletNoExists" : MessageLookupByLibrary.simpleMessage("Кошельки ERC20 не обнаружены."),
    "errorCameraRestriction" : MessageLookupByLibrary.simpleMessage("Пользователь не предоставил разрешение камере!"),
    "errorInvalidInputsPush" : MessageLookupByLibrary.simpleMessage("Недействительные значения для push-транзакции"),
    "errorOnPinInput" : MessageLookupByLibrary.simpleMessage("Неверный PIN-код"),
    "exampleCardFrom" : MessageLookupByLibrary.simpleMessage("от кого-то"),
    "exampleCardIntro" : MessageLookupByLibrary.simpleMessage("Добро пожаловать в кошелек Fusion. Как только вы получите FUSION, транзакции будут выглядеть следующим образом:"),
    "exampleCardLittle" : MessageLookupByLibrary.simpleMessage("Немного"),
    "exampleCardLot" : MessageLookupByLibrary.simpleMessage("Полно"),
    "exampleCardTo" : MessageLookupByLibrary.simpleMessage("кому-то"),
    "exit" : MessageLookupByLibrary.simpleMessage("Выход"),
    "feedbackWasSended" : MessageLookupByLibrary.simpleMessage("Успешно отправлено. Спасибо за отзыв."),
    "fingerprintSeedBackup" : MessageLookupByLibrary.simpleMessage("Авторизуйтесь в резервной копии."),
    "flashAddressCopied" : MessageLookupByLibrary.simpleMessage("Адрес скопирован в буфер обмена."),
    "flashFundsSended" : MessageLookupByLibrary.simpleMessage("Успешно отправлено"),
    "flashIncorrectWordMessage" : MessageLookupByLibrary.simpleMessage("Неправильное слово. Пожалуйста, попробуйте еще раз"),
    "flashOperationFailed" : MessageLookupByLibrary.simpleMessage("Операция завершилась неудачно."),
    "flashOperationSuccess" : MessageLookupByLibrary.simpleMessage("Операция завершена успешно"),
    "generatingWalletMessage" : MessageLookupByLibrary.simpleMessage("Идет создание кошелька"),
    "goBackButton" : MessageLookupByLibrary.simpleMessage("Назад"),
    "gotItButton" : MessageLookupByLibrary.simpleMessage("Понял!"),
    "hideAccountHeader" : MessageLookupByLibrary.simpleMessage("Скрыть аккаунт?"),
    "hintSendedFrom" : MessageLookupByLibrary.simpleMessage("Отправка из"),
    "historyNoAccountError" : MessageLookupByLibrary.simpleMessage("Пожалуйста, выберите аккаунт, чтобы просмотреть историю."),
    "iUnderstandTheRisks" : MessageLookupByLibrary.simpleMessage("Я понимаю риски"),
    "import" : MessageLookupByLibrary.simpleMessage("Импортировать"),
    "importSecretPhrase" : MessageLookupByLibrary.simpleMessage("Импортировать секретную фразу"),
    "importSecretPhraseHint" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите вашу секретную фразу из 12 слов ниже. Каждое слово следует разделять пробелом."),
    "importSeed" : MessageLookupByLibrary.simpleMessage("Импорт seed"),
    "importSeedHint" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите ваше seed ниже."),
    "importSeedInstead" : MessageLookupByLibrary.simpleMessage("Импортировать seed вместо"),
    "importWallet" : MessageLookupByLibrary.simpleMessage("Импорт кошелька"),
    "inputAccountNameHelperText" : MessageLookupByLibrary.simpleMessage("Имя профиля"),
    "inputAccountNameHintText" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите имя для аккаунта."),
    "inputAddContactAddressHint" : MessageLookupByLibrary.simpleMessage("Введите адрес"),
    "inputAddContactNameHint" : MessageLookupByLibrary.simpleMessage("Имя контакта"),
    "inputAddressHint" : MessageLookupByLibrary.simpleMessage("Введите адрес"),
    "inputEditAccountNameHint" : MessageLookupByLibrary.simpleMessage("Имя аккаунта"),
    "inputEditAccountNameTitle" : MessageLookupByLibrary.simpleMessage("Изменить имя"),
    "inputEnterScanPasshpraseHintText" : MessageLookupByLibrary.simpleMessage("Введите фразу или сканируйте QR"),
    "inputFeedbackCommentHint" : MessageLookupByLibrary.simpleMessage("Расскажите о проблеме"),
    "inputFundsStakeHint" : MessageLookupByLibrary.simpleMessage("Ставка"),
    "inputMaxAmountSuffix" : MessageLookupByLibrary.simpleMessage("MAX"),
    "inputSearchContactHint" : MessageLookupByLibrary.simpleMessage("Поиск контактов"),
    "instabugInfoMessage" : MessageLookupByLibrary.simpleMessage("Встряхните устройство, чтобы открыть специальный инструмент сообщения об ошибке."),
    "instantly" : MessageLookupByLibrary.simpleMessage("немедленно"),
    "insufficientBalance" : MessageLookupByLibrary.simpleMessage("Недостаточный баланс"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Введенный адрес недействителен"),
    "invalidInput" : MessageLookupByLibrary.simpleMessage("Некорректный ввод. Проверьте свои параметры и попробуйте еще раз"),
    "invalidPassword" : MessageLookupByLibrary.simpleMessage("Неверный пароль"),
    "kaliumWallet" : MessageLookupByLibrary.simpleMessage("Fusion Wallet"),
    "labelAccount" : MessageLookupByLibrary.simpleMessage("Аккаунт:"),
    "labelAddContactAddress" : MessageLookupByLibrary.simpleMessage("Адрес"),
    "labelAddContactName" : MessageLookupByLibrary.simpleMessage("Имя"),
    "labelAddress" : MessageLookupByLibrary.simpleMessage("Адрес"),
    "labelAgain" : MessageLookupByLibrary.simpleMessage("Снова"),
    "labelAlreadyHaveAccount" : MessageLookupByLibrary.simpleMessage("Есть аккаунт?"),
    "labelAmount" : MessageLookupByLibrary.simpleMessage("Количество"),
    "labelBackupPassphraseCaption" : MessageLookupByLibrary.simpleMessage("Чтобы восстановить доступ к утерянному аккаунту, напечатайте или сохраните ключ в надежном месте."),
    "labelBackupPassphraseSubtitle" : MessageLookupByLibrary.simpleMessage("Сохраните контрольную фразу"),
    "labelBuy" : MessageLookupByLibrary.simpleMessage("BUY"),
    "labelCancel" : MessageLookupByLibrary.simpleMessage("Отменить"),
    "labelChooseAccType" : MessageLookupByLibrary.simpleMessage("Выберите тип кошелька"),
    "labelChoosePassSubtitle" : MessageLookupByLibrary.simpleMessage("Введите ПИН код на 6 символов"),
    "labelChoosePassVerifySubtitle" : MessageLookupByLibrary.simpleMessage("Повторите ввод"),
    "labelCoin" : MessageLookupByLibrary.simpleMessage("Монета"),
    "labelContacts" : MessageLookupByLibrary.simpleMessage("Контакты"),
    "labelContactsNotFoundError" : MessageLookupByLibrary.simpleMessage("Контакт не найден!"),
    "labelConvertCoinHave" : MessageLookupByLibrary.simpleMessage("Доступные валюты"),
    "labelConvertCoinWant" : MessageLookupByLibrary.simpleMessage("Желаемая валюта"),
    "labelConvertTransanctionFee" : MessageLookupByLibrary.simpleMessage("Комиссия за транзакцию:"),
    "labelConvertWillGet" : MessageLookupByLibrary.simpleMessage("Вы получите примерно"),
    "labelCryptoAvailable" : MessageLookupByLibrary.simpleMessage("Доступно"),
    "labelEnableBiometricSubtitle" : MessageLookupByLibrary.simpleMessage("Рекомендуется для повышенной безопасности."),
    "labelEnableBiometricTitle" : MessageLookupByLibrary.simpleMessage("Включить биометрическую аутентификацию?"),
    "labelEndDate" : MessageLookupByLibrary.simpleMessage("Конечная дата"),
    "labelErc20Wallet" : MessageLookupByLibrary.simpleMessage("Кошелек ERC20"),
    "labelExchangeCoins" : MessageLookupByLibrary.simpleMessage("Мои монеты"),
    "labelExchangeSimplex" : MessageLookupByLibrary.simpleMessage("Simplex"),
    "labelExchangeUseCash" : MessageLookupByLibrary.simpleMessage("Использовать счёт"),
    "labelFeedbackEmailSubtitle" : MessageLookupByLibrary.simpleMessage("Эл.почта (необяз.)"),
    "labelFeedbackNoteTitle" : MessageLookupByLibrary.simpleMessage("Заметка"),
    "labelFrom" : MessageLookupByLibrary.simpleMessage("Отправитель"),
    "labelMinterWallet" : MessageLookupByLibrary.simpleMessage("Minter"),
    "labelMyContacts" : MessageLookupByLibrary.simpleMessage("Мои контакты"),
    "labelName" : MessageLookupByLibrary.simpleMessage("Имя"),
    "labelNo" : MessageLookupByLibrary.simpleMessage("Нет"),
    "labelOk" : MessageLookupByLibrary.simpleMessage("Хорошо"),
    "labelPendingRewardSubtitle" : MessageLookupByLibrary.simpleMessage("Награда становиться подтвержденной после получения или отправки BIP"),
    "labelPendingRewardTitle" : MessageLookupByLibrary.simpleMessage("Ожидающие награды"),
    "labelPubkeyOrDomain" : MessageLookupByLibrary.simpleMessage("Публичный ключ или домен"),
    "labelQuestionIndicatorTitle" : m1,
    "labelReceiver" : MessageLookupByLibrary.simpleMessage("Получатель"),
    "labelRemove" : MessageLookupByLibrary.simpleMessage("Удалить"),
    "labelRewardsCaption" : MessageLookupByLibrary.simpleMessage("За информацией о наградах Fusion, посетите наш FAQ"),
    "labelSave" : MessageLookupByLibrary.simpleMessage("Сохранить"),
    "labelScanQr" : MessageLookupByLibrary.simpleMessage("Сканировать QR"),
    "labelSell" : MessageLookupByLibrary.simpleMessage("SELL"),
    "labelSender" : MessageLookupByLibrary.simpleMessage("Отправитель"),
    "labelStartDate" : MessageLookupByLibrary.simpleMessage("Начальная дата"),
    "labelTapToCopy" : MessageLookupByLibrary.simpleMessage("Нажмите чтобы скопировать"),
    "labelTo" : MessageLookupByLibrary.simpleMessage("Получатель"),
    "labelTotalReward" : MessageLookupByLibrary.simpleMessage("Общее к-во наград"),
    "labelTotalRewardTitle" : MessageLookupByLibrary.simpleMessage("Получено наград"),
    "labelTransanctionsHistoryTitle" : MessageLookupByLibrary.simpleMessage("История сделок"),
    "labelUnlockSubtitle" : MessageLookupByLibrary.simpleMessage("Введите 6-символьный ПИН код"),
    "labelUnlockTitle" : MessageLookupByLibrary.simpleMessage("Разблокировать"),
    "labelWordIndicatorSubtitle" : m2,
    "labelYes" : MessageLookupByLibrary.simpleMessage("Да"),
    "language" : MessageLookupByLibrary.simpleMessage("Язык"),
    "liveSupportButton" : MessageLookupByLibrary.simpleMessage("Служба поддержки"),
    "localeEnglishItem" : MessageLookupByLibrary.simpleMessage("English"),
    "localeRussianItem" : MessageLookupByLibrary.simpleMessage("Русский"),
    "lockAppSetting" : MessageLookupByLibrary.simpleMessage("Авторизоваться при запуске"),
    "locked" : MessageLookupByLibrary.simpleMessage("Заблокировано"),
    "logout" : MessageLookupByLibrary.simpleMessage("Выйти"),
    "logoutAction" : MessageLookupByLibrary.simpleMessage("Удалить Seed и выйти"),
    "logoutAreYouSure" : MessageLookupByLibrary.simpleMessage("Уверены ли вы?"),
    "logoutDetail" : MessageLookupByLibrary.simpleMessage("При выходе из системы  с этого устройства будет удалено все данные, связанные с Fusion. Если Ваш seed или фразу не будет сохранено, вы больше никогда не сможете получить доступ к своим средствам"),
    "logoutReassurance" : MessageLookupByLibrary.simpleMessage("Пока вы сделали резервную копию своей фразы, вам не о чем беспокоиться."),
    "manage" : MessageLookupByLibrary.simpleMessage("Управление"),
    "mantaError" : MessageLookupByLibrary.simpleMessage("Не удалось проверить запрос"),
    "manualEntry" : MessageLookupByLibrary.simpleMessage("Ручной ввод"),
    "menuItemEditAccountName" : MessageLookupByLibrary.simpleMessage("Изменить имя учетной записи"),
    "menuItemReferalLink" : MessageLookupByLibrary.simpleMessage("Реферальная ссылка"),
    "menuItemRemoveAccount" : MessageLookupByLibrary.simpleMessage("Удалить учетную запись"),
    "menuItemSetDefaults" : MessageLookupByLibrary.simpleMessage("Установить по умолчанию"),
    "menuItemShowQR" : MessageLookupByLibrary.simpleMessage("Показать QR и адрес"),
    "menuItemViewPassphrase" : MessageLookupByLibrary.simpleMessage("Просмотреть кодовую фразу"),
    "menuItemWithdrawFunds" : MessageLookupByLibrary.simpleMessage("Снять Средства"),
    "minimumSend" : MessageLookupByLibrary.simpleMessage("Минимальная сумма отправки составляет %1 BIP"),
    "mnemonicInvalidWord" : MessageLookupByLibrary.simpleMessage("%1 не является допустимым словом"),
    "mnemonicPhrase" : MessageLookupByLibrary.simpleMessage("Мнемоническая фраза"),
    "mnemonicSizeError" : MessageLookupByLibrary.simpleMessage("Секретная фраза может содержать не более 12 слов"),
    "navigationItemContacts" : MessageLookupByLibrary.simpleMessage("Контакты"),
    "navigationItemHistory" : MessageLookupByLibrary.simpleMessage("История"),
    "navigationItemSettings" : MessageLookupByLibrary.simpleMessage("Настройки"),
    "navigationLabelAccounts" : MessageLookupByLibrary.simpleMessage("Аккаунты"),
    "navigationLabelExchange" : MessageLookupByLibrary.simpleMessage("Обмен"),
    "newAccountIntro" : MessageLookupByLibrary.simpleMessage("Это ваша новая учетная запись. Как только вы получите BIP, транзакции будут выглядеть следующим образом:"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("Новый кошелек"),
    "nextButton" : MessageLookupByLibrary.simpleMessage("Далее"),
    "no" : MessageLookupByLibrary.simpleMessage("Нет"),
    "noContactsExport" : MessageLookupByLibrary.simpleMessage("Нет контактов для экспорта."),
    "noContactsImport" : MessageLookupByLibrary.simpleMessage("Нет новых контактов для импорта."),
    "noContactsTitle" : MessageLookupByLibrary.simpleMessage("Никаких контактов пока нет."),
    "noNotificationsAvailable" : MessageLookupByLibrary.simpleMessage("Никаких уведомлений не поступало"),
    "noSkipButton" : MessageLookupByLibrary.simpleMessage("Нет,  пропустить"),
    "notificationBody" : MessageLookupByLibrary.simpleMessage("Откройте Fusion, чтобы просмотреть эту транзакцию"),
    "notificationHeaderSupplement" : MessageLookupByLibrary.simpleMessage("Нажмите, чтобы открыть"),
    "notificationTitle" : MessageLookupByLibrary.simpleMessage("Получено %1"),
    "notifications" : MessageLookupByLibrary.simpleMessage("Уведомления"),
    "off" : MessageLookupByLibrary.simpleMessage("Откл"),
    "onStr" : MessageLookupByLibrary.simpleMessage("На"),
    "paperWallet" : MessageLookupByLibrary.simpleMessage("Бумажный кошелек"),
    "passwordBlank" : MessageLookupByLibrary.simpleMessage("Пароль не может быть пустым"),
    "passwordNoLongerRequiredToOpenParagraph" : MessageLookupByLibrary.simpleMessage("Вам больше не потребуется пароль для открытия Fusion."),
    "passwordWillBeRequiredToOpenParagraph" : MessageLookupByLibrary.simpleMessage("Этот пароль потребуется для открытия Fusion."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Пароли не совпадают"),
    "pickFromList" : MessageLookupByLibrary.simpleMessage("Выбрать из списка"),
    "pinConfirmError" : MessageLookupByLibrary.simpleMessage("PIN не совпадают"),
    "pinConfirmTitle" : MessageLookupByLibrary.simpleMessage("Подтвердите свой PIN-код"),
    "pinCreateTitle" : MessageLookupByLibrary.simpleMessage("Создайте 6-значный PIN-код"),
    "pinEnterTitle" : MessageLookupByLibrary.simpleMessage("Введите пин-код"),
    "pinInvalid" : MessageLookupByLibrary.simpleMessage("Введен неверный PIN-код"),
    "pinMethod" : MessageLookupByLibrary.simpleMessage("PIN"),
    "pinRepChange" : MessageLookupByLibrary.simpleMessage("Введите ПИН-код, чтобы сменить представителя"),
    "pinSeedBackup" : MessageLookupByLibrary.simpleMessage("Введите PIN-код для резервного копирования"),
    "popupAccVerificationWelcomeText" : MessageLookupByLibrary.simpleMessage("Добро пожаловать! Вы можете начать пользоваться кошельком."),
    "popupPassVerifiedBody" : MessageLookupByLibrary.simpleMessage("Ваша контрольная фраза создана. Сохраните её в надежном месте ради возможности в будущем восстановить аккаунт."),
    "popupPassVerifiedTitle" : MessageLookupByLibrary.simpleMessage("Контр.фраза подтверждена!"),
    "popupRemoveAccountBody" : MessageLookupByLibrary.simpleMessage("Вы точно хотите удалить аккаунт? "),
    "popupRemoveAccountTitle" : MessageLookupByLibrary.simpleMessage("Удаление аккаунта"),
    "preferences" : MessageLookupByLibrary.simpleMessage("Настройки"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
    "privateKeyCopied" : MessageLookupByLibrary.simpleMessage("Приватный ключ скопирован!"),
    "pushFundsNotApplied" : MessageLookupByLibrary.simpleMessage("Вложение средств было завершено с неожиданной ошибкой."),
    "pushFundsSuccesfullyApplied" : MessageLookupByLibrary.simpleMessage("Средства были успешно добавлены в ваш кошелек."),
    "pushLinkWasCopied" : MessageLookupByLibrary.simpleMessage("Ссылка скопирована в буфер обмена."),
    "qrInvalidAddress" : MessageLookupByLibrary.simpleMessage("QR-код не содержит действительного адреса"),
    "qrInvalidPermissions" : MessageLookupByLibrary.simpleMessage("Пожалуйста, предоставьте разрешение камеры на сканирование QR-кодов"),
    "qrInvalidSeed" : MessageLookupByLibrary.simpleMessage("QR-код не содержит действительного seed или закрытого ключа"),
    "qrMnemonicError" : MessageLookupByLibrary.simpleMessage("QR не содержит действительной секретной фразы"),
    "qrUnknownError" : MessageLookupByLibrary.simpleMessage("Не удалось прочитать QR-код"),
    "rawSeed" : MessageLookupByLibrary.simpleMessage("Seed"),
    "receive" : MessageLookupByLibrary.simpleMessage("Получать"),
    "received" : MessageLookupByLibrary.simpleMessage("Получено"),
    "removeAccountText" : MessageLookupByLibrary.simpleMessage("Вы уверены, что хотите скрыть эту учетную запись? Вы можете повторно добавить его позже, нажав кнопку «% 1»."),
    "removeContact" : MessageLookupByLibrary.simpleMessage("Удалить контакт"),
    "removeContactConfirmation" : MessageLookupByLibrary.simpleMessage("Вы уверены, что хотите удалить %1?"),
    "repInfo" : MessageLookupByLibrary.simpleMessage("Представитель - это аккаунт, голосующий за сетевой консенсус. Право голоса взвешивается по балансу, вы можете делегировать свой баланс, чтобы увеличить вес голоса представителя, которому вы доверяете."),
    "repInfoHeader" : MessageLookupByLibrary.simpleMessage("Что такое представитель?"),
    "representatives" : MessageLookupByLibrary.simpleMessage("Представители"),
    "requireAPasswordToOpenHeader" : MessageLookupByLibrary.simpleMessage("Требовать пароль для открытия Fusion?"),
    "rootWarning" : MessageLookupByLibrary.simpleMessage("Похоже, что ваше устройство \"внедрено\", \"взломано\" или модифицировано таким образом, что ставит под угрозу безопасность. Перед продолжением рекомендуется сбросить устройство в исходное состояние."),
    "scanInstructions" : MessageLookupByLibrary.simpleMessage("Отсканируйте QR-код Mx-адреса"),
    "scanQrCode" : MessageLookupByLibrary.simpleMessage("Сканировать QR-код"),
    "secretInfo" : MessageLookupByLibrary.simpleMessage("На следующем экране вы увидите свою секретную фразу. Это пароль для доступа к вашим средствам. Очень важно сделать резервную копию и никогда никому не рассказывать."),
    "secretInfoHeader" : MessageLookupByLibrary.simpleMessage("Безопасность прежде всего!"),
    "secretPhrase" : MessageLookupByLibrary.simpleMessage("Секретная фраза"),
    "secretPhraseCopied" : MessageLookupByLibrary.simpleMessage("Секретная фраза скопирована"),
    "secretPhraseCopy" : MessageLookupByLibrary.simpleMessage("Копировать секретную фразу"),
    "secretWarning" : MessageLookupByLibrary.simpleMessage("Если вы потеряете свое устройство или удалите приложение, вам понадобится секретная фраза или начальное число, чтобы вернуть свои средства!"),
    "securityHeader" : MessageLookupByLibrary.simpleMessage("Безопасность"),
    "seed" : MessageLookupByLibrary.simpleMessage("Seed"),
    "seedBackupInfo" : MessageLookupByLibrary.simpleMessage("Ниже находится seed вашего кошелька. Крайне важно, чтобы вы делали резервную копию своего seed и никогда не сохраняли его в виде открытого текста или снимка экрана."),
    "seedCopied" : MessageLookupByLibrary.simpleMessage("Seed скопировано в буфер обмена\nЕго можно скопировать в течение 2 минут."),
    "seedCopiedShort" : MessageLookupByLibrary.simpleMessage("Seed скопировано"),
    "seedDescription" : MessageLookupByLibrary.simpleMessage("Seed содержит ту же информацию, что и секретная фраза, но в машиночитаемом виде. Пока у вас есть резервная копия одного из них, у вас будет доступ к своим средствам."),
    "seedInvalid" : MessageLookupByLibrary.simpleMessage("Seed недействителен"),
    "send" : MessageLookupByLibrary.simpleMessage("Отправить"),
    "sendAmountConfirm" : MessageLookupByLibrary.simpleMessage("Отправить %1 Fusion"),
    "sendError" : MessageLookupByLibrary.simpleMessage("Произошла ошибка. Попробуйте позже."),
    "sendFrom" : MessageLookupByLibrary.simpleMessage("Отправлено из"),
    "sendFundsToPushWallet" : m3,
    "sending" : MessageLookupByLibrary.simpleMessage("Отправка"),
    "sent" : MessageLookupByLibrary.simpleMessage("Отправил"),
    "sentTo" : MessageLookupByLibrary.simpleMessage("Отправлено "),
    "setPassword" : MessageLookupByLibrary.simpleMessage("Установка пароля"),
    "setPasswordSuccess" : MessageLookupByLibrary.simpleMessage("Пароль установлен успешно"),
    "setWalletPassword" : MessageLookupByLibrary.simpleMessage("Установить пароль кошелька"),
    "settingsHeader" : MessageLookupByLibrary.simpleMessage("Настройки"),
    "settingsItemBiometricFeature" : MessageLookupByLibrary.simpleMessage("Биометрическая аутентификация"),
    "settingsItemChgPassword" : MessageLookupByLibrary.simpleMessage("Установить/сменить пароль"),
    "settingsItemFaq" : MessageLookupByLibrary.simpleMessage("Часто задаваемые вопросы"),
    "settingsItemLanguage" : MessageLookupByLibrary.simpleMessage("Язык"),
    "settingsItemNotifications" : MessageLookupByLibrary.simpleMessage("Уведомления"),
    "settingsItemSendFeedback" : MessageLookupByLibrary.simpleMessage("Отправить отзыв"),
    "settingsItemShowRewards" : MessageLookupByLibrary.simpleMessage("Показать награды"),
    "settingsItemUiTheme" : MessageLookupByLibrary.simpleMessage("Включить темную тему"),
    "settingsTransfer" : MessageLookupByLibrary.simpleMessage("Загрузить из бумажного кошелька"),
    "shareNatrium" : MessageLookupByLibrary.simpleMessage("Поделиться Fusion"),
    "shareNatriumText" : MessageLookupByLibrary.simpleMessage("Оцените Fusion! Лучший мобильный кошелек BIP!"),
    "sharePushLink" : MessageLookupByLibrary.simpleMessage("Поделиться Push"),
    "showErcPrivateKeyDrawerLabel" : MessageLookupByLibrary.simpleMessage("Прив. ключ ERC20"),
    "successfullySavedPin" : MessageLookupByLibrary.simpleMessage("PIN-код успешно сохранено"),
    "supportButton" : MessageLookupByLibrary.simpleMessage("Cлужба поддержки"),
    "switchToSeed" : MessageLookupByLibrary.simpleMessage("Перейти на seed"),
    "systemDefault" : MessageLookupByLibrary.simpleMessage("Системные установки по умолчанию"),
    "tapToHide" : MessageLookupByLibrary.simpleMessage("Нажмите, чтобы скрыть"),
    "tapToReveal" : MessageLookupByLibrary.simpleMessage("Нажмите, чтобы открыть"),
    "themeHeader" : MessageLookupByLibrary.simpleMessage("Тема"),
    "to" : MessageLookupByLibrary.simpleMessage("Кому"),
    "toastTryAgain" : MessageLookupByLibrary.simpleMessage("Пожалуйста, попробуйте еще раз"),
    "tooManyFailedAttempts" : MessageLookupByLibrary.simpleMessage("Слишком много неудачных попыток разблокировки."),
    "toolbarAddContactTitle" : MessageLookupByLibrary.simpleMessage("Добавить контакт"),
    "toolbarChoosePassTitle" : MessageLookupByLibrary.simpleMessage("Создание пароля"),
    "toolbarContactsTitle" : MessageLookupByLibrary.simpleMessage("Контакты"),
    "toolbarConvertTitle" : MessageLookupByLibrary.simpleMessage("Конвертация"),
    "toolbarExchangeTitle" : MessageLookupByLibrary.simpleMessage("Обмен"),
    "toolbarHistoryTitle" : MessageLookupByLibrary.simpleMessage("История"),
    "toolbarNewAccountTitle" : MessageLookupByLibrary.simpleMessage("Новый аккаунт"),
    "toolbarRateTitle" : MessageLookupByLibrary.simpleMessage("Курс"),
    "toolbarRecoverFromSeedTitle" : MessageLookupByLibrary.simpleMessage("Восстановить по фразе"),
    "toolbarRewards" : MessageLookupByLibrary.simpleMessage("Награды"),
    "toolbarScanQrTitle" : MessageLookupByLibrary.simpleMessage("Кодовая фраза QR"),
    "toolbarSendTitle" : MessageLookupByLibrary.simpleMessage("Отправить"),
    "toolbarSharePasshpraseQr" : MessageLookupByLibrary.simpleMessage("Просмотр контр.фразы"),
    "toolbarTermsConditionsTitle" : MessageLookupByLibrary.simpleMessage("Правила и использование"),
    "toolbarTitleShowPassphrase" : MessageLookupByLibrary.simpleMessage("Показать кодовую фразу"),
    "toolbarViewPasshraseTitle" : MessageLookupByLibrary.simpleMessage("Показать фразу"),
    "toolbarWidgetsTitle" : MessageLookupByLibrary.simpleMessage("Компоненты"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Операции"),
    "transfer" : MessageLookupByLibrary.simpleMessage("Перечислить"),
    "transferClose" : MessageLookupByLibrary.simpleMessage("Коснитесь в любом месте, чтобы закрыть окно."),
    "transferComplete" : MessageLookupByLibrary.simpleMessage("%1 успешно переведен в ваш Fusion Wallet."),
    "transferConfirmInfo" : MessageLookupByLibrary.simpleMessage("Обнаружен кошелек с балансом %1.\n"),
    "transferConfirmInfoSecond" : MessageLookupByLibrary.simpleMessage("Нажмите «Подтвердить», чтобы перевести средства.\n"),
    "transferConfirmInfoThird" : MessageLookupByLibrary.simpleMessage("Передача может занять несколько секунд."),
    "transferError" : MessageLookupByLibrary.simpleMessage("Во время передачи произошла ошибка. Пожалуйста, попробуйте позже."),
    "transferHeader" : MessageLookupByLibrary.simpleMessage("Перевод средств"),
    "transferIntro" : MessageLookupByLibrary.simpleMessage("Этот процесс переведет средства с бумажного кошелька на ваш кошелек Fusion.\n\nНажмите кнопку «%1», чтобы начать."),
    "transferLoading" : MessageLookupByLibrary.simpleMessage("Передача"),
    "transferManualHint" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите seed ниже."),
    "transferNoFunds" : MessageLookupByLibrary.simpleMessage("На этом seed нет BIP"),
    "transferQrScanError" : MessageLookupByLibrary.simpleMessage("Этот QR-код не содержит действительного seed."),
    "transferQrScanHint" : MessageLookupByLibrary.simpleMessage("Сканирование начального или закрытого ключа Fusion"),
    "unlock" : MessageLookupByLibrary.simpleMessage("Разблокировать"),
    "unlockBiometrics" : MessageLookupByLibrary.simpleMessage("Выполните аутентификацию, чтобы разблокировать Fusion"),
    "unlockPin" : MessageLookupByLibrary.simpleMessage("Введите PIN-код, чтобы разблокировать Fusion"),
    "uptime" : MessageLookupByLibrary.simpleMessage("Время работы"),
    "userAuthorized" : MessageLookupByLibrary.simpleMessage("Пользователь авторизован"),
    "userNotAuthorized" : MessageLookupByLibrary.simpleMessage("Пользователь не авторизован"),
    "validateAddressError" : MessageLookupByLibrary.simpleMessage("Должен быть действующий адрес Minter с префиксом Mx"),
    "viewDetails" : MessageLookupByLibrary.simpleMessage("Посмотреть детали"),
    "votingWeight" : MessageLookupByLibrary.simpleMessage("Вес голосования"),
    "warning" : MessageLookupByLibrary.simpleMessage("Предупреждение"),
    "welcomeText" : MessageLookupByLibrary.simpleMessage("Добро пожаловать в Fusion. Для начала вы можете создать новый кошелек или импортировать существующий."),
    "xMinute" : MessageLookupByLibrary.simpleMessage("Через %1 минуту"),
    "xMinutes" : MessageLookupByLibrary.simpleMessage("Через %1 минут"),
    "yes" : MessageLookupByLibrary.simpleMessage("Да"),
    "yesButton" : MessageLookupByLibrary.simpleMessage("Да")
  };
}
