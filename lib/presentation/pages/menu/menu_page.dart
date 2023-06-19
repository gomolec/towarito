import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core/navigation/app_router.dart';
import 'widgets/menu_footer.dart';

import 'widgets/menu_list_tile.dart';
import 'widgets/user_info_tile.dart';

@RoutePage()
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuPageView();
  }
}

class MenuPageView extends StatelessWidget {
  const MenuPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const UserInfoHeader(),
            const SizedBox(height: 4.0),
            const MenuListTile(
              leadingIcon: Icons.person,
              title: "Profil użytkownika",
            ),
            MenuListTile(
              leadingIcon: Icons.timer_outlined,
              title: "Sesje",
              onTap: () {
                AutoRouter.of(context).root.navigate(const SessionsRoute());
              },
            ),
            MenuListTile(
              leadingIcon: Icons.file_download_outlined,
              title: "Import",
              onTap: () {
                AutoRouter.of(context).root.navigate(const ImportRoute());
              },
            ),
            const MenuListTile(
              leadingIcon: Icons.file_upload_outlined,
              title: "Eksport",
            ),
            const MenuListTile(
              leadingIcon: Icons.help_outline_rounded,
              title: "Pomoc",
            ),
            const MenuListTile(
              leadingIcon: Icons.settings_rounded,
              title: "Ustawienia",
            ),
            const MenuListTile(
              leadingIcon: Icons.exit_to_app_rounded,
              title: "Wyczyść dane",
            ),
            const MenuFooter(),
          ],
        ),
      ),
    );
  }
}
