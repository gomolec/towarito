import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:towarito/core/services/connection_service.dart';

import '../../../core/app/app_scaffold_messager.dart';
import '../../../core/navigation/app_router.dart';
import '../../../domain/adapters/products_adapter.dart';
import '../../../injection_container.dart';
import '../../widgets/page_alert.dart';
import 'bloc/products_bloc/products_bloc.dart';
import 'widgets/widgets.dart';

@RoutePage()
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        productsAdapter: sl<ProductsAdapter>(),
        appScaffoldMessager: sl<AppScaffoldMessager>(),
        connectionService: sl<ConnectionService>(),
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

  bool hasReachedMax = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom && !hasReachedMax) {
      context.read<ProductsBloc>().add(const ProductsFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) async {
          hasReachedMax = state.hasReachedMax;
          if (state.shouldReturnToTop && _scrollController.hasClients) {
            await _scrollController.animateTo(
              0.0,
              duration: const Duration(seconds: 1),
              curve: Curves.bounceInOut,
            );
          }
        },
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
                          AutoRouter.of(context)
                              .root
                              .navigate(const SessionsRoute());
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
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
