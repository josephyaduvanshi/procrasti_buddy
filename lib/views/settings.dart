import 'package:flutter/material.dart';
import 'package:procrasti_buddy/widgets/settings_items_card.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: "Settings".text.make(),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              elevation: 1,
              child: Wrap(
                children: [
                  Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Settings".text.minFontSize(20).bold.make(),
                          "Theme Settings, Backup and Restore, App Updates!"
                              .text
                              .caption(context)
                              .make()
                              .py(8),
                        ],
                      ),
                    ],
                  ),
                ],
              ).p(8).p(7),
            ).py(12).px(5),
            SettingItemsCard(
              onTap: () {},
              title: "Appearance",
              subtitle: "Change Theme",
              icon: Icons.color_lens_outlined,
            ),
            SettingItemsCard(
              onTap: () {},
              title: "Notifications",
              subtitle: "Turn On/Off Notifications",
              icon: Icons.notifications_none_outlined,
            ),
            SettingItemsCard(
              title: "Backup/Restore",
              subtitle: "Backup/Restore your data",
              icon: Icons.backup_outlined,
              onTap: () {},
            ),
            SettingItemsCard(
              title: "App Version",
              subtitle: "Version: 1.1.0",
              icon: Icons.update_outlined,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
