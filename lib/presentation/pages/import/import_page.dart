import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/adapters/products_adapter.dart';
import '../../../injection_container.dart';
import 'bloc/import_bloc.dart';
import 'widgets/widgets.dart';

@RoutePage()
class ImportPage extends StatelessWidget {
  const ImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImportBloc(
        productsAdapter: sl<ProductsAdapter>(),
      ),
      child: const ImportPageView(),
    );
  }
}

class ImportPageView extends StatelessWidget {
  const ImportPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ImportBloc, ImportState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        late final Widget view;
        if (state is ImportLoading) {
          view = const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ImportFileUploading) {
          view = UploadFileView(theme: theme);
        } else if (state is ImportFieldsMapping) {
          view = FileFieldMapView(theme: theme);
        } else if (state is ImportSummary) {
          view = ImportSummaryView(theme: theme);
        } else if (state is ImportLoading) {
          view = Column(
            children: [
              const CircularProgressIndicator(),
              state.infoText.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        state.infoText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        } else {
          view = SelectImportMethodView(theme: theme);
        }
        return Scaffold(
          appBar: AppBar(
            leading: const AutoLeadingButton(),
            title: const Text("Importowanie"),
          ),
          body: view,
        );
      },
    );
  }
}
