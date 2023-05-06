import 'package:flutter/material.dart';

class QuantityButtons extends StatefulWidget {
  final ThemeData theme;
  final int initialQuantity;
  final int initialTargetQuantity;
  final void Function(int) setQuantity;
  final void Function(int) setTargetQuantity;

  const QuantityButtons({
    Key? key,
    required this.theme,
    required this.initialQuantity,
    required this.initialTargetQuantity,
    required this.setQuantity,
    required this.setTargetQuantity,
  }) : super(key: key);

  @override
  State<QuantityButtons> createState() => _QuantityButtonsState();
}

class _QuantityButtonsState extends State<QuantityButtons> {
  late final TextEditingController _quantityTextController;
  late final TextEditingController _targetQuantityTextController;

  int _quantity = 0;
  int _targetQuantity = 0;

  @override
  void initState() {
    _quantity = widget.initialQuantity;
    _targetQuantity = widget.initialTargetQuantity;
    _quantityTextController = TextEditingController(
      text: _quantity.toString(),
    );
    _targetQuantityTextController = TextEditingController(
      text: _targetQuantity.toString(),
    );
    super.initState();
  }

  void changeQuantity(int value) {
    if (value < 0) return;
    _quantity = value;
    setState(() {
      _quantityTextController.text = _quantity.toString();
    });
    widget.setQuantity(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Column(
        children: [
          Text(
            "USTAW ILOŚĆ",
            style: widget.theme.textTheme.bodyMedium?.copyWith(
              color: widget.theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: _quantity > 0
                    ? () {
                        changeQuantity(_quantity - 1);
                      }
                    : null,
                onLongPress: _quantity > 0
                    ? () {
                        changeQuantity(0);
                      }
                    : null,
                borderRadius: BorderRadius.circular(48.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Icon(
                    Icons.remove_rounded,
                    size: 64.0,
                    color: _quantity > 0
                        ? widget.theme.colorScheme.primary
                        : widget.theme.colorScheme.onSurface.withOpacity(0.38),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    final quantity = int.tryParse(value);
                    if (quantity == null) return;
                    _quantity = quantity;
                    widget.setQuantity(_quantity);
                  },
                  controller: _quantityTextController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: widget.theme.textTheme.headlineMedium?.copyWith(
                    color: widget.theme.colorScheme.onSurfaceVariant
                        .withOpacity(0.8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "/",
                  style: widget.theme.textTheme.headlineMedium?.copyWith(
                    color: widget.theme.colorScheme.onBackground,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    final targetQuantity = int.tryParse(value);
                    if (targetQuantity == null) return;
                    _targetQuantity = targetQuantity;
                    widget.setTargetQuantity(_targetQuantity);
                  },
                  controller: _targetQuantityTextController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: widget.theme.textTheme.headlineMedium?.copyWith(
                    color: widget.theme.colorScheme.onBackground,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () {
                  changeQuantity(_quantity + 1);
                },
                onLongPress: () {
                  changeQuantity(_targetQuantity);
                },
                borderRadius: BorderRadius.circular(48.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    size: 64.0,
                    color: widget.theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ProductQuantityButtonsTest extends StatefulWidget {
//   final int initialQuantity;
//   final int initialTargetQuantity;
//   const ProductQuantityButtonsTest({
//     Key? key,
//     required this.initialQuantity,
//     required this.initialTargetQuantity,
//   }) : super(key: key);

//   @override
//   State<ProductQuantityButtonsTest> createState() =>
//       _ProductQuantityButtonsState();
// }

// class _ProductQuantityButtonsState extends State<ProductQuantityButtonsTest> {
//   late final TextEditingController _quantityTextController;
//   late final TextEditingController _targetQuantityTextController;

//   late int _quantity;
//   late int _targetQuantity;

//   @override
//   void initState() {
//     _quantity = widget.initialQuantity;
//     _targetQuantity = widget.initialTargetQuantity;
//     _quantityTextController = TextEditingController(
//       text: _quantity.toString(),
//     );
//     _targetQuantityTextController = TextEditingController(
//       text: _targetQuantity.toString(),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ProductBloc, ProductState>(
//       listenWhen: (previous, current) {
//         if (previous.quantity != current.quantity) return true;
//         if (previous.targetQuantity != current.targetQuantity) return true;
//         return false;
//       },
//       listener: (context, state) {
//         setState(() {
//           _quantity = state.quantity;
//           _quantityTextController.text = _quantity.toString();
//           _targetQuantity = state.targetQuantity;
//           _targetQuantityTextController.text = _targetQuantity.toString();
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Column(
//           children: [
//             Text(
//               "USTAW ILOŚĆ",
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: Theme.of(context).colorScheme.onSurfaceVariant,
//                   ),
//             ),
//             const SizedBox(height: 8.0),
//             Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: _quantity >= 0
//                         ? () {
//                             context
//                                 .read<ProductBloc>()
//                                 .add(ProductQuantityChanged(_quantity - 1));
//                           }
//                         : null,
//                     onLongPress: _quantity >= 1
//                         ? () {
//                             context
//                                 .read<ProductBloc>()
//                                 .add(const ProductQuantityChanged(0));
//                           }
//                         : null,
//                     borderRadius: BorderRadius.circular(32.0),
//                     child: Icon(
//                       Icons.remove_rounded,
//                       size: 64.0,
//                       color: _quantity >= 1
//                           ? Theme.of(context).colorScheme.primary
//                           : Theme.of(context)
//                               .colorScheme
//                               .onSurface
//                               .withOpacity(0.38),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           onChanged: (value) {
//                             if (value.isNotEmpty) {
//                               int? newQuantity = int.tryParse(value);
//                               if (newQuantity != null) {
//                                 setState(() {
//                                   _quantity = newQuantity;
//                                 });
//                                 context
//                                     .read<ProductBloc>()
//                                     .add(ProductQuantityChanged(newQuantity));
//                               }
//                             }
//                           },
//                           controller: _quantityTextController,
//                           keyboardType: TextInputType.number,
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineMedium
//                               ?.copyWith(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onSurfaceVariant
//                                       .withOpacity(0.8)),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           "/",
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineMedium
//                               ?.copyWith(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onBackground),
//                         ),
//                       ),
//                       Expanded(
//                         child: TextField(
//                           onChanged: (value) {
//                             if (value.isNotEmpty) {
//                               int? newTargetQuantity = int.tryParse(value);
//                               if (newTargetQuantity != null) {
//                                 setState(() {
//                                   _targetQuantity = newTargetQuantity;
//                                 });
//                                 context.read<ProductBloc>().add(
//                                       ProductTargetQuantityChanged(
//                                           _targetQuantity),
//                                     );
//                               }
//                             }
//                           },
//                           controller: _targetQuantityTextController,
//                           keyboardType: TextInputType.number,
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineMedium
//                               ?.copyWith(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onBackground),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(32.0),
//                     onTap: () {
//                       context
//                           .read<ProductBloc>()
//                           .add(ProductQuantityChanged(_quantity + 1));
//                     },
//                     onLongPress: () {
//                       context
//                           .read<ProductBloc>()
//                           .add(ProductQuantityChanged(_targetQuantity));
//                     },
//                     child: Icon(
//                       Icons.add_rounded,
//                       size: 64.0,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _quantityTextController.dispose();
//     _targetQuantityTextController.dispose();
//     super.dispose();
//   }
// }
