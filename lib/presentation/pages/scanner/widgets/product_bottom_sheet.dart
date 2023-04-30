import 'package:flutter/material.dart';

class ProductBottonSheet extends StatelessWidget {
  const ProductBottonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductBottomSheet();
  }
}

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DragableIndicator(),
        const SizedBox(height: 8.0),
        const ProductTile(),
        const SizedBox(height: 16.0),
        const QuantityButtons(),
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: const Icon(Icons.description_rounded),
                  label: const Text("Szczegóły"),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: const Icon(Icons.flag_outlined),
                  label: const Text("Oflaguj"),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}

class QuantityButtons extends StatelessWidget {
  const QuantityButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            "USTAW ILOŚĆ",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  // _quantity >= 0
                  //     ? () {
                  //         context
                  //             .read<ProductBloc>()
                  //             .add(ProductQuantityChanged(_quantity - 1));
                  //       }
                  //     : null,
                  // onLongPress: _quantity >= 1
                  //     ? () {
                  //         context
                  //             .read<ProductBloc>()
                  //             .add(const ProductQuantityChanged(0));
                  //       }
                  //     : null,
                  borderRadius: BorderRadius.circular(32.0),
                  child: Icon(
                    Icons.remove_rounded,
                    size: 64.0,
                    // color: _quantity >= 1
                    //     ? Theme.of(context).colorScheme.primary
                    //     : Theme.of(context)
                    //         .colorScheme
                    //         .onSurface
                    //         .withOpacity(0.38),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "0",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withOpacity(0.8)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "/",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "10",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(32.0),
                  onTap: () {},
                  // () {
                  //   context
                  //       .read<ProductBloc>()
                  //       .add(ProductQuantityChanged(_quantity + 1));
                  // },
                  // onLongPress: () {
                  //   context
                  //       .read<ProductBloc>()
                  //       .add(ProductQuantityChanged(_targetQuantity));
                  // },
                  child: Icon(
                    Icons.add_rounded,
                    size: 64.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.primary,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.inventory_2_outlined,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      title: Text("TEST"),
      subtitle: Text("TESTTESTTEST"),
    );
  }
}

class DragableIndicator extends StatelessWidget {
  const DragableIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 22.0,
        bottom: 8.0,
      ),
      child: Container(
        width: 32.0,
        height: 4.0,
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
}
