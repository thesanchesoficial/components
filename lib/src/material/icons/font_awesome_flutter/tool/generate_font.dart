import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';

void main(List<String> arguments) {
  var file = new File(arguments.first);

  if (!file.existsSync()) {
    // print('Cannot find the file "${arguments.first}".');
  }

  var content = file.readAsStringSync();
  Map<String, dynamic> icons = json.decode(content);

  Map<String, String> iconDefinitions = {};

  bool hasDuotone = false;

  for (String iconName in icons.keys) {
    var icon = icons[iconName];

    // At least one icon does not have a glyph in the font files. This property
    // is marked with "private": true in icons.json
    if((icon as Map<String, dynamic>).containsKey('private') && icon['private'])
      continue;

    var unicode = icon['unicode'];
    List<String> styles = (icon['styles'] as List).cast<String>();

    if (styles.length > 1) {
      if (styles.contains('regular')) {
        styles.remove('regular');
        iconDefinitions[iconName] = generateIconDefinition(
          iconName,
          'regular',
          unicode,
        );
      }

      if (styles.contains('duotone')) {
        hasDuotone = true;
      }

      for (String style in styles) {
        String name = '${style}_$iconName';
        iconDefinitions[name] = generateIconDefinition(
          name,
          style,
          unicode,
        );
      }
    } else {
      iconDefinitions[iconName] = generateIconDefinition(
        iconName,
        styles.first,
        unicode,
      );
    }
  }

  List<String> generatedOutput = [
    'library font_awesome_flutter;',
    '',
    "import 'package:flutter/widgets.dart';",
    "import 'package:font_awesome_flutter/src/icon_data.dart';",
    "export 'package:font_awesome_flutter/src/fa_icon.dart';",
    "export 'package:font_awesome_flutter/src/icon_data.dart';",
  ];

  if (hasDuotone) {
    generatedOutput
        .add("export 'package:font_awesome_flutter/src/fa_duotone_icon.dart';");
  }

  generatedOutput.addAll([
    '',
    '// THIS FILE IS AUTOMATICALLY GENERATED!',
    '',
    'class FontAwesomeIcons {',
  ]);

  generatedOutput.addAll(iconDefinitions.values);

  generatedOutput.add('}');

  File output = new File('lib/font_awesome_flutter.dart');
  output.writeAsStringSync(generatedOutput.join('\n'));
}

String generateIconDefinition(String iconName, String style, String unicode) {
  style = '${style[0].toUpperCase()}${style.substring(1)}';

  String iconDataSource = 'IconData$style';

  if (iconName == '500px') {
    iconName = 'fiveHundredPx';
  }

  iconName = new ReCase(iconName).camelCase;

  return 'static const IconData $iconName = const $iconDataSource(0x$unicode);';
}
