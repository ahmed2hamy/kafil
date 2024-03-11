import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';

class PageStepper extends StatelessWidget {
  final int currentStep;
  final List<String> pageTitles;

  const PageStepper({
    super.key,
    required this.currentStep,
    required this.pageTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        pageTitles.length,
        (index) => _buildStep(context, index),
      ),
    );
  }

  Widget _buildStep(BuildContext context, int stepIndex) {
    bool isDone = stepIndex < currentStep;
    bool isCurrent = stepIndex == currentStep;

    Color color = _getColor(context, isDone, isCurrent);

    return Flexible(
      child: Column(
        children: [
          Text(
            pageTitles[stepIndex],
            style: TextStyle(color: color),
          ),
          const SizedBox(height: 8),
          _buildStepIndicator(color, stepIndex, isDone, isCurrent),
        ],
      ),
    );
  }

  Color _getColor(BuildContext context, bool isDone, bool isCurrent) {
    if (isDone || isCurrent) {
      return Theme.of(context).primaryColor;
    } else {
      return Colors.grey.shade300;
    }
  }

  Widget _buildStepIndicator(
      Color color, int stepIndex, bool isDone, bool isCurrent) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 2,
            color: color,
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: isCurrent ? Colors.transparent : color,
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
                width: 2,
              )),
          child: Center(
            child: isDone
                ? const Icon(Icons.check, color: Colors.white)
                : isCurrent
                    ? Text(
                        '${stepIndex + 1}',
                        style: kPrimaryBoldTextStyle,
                      )
                    : const SizedBox.shrink(),
          ),
        ),
        Expanded(
          child: Container(
            height: 2,
            color: stepIndex >= currentStep ? Colors.grey.shade300 : color,
          ),
        ),
      ],
    );
  }
}
