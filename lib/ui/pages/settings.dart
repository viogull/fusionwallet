import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fusion_wallet/core/abstract/admin_notification.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/inject.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/components/preferences/preference.dart';
import 'package:fusion_wallet/ui/components/preferences/preference_switch.dart';
import 'package:fusion_wallet/ui/components/preferences/single_choice_preference_item.dart';
import 'package:fusion_wallet/ui/pages/auth/pincode.dart';
import 'package:fusion_wallet/ui/pages/bottom_home.dart';
import 'package:fusion_wallet/ui/pages/information/faq_page.dart';
import 'package:fusion_wallet/ui/pages/information/send_feedback_page.dart';
import 'package:fusion_wallet/utils/biometric.dart';
import 'package:fusion_wallet/utils/flasher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:package_info/package_info.dart';

import '../../core/models.dart';

class SettingsPage extends StatelessWidget {
  static const navId = "/settings";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              if(!updated) {
                final hasBiometrics = await injector.get<BiometricUtil>().hasBiometrics();
                if(hasBiometrics) {
                  await injector.get<BiometricUtil>()
                      .authenticateWithBiometrics(context, AppLocalizations.of(context)
                      .unlockBiometrics)
                      .then((isSuccess) {
                        if(isSuccess) {
                          Future.delayed(Duration(milliseconds: 600), () {
                            FlashHelper.successBar(context, message:
                            AppLocalizations.of(context).changeRepAuthenticate);
                            StateContainer.of(context).setBiometric(!updated, save: true);

                          });
                        }
                        else {
                          Future.delayed(Duration(milliseconds: 600), () {
                            FlashHelper.errorBar(context, message: AppLocalizations.of(context).unlockBiometrics);
                            StateContainer.of(context).setBiometric(!updated, save: false);

                          });
                        }
                  }).catchError((onError) {
                    logger.e(onError);
                  });

                }
              } else {
                StateContainer.of(context).setBiometric(updated, save: false);
                FlashHelper.errorBar(context,
                    message: AppLocalizations.of(context).labelEnableBiometricSubtitle());

              }
            },
          ),
          FusionPreference(
              title: AppLocalizations.of(context).settingsItemNotifications(),
              onClick: () {
                showBarModalBottomSheet(
                    context: context,
                    builder: (builder, scroll) {

              return FusionScaffold(
                hideToolbar: true,
                appBarIcon: null,
                child: ValueListenableBuilder(
                 valueListenable: Hive.box<AdminNotification>(notificationsBox)
                    .listenable(),
                builder: (context, Box<AdminNotification> notifications, _) {
                final _contacts = notifications.values.toList();

                return SafeArea(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(

                    constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.99,
                    ),
                    child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                    Flexible(
                    flex: 1,
                    child: Padding(
                    padding: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 12),
                    child: Container()
                    ),
                    ),
                    Flexible(
                    flex: 8,
                    child: AnimationLimiter(
                    child:(notifications.isEmpty)
                    ? showEmptyView(context)
                        : ListView.builder(
                      reverse: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                    child: FadeInAnimation(
                    duration: Duration(milliseconds: 600),
                    child: NotificationView(data: _contacts[index])
                    ),
                    );


                    },
                    itemCount: _contacts.length,
                    ) ,
                    )
                    )
                    ])),
                  ),
                );
                },
                ),
              );
              }
                              );
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
              })
        ],
      ),
    );
  }

  Widget showEmptyView(BuildContext context) =>
      Center(child: Text(AppLocalizations.of(context).noContactsTitle()));

  Widget NotificationView({AdminNotification data}) => Card(
    margin: const EdgeInsets.symmetric(vertical: 4,
        horizontal: 12),
    elevation:4,
    color: Colors.transparent,
    child: ListTile(
      title: Text(data.title),
      subtitle: Text(data.message),
      isThreeLine: false,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
  );
}



