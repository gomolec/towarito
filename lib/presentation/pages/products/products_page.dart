import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/app_scaffold_messager.dart';
import '../../../domain/adapters/products_adapter.dart';
import '../../../injection_container.dart';
import '../../widgets/page_alert.dart';
import 'bloc/products_bloc/products_bloc.dart';
import 'widgets/widgets.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        productsAdapter: sl<ProductsAdapter>(),
        appScaffoldMessager: sl<AppScaffoldMessager>(),
      )..add(const ProductsSubscriptionRequested()),
      child: const ProductsPageView(),
    );
  }
}

class ProductsPageView extends StatefulWidget {
  const ProductsPageView({super.key});

  @override
  State<ProductsPageView> createState() => _ProductsPageViewState();
}

class _ProductsPageViewState extends State<ProductsPageView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.success) {
            return ProductsView(
              state: state,
              controller: _scrollController,
            );
          }
          if (state.status == ProductsStatus.initial) {
            return SafeArea(
              child: Column(
                children: [
                  AppBar(
                    title: const Text("Produkty"),
                  ),
                  PageAlert(
                    leadingIconData: Icons.folder_off_rounded,
                    title: "Brak aktywnej sesji",
                    text:
                        "\tPrzywróć poprzednio utworzoną sesję lub utwórz nową, do której możesz dodać produkty lub zaimportuj je z obsługiwanych plików.",
                    buttons: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context.beamToNamed('/menu/sessions');
                        },
                        icon: const Icon(Icons.folder_copy),
                        label: const Text("Pokaż sesje użytkownika"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                AppBar(
                  title: const Text("Produkty"),
                ),
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
