import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/app_scaffold_messager.dart';
import '../../../domain/adapters/history_adapter.dart';
import '../../../injection_container.dart';
import '../../widgets/page_alert.dart';
import 'bloc/history_bloc.dart';
import 'widgets/history_tile.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(
        appScaffoldMessager: sl<AppScaffoldMessager>(),
        historyAdapter: sl<HistoryAdapter>(),
      )..add(const HistorySubscriptionRequested()),
      child: const HistoryPageView(),
    );
  }
}

class HistoryPageView extends StatelessWidget {
  const HistoryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) => CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              title: const Text("Historia"),
              actions: [
                IconButton(
                  onPressed: state.canUndo
                      ? () {
                          context
                              .read<HistoryBloc>()
                              .add(const HistoryUndone());
                        }
                      : null,
                  tooltip: "Cofnij",
                  icon: const Icon(Icons.undo_rounded),
                ),
                IconButton(
                  onPressed: state.canRedo
                      ? () {
                          context
                              .read<HistoryBloc>()
                              .add(const HistoryRedone());
                        }
                      : null,
                  tooltip: "Ponów",
                  icon: const Icon(Icons.redo_rounded),
                ),
              ],
            ),
            () {
              if (state.status != HistoryStatus.success) {
                return SliverToBoxAdapter(
                  child: PageAlert(
                    leadingIconData: Icons.folder_off_rounded,
                    title: "Brak aktywnej sesji",
                    text:
                        "\tPrzywróć poprzednio utworzoną sesję lub utwórz nową, do której możesz dodać produkty lub zaimportuj je z obsługiwanych plików.",
                    buttons: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context.beamToNamed('/sessions');
                        },
                        icon: const Icon(Icons.folder_copy),
                        label: const Text("Pokaż sesje użytkownika"),
                      ),
                    ],
                  ),
                );
              }
              if (state.history.isEmpty) {
                return const SliverToBoxAdapter(
                  child: PageAlert(
                    leadingIconData: Icons.history_toggle_off_rounded,
                    title: "Brak historii",
                    text:
                        "\tPodczas dodawania, edycji lub usuwania produktów znajdować się tutaj będzie podgląd wykonanych akcji. Dzięki przyciskom na górnym pasku możesz je łatwo cofać i ponawiać. ",
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        HistoryActionTile(
                          historyAction: state.history[index],
                        ),
                      ],
                    );
                  },
                  childCount: state.history.length,
                ),
              );
            }()
          ],
        ),
      ),
    );
  }
}
