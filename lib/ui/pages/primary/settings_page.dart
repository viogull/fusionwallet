import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/state_container.dart';
import 'package:fusion_wallet/ui/components/preferences/preference.dart';
import 'package:fusion_wallet/ui/components/preferences/preference_switch.dart';
import 'package:fusion_wallet/ui/components/preferences/single_choice_preference_item.dart';
import 'package:fusion_wallet/ui/pages/auth/biometric_features_page.dart';
import 'package:fusion_wallet/ui/pages/auth/password_creation_page.dart';
import 'package:fusion_wallet/ui/pages/information/faq_page.dart';
import 'package:fusion_wallet/ui/pages/information/send_feedback_page.dart';

import '../../components/fusion_sheet.dart';

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
              StateContainer.of(context).updateTheme(
                  !StateContainer.of(context).darkModeEnabled,
                  save: true);
            },
          ),
          FusionPreference(
              title: AppLocalizations.of(context).settingsItemChgPassword(),
              onClick: () {
                Navigator.of(context).pushNamed(PasswordCreationPage.navId);
              }),
          SwitchFusionPreference(
            title: AppLocalizations.of(context).settingsItemBiometricFeature(),
            value: true,
            onSwitch: (updated) {
              Navigator.of(context).pushNamed(BiometricAuthPage.navId);
            },
          ),
          FusionPreference(
              title: AppLocalizations.of(context).settingsItemNotifications(),
              onClick: () {
                Sheets.showFusionSheet(
                    context: context,
                    widget: SafeArea(
                      child: ListView.separated(
                          itemCount: 5,
                          separatorBuilder: (context, index) {
                            if (index != 0)
                              return Divider(
                                color: theme.colorScheme.onSurface,
                                height: 0.25,
                              );
                            else
                              return Container();
                          },
                          itemBuilder: (context, index) {
                            if (index == 0)
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 120),
                                child: Divider(
                                    height: 2,
                                    thickness: 4,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              );
                            else
                              return ListTile(
                                title:
                                    AutoSizeText('Notification Title $index'),
                                subtitle: AutoSizeText('Subtitle $index'),
                              );
                          }),
                    ));
              }),
          SwitchFusionPreference(
              title: AppLocalizations.of(context).settingsItemShowRewards(),
              value: StateContainer.of(context).showRewards,
              onSwitch: (value) {
                StateContainer.of(context).setRewardsVisibility(
                    !StateContainer.of(context).showRewards,
                    save: true);
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
        ],
      ),
    );
  }

//              SettingsTile(
//                title: locales.settingsItemChgPassword(),
//                onTap: () {},
//              ),
//              SettingsTile.switchTile(
//                title: locales.settingsItemBiometricFeature(),
//                switchValue: false,
//                onToggle: (bool value) {},
//              ),
//              SettingsTile(
//                title: locales.settingsItemNotifications(),
//                onTap: () {

//                },
//              ),
//              SettingsTile.switchTile(
//                  title: locales.settingsItemShowRewards(),
//                  onToggle: (value) {},
//                  switchValue: true),
//              SettingsTile(
//                title: locales.settingsItemLanguage(),
//                subtitle: "English",
//                onTap: () {},
//              )
//            ],
//          ),
//          SettingsSection(
//            tiles: [
//              SettingsTile(
//                title: locales.settingsItemSendFeedback(),
//                onTap: () {},
//              ),
//              SettingsTile(
//                title: locales.settingsItemFaq(),
//                onTap: () {},
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
}