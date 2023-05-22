import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/configs.dart';
import 'package:pokedex/utils.dart';

class LinearProgressComponent {
  static Widget defaultComponent(
      String stat, int value, Color backgroundColor) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              Utils.getStatAbbreviation(stat).toUpperCase(),
              textAlign: TextAlign.end,
            )),
        Expanded(
            child: Container(
          height: 30,
          child: const VerticalDivider(
            color: Configs.grayMinimumDefault,
            thickness: 2,
          ),
        )),
        Expanded(
          flex: 1,
          child: Text((value).toString().padLeft(3, '0')),
        ),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: value.toDouble() / 200,
            color: backgroundColor,
            backgroundColor: backgroundColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
