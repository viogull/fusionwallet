import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../core/models.dart';
import '../../inject.dart';
import '../../localizations.dart';
import '../widgets.dart';
import 'auth/pincode.dart';
import 'info/about.dart';
import 'info/faq.dart';
import 'info/feedback.dart';

class SettingsPage extends StatelessWidget {
  static const navId = "/settings";

  final logger = injector.get<Logger>();


  @override
  Widget build(BuildContext context) {
    final currentLocaleTitle =
        StateContainer.of(context).locale == Locale('en', '')
            ? AppLocalizations.of(context).localeEnglishItem()
            : AppLocalizations.of(context).localeRussianItem();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SwitchFusionPreference(
            title: AppLocalizations.of(context).settingsItemUiTheme(),
            value: StateContainer.of(context).darkModeEnabled,
            onSwitch: (updated) async {
              StateContainer.of(context)
                  .updateTheme(isDarkModeEnabled: !updated);
            },
          ),
          FusionPreference(
              title: AppLocalizations.of(context).settingsItemChgPassword(),
              onClick: () {
                Navigator.of(context).pushNamed(PasswordCreationPage.navId);
              }),
          SwitchFusionPreference(
            title: AppLocalizations.of(context).settingsItemBiometricFeature(),
            value: StateContainer.of(context).biometricEnabled,
            onSwitch: (updated) async {
              if (!updated) {
                final hasBiometrics =
                    await injector.get<BiometricUtil>().hasBiometrics();
                if (hasBiometrics) {
                  await injector
                      .get<BiometricUtil>()
                      .authenticateWithBiometrics(context,
                          AppLocalizations.of(context).unlockBiometrics)
                      .then((isSuccess) {
                    if (isSuccess) {
                      Future.delayed(Duration(milliseconds: 600), () {
                        FlashHelper.successBar(context,
                            message: AppLocalizations.of(context)
                                .changeRepAuthenticate);
                        StateContainer.of(context)
                            .setBiometric(!updated, save: true);
                      });
                    } else {
                      Future.delayed(Duration(milliseconds: 600), () {
                        FlashHelper.errorBar(context,
                            message:
                                AppLocalizations.of(context).unlockBiometrics);
                        StateContainer.of(context)
                            .setBiometric(!updated, save: false);
                      });
                    }
                  }).catchError((onError) {
                    logger.e(onError);
                  });
                }
              } else {
                StateContainer.of(context).setBiometric(updated, save: false);
                FlashHelper.errorBar(context,
                    message: AppLocalizations.of(context)
                        .labelEnableBiometricSubtitle());
              }
            },
          ),
          FusionPreference(
              title: AppLocalizations.of(context).settingsItemNotifications(),
              onClick: () {
                showBarModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return FusionScaffold(
                        hideToolbar: true,
                        appBarIcon: null,
                        child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box<AdminNotification>(notificationsBox)
                                  .listenable(),
                          builder: (context,
                              Box<AdminNotification> notifications, _) {
                            final _contacts = notifications.values.toList();

                            return SafeArea(
                              child: SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            flex: 1,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 12),
                                                child: Container(
                                                  child: Center(
                                                    child: Text(AppLocalizations.of(context).notifications),
                                                  )
                                                )),
                                          ),
                                          Flexible(
                                              flex: 8,
                                              child: AnimationLimiter(
                                                child: (notifications.isEmpty)
                                                    ? showEmptyView(context)
                                                    : ListView.builder(
                                                        reverse: false,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return AnimationConfiguration
                                                              .staggeredList(
                                                            position: index,
                                                            child: FadeInAnimation(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        600),
                                                                child: buildNotificationView(
                                                                    data: _contacts[
                                                                        index])),
                                                          );
                                                        },
                                                        itemCount:
                                                            _contacts.length,
                                                      ),
                                              ))
                                        ])),
                              ),
                            );
                          },
                        ),
                      );
                    });
              }),
          SwitchFusionPreference(
              title: AppLocalizations.of(context).settingsItemShowRewards(),
              value: StateContainer.of(context).selectedAccount.showRewards,
              onSwitch: (value) async {
                StateContainer.of(context)
                    .setRewardsVisibility(!value, save: true);
              }),
          FusionSingleChoicePreference(
              title: AppLocalizations.of(context).settingsItemLanguage(),
              items: AppLocalizations.fetchLanguages(context),
              selected: currentLocaleTitle,
              onSelected: (selectionIndex) {
                StateContainer.of(context).updateLanguage(
                    AppLocalizations.getLocaleBySelectionIndex(selectionIndex),
                    save: true);
              }),
          FusionPreference(
              title: AppLocalizations.of(context).settingsItemSendFeedback(),
              onClick: () {
                Navigator.pushNamed(context, SendFeedbackPage.navId);
              }),
          FusionPreference(
              title: AppLocalizations.of(context).settingsItemFaq(),
              onClick: () {
                Navigator.pushNamed(context, FaqPage.navId);
              }),
          FusionPreference(title: AppLocalizations.of(context).aboutBuildLabel(), onClick: () {
            showCupertinoModalBottomSheet(context: context, builder: (context) {
              return AboutBuildUi();
            });
          })
        ],
      ),
    );
  }

  Widget showEmptyView(BuildContext context) => Center(
      child: Text(AppLocalizations.of(context).noNotificationsAvailable()));

  Widget buildNotificationView({AdminNotification data}) => Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        elevation: 0.5,
        color: Colors.transparent,
        child: ListTile(
          title: Text(data.title),
          subtitle: Text(data.message),
          isThreeLine: false,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      );
}
