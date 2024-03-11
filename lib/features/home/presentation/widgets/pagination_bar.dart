import 'package:flutter/material.dart';
import 'package:kafil/core/widgets/icon_container.dart';
import 'package:kafil/features/home/presentation/widgets/pagination_number.dart';

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onSelectPage;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onSelectPage,
  });

  @override
  Widget build(BuildContext context) {
    List<int> pageNumbersToShow = _calculatePageNumbersToShow(context);

    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const IconContainer(iconData: Icons.first_page),
            onPressed: currentPage > 1 ? () => onSelectPage(1) : null,
          ),
          IconButton(
            icon: const IconContainer(iconData: Icons.chevron_left),
            onPressed:
                currentPage > 1 ? () => onSelectPage(currentPage - 1) : null,
          ),
          ...pageNumbersToShow.map((number) {
            return number == -1
                ? const Text('...')
                : PaginationNumber(
                    number: number,
                    isSelected: currentPage == number,
                    onSelectPage: onSelectPage,
                  );
          }),
          IconButton(
            icon: const IconContainer(iconData: Icons.chevron_right),
            onPressed: currentPage < totalPages
                ? () => onSelectPage(currentPage + 1)
                : null,
          ),
          IconButton(
            icon: const IconContainer(iconData: Icons.last_page),
            onPressed: currentPage < totalPages
                ? () => onSelectPage(totalPages)
                : null,
          ),
        ],
      ),
    );
  }

  List<int> _calculatePageNumbersToShow(BuildContext context) {
    const double buttonWidth = 40.0;
    const double buttonPadding = 8.0;
    const double ellipsisWidth = 120.0;

    double availableWidth =
        MediaQuery.of(context).size.width - 2 * ellipsisWidth;

    int maxButtons = availableWidth ~/ (buttonWidth + buttonPadding);

    var list = <int>[];

    if (totalPages <= maxButtons) {
      list = List.generate(totalPages, (index) => index + 1);
    } else {
      var min = currentPage - (maxButtons ~/ 2);
      var max = currentPage + (maxButtons ~/ 2);

      if (min < 1) {
        max = max - min + 1;
        min = 1;
      }
      if (max > totalPages) {
        min = totalPages - maxButtons + 1;
        max = totalPages;
      }

      if (max - min + 1 < maxButtons) {
        int adjustment = maxButtons - (max - min + 1);
        if (min > 1) {
          min -= adjustment;
        } else if (max < totalPages) {
          max += adjustment;
        }
      }

      for (var i = min; i <= max; i++) {
        list.add(i);
      }

      if (min > 1) list.insert(0, -1);
      if (max < totalPages) list.add(-1);
    }

    return list;
  }
}
