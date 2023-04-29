import 'package:flutter/material.dart';

import '../../../../core/theme/custom_color.g.dart';
import '../../../../data/models/models.dart';

class HistoryActionTile extends StatelessWidget {
  final HistoryAction historyAction;

  const HistoryActionTile({
    Key? key,
    required this.historyAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final IconData iconData;
    late final Color iconBgColor;
    late final String title;

    switch (historyAction.actionType) {
      case HistoryActionType.created:
        iconData = Icons.add_rounded;
        iconBgColor =
            Theme.of(context).extension<CustomColors>()!.successContainer!;
        title = "Dodano nowy produkt";
        break;
      case HistoryActionType.deleted:
        iconData = Icons.delete_outline_rounded;
        iconBgColor = Theme.of(context).colorScheme.errorContainer;
        title = "Usunięto produkt";
        break;
      case HistoryActionType.updated:
        iconData = Icons.change_history_rounded;
        iconBgColor =
            Theme.of(context).extension<CustomColors>()!.warningContainer!;
        title = "Zaaktualizowano produkt";
        break;
    }
    return InkWell(
      onTap: null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Icon(
                iconData,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    historyAction.actionType == HistoryActionType.deleted
                        ? historyAction.oldProduct!.name
                        : historyAction.updatedProduct!.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.layers_outlined,
                          size: 16.0,
                        ),
                        const SizedBox(width: 2.0),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: (historyAction.actionType ==
                                        HistoryActionType.deleted)
                                    ? "${historyAction.oldProduct!.quantity} z ${historyAction.oldProduct!.targetQuantity} szt"
                                    : "${historyAction.updatedProduct!.quantity} z ${historyAction.updatedProduct!.targetQuantity} szt",
                              ),
                              (historyAction.actionType ==
                                      HistoryActionType.updated)
                                  ? TextSpan(
                                      text:
                                          " (${historyAction.oldProduct!.quantity} z ${historyAction.oldProduct!.targetQuantity} szt)",
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    )
                                  : const TextSpan(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            historyAction.actionType == HistoryActionType.updated
                ? Container(
                    height: 56.0,
                    alignment: Alignment.center,
                    child: (historyAction.updateType != HistoryUpdateType.none)
                        ? (historyAction.updateType ==
                                HistoryUpdateType.quantity)
                            ? Text(
                                () {
                                  String trailingText =
                                      "${historyAction.updatedProduct!.quantity - historyAction.oldProduct!.quantity}";
                                  if (int.parse(trailingText) > 0) {
                                    trailingText = "+$trailingText";
                                  }
                                  return trailingText;
                                }(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant),
                              )
                            : Icon(
                                Icons.flag_rounded,
                                size: 20.0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              )
                        : const SizedBox(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
