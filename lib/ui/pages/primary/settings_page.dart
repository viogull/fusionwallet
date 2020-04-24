import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  static const navId = "/settings";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locales = AppLocalizations.of(context);

    return FusionScaffold(
      child: SizedBox.expand(
        child: SettingsList(
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile.switchTile(
                  title: AppLocalizations.of(context).settingsItemUiTheme(),
                  switchValue: false,
                  onToggle: (bool value) {},
                ),
                SettingsTile(
                  title: locales.settingsItemChgPassword(),
                  onTap: () {},
                ),
                SettingsTile.switchTile(
                  title: locales.settingsItemBiometricFeature(),
                  switchValue: false,
                  onToggle: (bool value) {},
                ),
                SettingsTile(
                  title: locales.settingsItemNotifications(),
                  onTap: () {
                    showPlatformModalSheet(
                        context: context,
                        androidShape: RoundedRectangleBorder(
                            borderRadius: FusionTheme.borderRadius),
                        androidBackgroundColor: theme.colorScheme.surface,
                        androidClipBehavior: Clip.antiAliasWithSaveLayer,
                        builder: (context) {
                          return SafeArea(
                            top: true,
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
                                          vertical: 8, horizontal: 64),
                                      child: Divider(
                                          height: 2,
                                          thickness: 4,
                                          color: Colors.white),
                                    );
                                  else
                                    return ListTile(
                                      title: AutoSizeText(
                                          'Notification Title $index'),
                                      subtitle: AutoSizeText('Subtitle $index'),
                                    );
                                }),
                          );
                        });
                  },
                ),
                SettingsTile.switchTile(
                    title: locales.settingsItemShowRewards(),
                    onToggle: (value) {},
                    switchValue: true),
                SettingsTile(
                  title: locales.settingsItemLanguage(),
                  subtitle: "English",
                  onTap: () {},
                )
              ],
            ),
            SettingsSection(
              tiles: [
                SettingsTile(
                  title: locales.settingsItemSendFeedback(),
                  onTap: () {},
                ),
                SettingsTile(
                  title: locales.settingsItemFaq(),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
