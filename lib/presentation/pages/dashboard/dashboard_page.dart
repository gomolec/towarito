import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/app/app_scaffold_messager.dart';
import '../../../core/navigation/router.gr.dart';
import '../../../domain/adapters/products_adapter.dart';
import '../../../domain/adapters/sessions_adapter.dart';
import '../../../injection_container.dart';
import '../../widgets/page_alert.dart';
import 'bloc/dashboard_bloc.dart';
import 'widgets/widgets.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        productsAdapter: sl<ProductsAdapter>(),
        sessionsAdapter: sl<SessionsAdapter>(),
        appScaffoldMessager: sl<AppScaffoldMessager>(),
      )..add(const DashboardSubscriptionRequested()),
      child: const DashboardPageView(),
    );
  }
}

class DashboardPageView extends StatelessWidget {
  const DashboardPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.face,
          color: theme.colorScheme.primary,
        ),
        title: const Text("Towarito"),
        titleSpacing: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_rounded,
            ),
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.status == DashboardStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!state.hasCurrentSession) {
            return PageAlert(
              leadingIconData: Icons.folder_off_rounded,
              title: "Brak aktywnej sesji",
              text:
                  "\tPrzywróć poprzednio utworzoną sesję lub utwórz nową, do której możesz dodać produkty lub zaimportuj je z obsługiwanych plików.",
              buttons: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.router.navigate(const SessionsRoute());
                  },
                  icon: const Icon(Icons.folder_copy),
                  label: const Text("Pokaż sesje użytkownika"),
                ),
              ],
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DashboardCard(
                        icon: const Icon(Icons.event_available_rounded),
                        title: "Aktualna sesja użytkownika",
                        subtitle:
                            "${state.currentSession!.name.isEmpty ? "Sesja bez nazwy" : state.currentSession?.name}\nUtworzona: ${DateFormat('dd.MM.y H:mm').format(state.currentSession!.created)}",
                        theme: theme,
                        height: 152.0,
                        onTap: () {
                          context.router.navigate(SessionRoute(
                            sessionId: state.currentSession!.id,
                          ));
                        },
                      ),
                      const SizedBox(height: 8.0),
                      CurrentSessionProgressCard(
                        value: state.sessionProgress,
                        height: 152.0,
                        theme: theme,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            child: DashboardCard(
                              icon: const Icon(Icons.create_new_folder_rounded),
                              title: "Utwórz",
                              subtitle:
                                  "Tworzy nowy produkt przy użyciu kreatora",
                              theme: theme,
                              height: 152.0,
                              onTap: () {
                                context.router.navigate(ProductRoute());
                              },
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: DashboardCard(
                              icon: const Icon(Icons.download_rounded),
                              title: "Import",
                              subtitle: "Pobiera pliki z zewnętrznego pliku",
                              theme: theme,
                              height: 152.0,
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                state.bookmarkedProducts.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "Zapisane produkty",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            primary: false,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: 16.0,
                                children: state.bookmarkedProducts
                                    .map(
                                      (e) => ProductCard(
                                        title: e.name,
                                        subtitle: e.code,
                                        theme: theme,
                                        width: 200.0,
                                        onTap: () {
                                          context.router.navigate(ProductRoute(
                                            initialProductId: e.id,
                                          ));
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 16.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
