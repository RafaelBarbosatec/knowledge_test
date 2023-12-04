import 'package:flutter/material.dart';
import 'package:knowledge_test/data/model/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question item;
  final int? selectedIndex;
  final ValueChanged<int>? onTapAnswer;
  final bool showCorrect;
  const QuestionWidget({
    super.key,
    required this.item,
    this.showCorrect = false,
    this.selectedIndex,
    this.onTapAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          item.pergunta,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        ...item.respostas.indexed.map((e) {
          return InkWell(
            onTap: showCorrect ? null : () => onTapAnswer?.call(e.$1),
            child: Container(
              decoration: BoxDecoration(
                color: _getColor(e.$1, e.$2)?.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IgnorePointer(
                    child: Radio(
                      value: e.$1,
                      groupValue: selectedIndex,
                      onChanged: (value) {},
                    ),
                  ),
                  Expanded(child: Text(e.$2.resposta)),
                ],
              ),
            ),
          );
        }).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  Color? _getColor(int index, Answer answer) {
    if (showCorrect) {
      if (answer.correto) {
        return Colors.green;
      } else if (index == selectedIndex) {
        return Colors.red;
      }
    }
    return null;
  }
}
