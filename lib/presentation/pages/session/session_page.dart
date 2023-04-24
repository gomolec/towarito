import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:towarito/core/app/app_scaffold_messager.dart';

import '../../../domain/adapters/sessions_adapter.dart';
import '../../../injection_container.dart';
import 'bloc/session_bloc.dart';
import 'widgets/widgets.dart';

@RoutePage()
class SessionPage extends StatelessWidget {
  final String? sessionId;
  const SessionPage({
    super.key,
    @PathParam() this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionBloc(
        sessionsAdapter: sl<SessionsAdapter>(),
        appScaffoldMessager: sl<AppScaffoldMessager>(),
      )..add(SessionSubscriptionRequested(initialSessionId: sessionId)),
      child: const SessionPageView(),
    );
  }
}

class SessionPageView extends StatelessWidget {
  const SessionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionBloc, SessionState>(
      listener: (context, state) {
        if (state.status == SessionStatus.failure ||
            state.status == SessionStatus.success) {
          context.router.pop();
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () {
                context.router.pop();
              },
            ),
            titleSpacing: 0.0,
            title: Text(state.isNewSession ? "Nowa sesja" : "Edytuj sesje"),
            actions: [
              IconButton(
                icon: const Icon(Icons.save_rounded),
                onPressed: state.status == SessionStatus.inProgress
                    ? () {
                        context
                            .read<SessionBloc>()
                            .add(const SessionSubmitted());
                      }
                    : null,
              ),
            ],
          ),
          body: state.status == SessionStatus.inProgress
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        NameTextField(),
                        SizedBox(height: 24.0),
                        NoteTextField(),
                        SizedBox(height: 24.0),
                        AuthorTextField(),
                        SizedBox(height: 24.0),
                        UseRemoteDataField(),
                        SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
