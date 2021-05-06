import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';

double calculateAverage(UserModel model) {
  double av = 0.0;
  if (model != null) {
    double first = (5 * model.fivestar +
            4 * model.fourstar +
            3 * model.threestar +
            2 * model.twostar +
            1 * model.onestar)
        .toDouble();
    double second = (model.fivestar +
            model.fourstar +
            model.threestar +
            model.twostar +
            model.onestar)
        .toDouble();

    av = first / second;
    if (second < 1) av = 0.0;
  }
  return av;
}

double calculate(int value, UserModel model) {
  double total = totalvalue(model);

  if (total > 0)
    return value / total;
  else
    return 0.0;
}

double totalvalue(UserModel model) {
  return (model.fivestar +
          model.fourstar +
          model.threestar +
          model.twostar +
          model.onestar)
      .toDouble();
}

double showpercentage(int i, UserModel model) {
  switch (i) {
    case 1:
      return calculate(model.onestar, model);
      break;
    case 2:
      return calculate(model.twostar, model);
      break;
    case 3:
      return calculate(model.threestar, model);
      break;
    case 4:
      return calculate(model.fourstar, model);

      break;
    default:
      return calculate(model.fivestar, model);
      break;
  }
}

Color progressColor(int i, BuildContext context) {
  switch (i) {
    case 1:
      return Theme.of(context).backgroundColor;
      break;
    case 2:
      return Colors.deepOrange;
      break;
    case 3:
      return Colors.yellow;
      break;
    case 4:
      return Colors.green[300];
      break;
    default:
      return Colors.orange;
      break;
  }
}
