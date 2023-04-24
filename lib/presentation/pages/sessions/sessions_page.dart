import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app/app_scaffold_messager.dart';

import '../../../core/navigation/router.gr.dart';
import '../../../domain/adapters/sessions_adapter.dart';
import '../../../injection_container.dart';
import 'bloc/sessions_bloc.dart';
import 'widgets/session_tile.dart';

@RoutePage()
class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionsBloc(
          sessionsAdapter: sl<SessionsAdapter>(),
          appScaffoldMessager: sl<AppScaffoldMessager>())
        ..add(const SessionsSubscriptionRequested()),
      child: const SessionsPageView(),
    );
  }
}

class SessionsPageView extends StatelessWidget {
  const SessionsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            leading: IconButton(
              onPressed: () {
                context.router.pop();
              },
              tooltip: 'Wróć',
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: const Text("Sesje użytkownika"),
            actions: [
              IconButton(
                onPressed: () {},
                tooltip: 'Importuj sesję',
                icon: const Icon(Icons.file_download_outlined),
              ),
              IconButton(
                onPressed: () {
                  context.router.push(SessionRoute());
                },
                tooltip: 'Utwórz sesję',
                icon: const Icon(Icons.add_circle_outline_rounded),
              ),
            ],
          ),
          BlocBuilder<SessionsBloc, SessionsState>(
            builder: (context, state) {
              if (state.status == SessionsStatus.success) {
                final sessions = List.of(state.sessions);
                if (state.hasCurrentSession) {
                  sessions.insert(0, state.currentSession!);
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (state.hasCurrentSession && index == 0) {
                        return Column(
                          children: [
                            SessionTile(
                              session: sessions[index],
                              current: true,
                            ),
                            const Divider(
                              height: 8,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                          ],
                        );
                      }
                      return SessionTile(
                        session: sessions[index],
                      );
                    },
                    childCount: sessions.length,
                  ),
                );
              } else {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
