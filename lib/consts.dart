import 'package:flutter/material.dart';

class UchuSpacing {
  static const double S = 8;
  static const double M = 16;
  static const double L = 24;
  static const double XL = 32;
}

const sentenceWordPlaceholderText = '______';

const translatableTextStyle = TextStyle(
  decoration: TextDecoration.underline,
  decorationColor: Colors.blue,
  decorationThickness: 3,
  decorationStyle: TextDecorationStyle.dashed,
);

const masculineNounEndings = [
  'б',
  'в',
  'г',
  'д',
  'ж',
  'з',
  'й',
  'к',
  'л',
  'м',
  'н',
  'п',
  'р',
  'с',
  'т',
  'ф',
  'х',
  'ц',
  'ч',
  'ш',
  'щ'
];

const feminineNounEndings = ['а', 'я'];

const neuterNounEndings = ['о', 'е'];

const foreignNeuterNounEndings = ['и', 'у', 'ю'];
