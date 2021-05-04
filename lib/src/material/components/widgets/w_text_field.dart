import 'package:components_venver/functions.dart';
import 'package:components_venver/src/settings/filter_mask.dart';
import 'package:components_venver/src/settings/mask_type.dart';
import 'package:components_venver/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ! VER controllers / formatters
/*
https://pub.dev/packages/flutter_masked_text
https://pub.dev/packages/mask_text_input_formatter
https://pub.dev/packages/masked_text_formatter
https://pub.dev/packages/extended_masked_text
https://pub.dev/packages/masked_controller
https://pub.dev/packages/masked_text_input_formatter
*/

enum TextFieldType {
  cpf,
  cnpj,
  cpf_cnpj,
  date,
  phone8,
  phone9,
  phone10,
  phone11,
  phone12,
  phone13,
  phone8_9,
  phone8_10,
  phone8_11,
  phone8_12,
  phone8_13,
  phone9_10,
  phone9_11,
  phone9_12,
  phone9_13,
  phone10_11,
  phone10_12,
  phone10_13,
  phone11_12,
  phone11_13,
  phone12_13,
  cardNumber,
  cardCvv,
  cardDateYYYY,
  cardDateYY,
  currency,
  integer,
  name,
  email,
  password, // ! Tentar melhorar
  paragraph, // ! Mais de uma linha, com multline, etc (descrição do estabelecimento por exemplo)
  cep,
  // phone<List>(List l), // ! Ver se dá pra fazer algo assim
}

/* // ! Ver sobre enum's
https://ptyagicodecamp.github.io/dart-enums.html
https://github.com/dart-lang/language/issues/158
https://github.com/dart-lang/language/issues/83#issuecomment-449380965
https://stackoverflow.com/questions/38908285/add-methods-or-values-to-enum-in-dart
https://pub.dev/documentation/extension/latest/enum/Enum-class.html
https://stackoverflow.com/questions/29567236/dart-how-to-get-the-value-of-an-enum/29567669
https://www.educative.io/blog/dart-2-language-features
*/

// ignore: must_be_immutable
class OwTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String errorText;
  final String helperText;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final ValueChanged<String> onChanged;
  final Function onTap;
  final FormFieldSetter<String> onSaved;
  final int maxLength;
  final int minLines;
  final int maxLines;
  final EdgeInsets margin;
  final bool enabled;
  final bool enableInteractiveSelection;
  final bool autofocus;
  final bool obscureText;
  final bool maxLengthEnforced;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final String counterText;
  final Color color;
  final List<TextInputFormatter> inputFormatters;
  final String suffixText;
  final String prefixText;
  final List<dynamic> suggestionsList;
  final bool ignoreAccentsOnSuggestion;
  final bool caseSensitiveOnSuggestion;
  final TextFieldType fieldType;
  final bool unfocusIfNoNextFocusNode;
  final List<FocusNode> focusNodeList;
  final int focusNodeIndex;
  // final VoidCallback onPressedSuffix;

  static final String assetMsgFocusNodeList = "If you pass 'focusNodeList', you need to pass the position with 'focusNodeIndex'";
  static final String assetMsgSuggestions = "'suggestionsList', can not be null";
  // static final BorderRadius borderRadius  = BorderRadius.all(Radius.circular(10));

  OwTextField({
    Key key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.enabled = true,
    this.maxLengthEnforced = true,
    this.onFieldSubmitted,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.counterText,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.margin,
    this.prefixText,
    this.suffixText,
    this.suffixIcon,
    this.enableInteractiveSelection = true,
    this.color,
    this.inputFormatters,
    this.onSaved,
    this.validator,
    this.nextFocusNode,
    this.unfocusIfNoNextFocusNode = true,
    this.focusNodeList,
    this.focusNodeIndex,
  })  : this.fieldType = null,
        this.suggestionsList = null,
        this.ignoreAccentsOnSuggestion = null,
        this.caseSensitiveOnSuggestion = null,
        assert(
          (focusNodeList == null && focusNodeIndex == null) || (focusNodeList != null && focusNodeIndex != null), 
          assetMsgFocusNodeList,
        ),
        super(key: key);

  OwTextField.withSuggestions({
    Key key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.enabled = true,
    this.maxLengthEnforced = true,
    this.onFieldSubmitted,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.counterText,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.margin,
    this.prefixText,
    this.suffixText,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.color,
    this.suggestionsList,
    this.inputFormatters,
    this.autofocus = false,
    this.readOnly = false,
    this.nextFocusNode,
    this.ignoreAccentsOnSuggestion = true,
    this.caseSensitiveOnSuggestion = false,
    this.unfocusIfNoNextFocusNode = true,
    this.focusNodeList,
    this.focusNodeIndex,
  })  : this.fieldType = null,
        this.onSaved = null,
        this.validator = null,
        assert(
          suggestionsList != null, 
          assetMsgSuggestions,
        ),
        assert(
          (focusNodeList == null && focusNodeIndex == null) || (focusNodeList != null && focusNodeIndex != null), 
          assetMsgFocusNodeList,
        ),
        super(key: key);

  OwTextField.type({
    Key key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.enabled = true,
    this.maxLengthEnforced = true,
    this.onFieldSubmitted,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.counterText,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.margin,
    this.prefixText,
    this.suffixText,
    this.nextFocusNode,
    this.enableInteractiveSelection = true,
    this.color,
    this.inputFormatters,
    this.suffixIcon,
    this.onSaved,
    this.validator,
    @required this.fieldType,
    this.unfocusIfNoNextFocusNode = true,
    this.focusNodeList,
    this.focusNodeIndex,
  })  : this.suggestionsList = null,
        this.ignoreAccentsOnSuggestion = null,
        this.caseSensitiveOnSuggestion = null,
        assert(
          (focusNodeList == null && focusNodeIndex == null) || (focusNodeList != null && focusNodeIndex != null), 
          assetMsgFocusNodeList,
        ),
        super(key: key);

  TextInputType _keyboardType;
  List<TextInputFormatter> _inputFormatters;
  TextCapitalization _textCapitalization;
  Function _goToNextFocusNode;
  TextInputAction _textInputAction = TextInputAction.next;
  FocusNode _nextFocusNode;
  FocusNode _focusNode;
  Function _changeMask;

  @override
  Widget build(BuildContext context) {
    changeTextFieldType(context);
    defineFocusNode(context);
    
    return Container(
      key: key,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: _textField(context),
    );
  }

  Widget _textField(BuildContext context) {
    if(suggestionsList == null) {
      return TextFormField(
        inputFormatters: inputFormatters ?? _inputFormatters,
        keyboardType: keyboardType ?? _keyboardType,
        textCapitalization: textCapitalization ?? _textCapitalization,
        minLines: minLines,
        maxLines: maxLines,
        maxLengthEnforced: maxLengthEnforced,
        enabled: enabled,
        enableInteractiveSelection: enableInteractiveSelection,
        decoration: InputDecoration(
          filled: true,
          fillColor: color ?? Theme.of(context).cardColor,
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          counterText: counterText,
          alignLabelWithHint: false,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, 
            vertical: 18,
          ),
          labelStyle: TextStyle(
            color: Theme.of(context).primaryTextTheme.bodyText1.color,
          ),
          errorBorder: const UnderlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppTheme.errorColor ?? Colors.red),
          ),
          helperText: helperText,
          helperMaxLines: 3,
          errorStyle: const TextStyle(
            color: AppTheme.errorColor ?? Colors.red,
          ),
          suffixText: suffixText,
          prefixText: prefixText,
          suffixIcon: suffixIcon,
        ),
        onTap: onTap,
        onSaved: onSaved,
        onChanged: (_) {
          if(onChanged != null) {
            onChanged(_);
          }
          if(_changeMask != null) {
            _changeMask();
          }
        },
        // onChanged: onChanged,
        maxLength: maxLength,
        readOnly: readOnly,
        validator: validator,
        controller: controller,
        textInputAction: textInputAction ?? _textInputAction,
        // onFieldSubmitted: onFieldSubmitted,
        onFieldSubmitted: (_) {
          if(onFieldSubmitted != null) {
            onFieldSubmitted(_);
          }
          if(_goToNextFocusNode != null) {
            _goToNextFocusNode();
          }
        },
        focusNode: _focusNode,
        obscureText: obscureText,
        autofocus: autofocus,
      );
    } else {
      return TypeAheadField(
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: autofocus,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction ?? _textInputAction,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          enabled: enabled,
          maxLengthEnforced: maxLengthEnforced,
          enableInteractiveSelection: enableInteractiveSelection,
          decoration: InputDecoration(
            filled: true,
            fillColor: color ?? Theme.of(context).cardColor,
            labelText: labelText,
            hintText: hintText,
            errorText: errorText,
            counterText: counterText,
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).secondaryHeaderColor,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, 
              vertical: 18,
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).primaryTextTheme.bodyText1.color,
            ),
            errorBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: AppTheme.errorColor ?? Colors.red,
              ),
            ),
            helperText: helperText,
            helperMaxLines: 3,
            errorStyle: const TextStyle(
              color: AppTheme.errorColor ?? Colors.red,
            ),
            suffixText: suffixText,
            prefixText: prefixText,
            suffixIcon: suffixIcon,
          ),
          onSubmitted: (_) {
            if(onFieldSubmitted != null) {
              onFieldSubmitted(_);
            }
            if(_goToNextFocusNode != null) {
              _goToNextFocusNode();
            }
          },
          focusNode: _focusNode,
          onChanged: onChanged,
          onTap: onTap,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
        ),
        suggestionsCallback: (string) {
          // return await _getSuggestionsList(string);
          return _getSuggestionsList(string);
        },
        noItemsFoundBuilder: (_) {
          return const SizedBox();
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(
              suggestion.toString(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.touch_app_outlined),
          );
        },
        onSuggestionSelected: (suggestion) {
          if(controller != null) {
            controller.text = suggestion.toString();
          }
        },
      );
    }
  }

  void changeTextFieldType(BuildContext context) {
    if(fieldType != null) {
      switch(fieldType) {
        case TextFieldType.name:
          _keyboardType = TextInputType.text;
          _textCapitalization = TextCapitalization.words;
          break;

        case TextFieldType.email:
          _keyboardType = TextInputType.emailAddress;
          _textCapitalization = TextCapitalization.none;
          break;

        case TextFieldType.password: // ! Ver se dá para melhorar
          _keyboardType = TextInputType.text; // TextInputType.visiblePassword,
          _textCapitalization = TextCapitalization.none;
          break;

        case TextFieldType.paragraph: // ! Terminar
          break;

        case TextFieldType.cep: // ! Terminar
          break;

        case TextFieldType.cardNumber:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.cardNumber(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;

        case TextFieldType.cardCvv:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.cardCvv(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;

        case TextFieldType.cardDateYY:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.cardDateYY(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;

        case TextFieldType.cardDateYYYY:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.cardDateYYYY(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;

        case TextFieldType.date:
          _keyboardType = TextInputType.datetime; // ! Ver se esse datetime fica bom
          final _mask = OwMaskedFormatter.date(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;

        case TextFieldType.cpf:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.cpf(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;

        case TextFieldType.cnpj:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.cnpj(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;
        
        case TextFieldType.cpf_cnpj:
          if(!(controller is MaskedTextController)) { // ! Ver se vai dar certo (se der, separar exceção em outra classe)
            // !(controller is TextEditingController) ||
            // !(controller is MoneyMaskedTextController)
            throw ArgumentError.value(
              controller,
              "controller is not MaskedTextController", // Name
              "Invalid controller: The controller needs to be instantiated as MaskedTextController class", // Message
            );
          } else {
            MaskTextInputFormatter _maskFormatter;
            if(controller?.text?.length == MaskType.cpf.length) {
              _maskFormatter = OwMaskedFormatter.cpf(initialText: controller?.text); // initialText: controller?.text ?? ""
            } else {
              _maskFormatter = OwMaskedFormatter.cnpj(initialText: controller?.text); // initialText: controller?.text ?? ""
            }
            _inputFormatters = [_maskFormatter];
            _changeMask = () {
              int _position = controller?.selection?.baseOffset;
              String _text = _maskFormatter.getUnmaskedText();
              String _mask = _maskFormatter.getMask();
              if(_text.length > 10 && _mask != MaskType.cpf) {
                _maskFormatter.updateMask(mask: MaskType.cpf, filter: FilterMask.number);
                // controller.updateMask(MaskType.cpf); // ! Descomentar
                controller.selection = TextSelection.fromPosition(TextPosition(offset: _position));
              } else if(_text.length <= 10 && _mask != MaskType.cnpj) {
                _maskFormatter.updateMask(mask: MaskType.cnpj, filter: FilterMask.number);
                // controller.updateMask(MaskType.cnpj); // ! Descomentar
                controller.selection = TextSelection.fromPosition(TextPosition(offset: _position));
              }
            };
          }
          break;
          
        case TextFieldType.phone8:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.phone8(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;
          
        case TextFieldType.phone9:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.phone9(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;
          
        case TextFieldType.phone10:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.phone10(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;
          
        case TextFieldType.phone11:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.phone11(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;
          
        case TextFieldType.phone12:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.phone12(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;
          
        case TextFieldType.phone13:
          _keyboardType = TextInputType.phone;
          final _mask = OwMaskedFormatter.phone13(initialText: controller?.text); // initialText: controller?.text ?? ""
          _inputFormatters = [_mask];
          break;
          
        case TextFieldType.phone8_9: // ! Finalizar
        case TextFieldType.phone8_10:
        case TextFieldType.phone8_11:
        case TextFieldType.phone8_12:
        case TextFieldType.phone8_13:

        case TextFieldType.phone9_10:
        case TextFieldType.phone9_11:
        case TextFieldType.phone9_12:
        case TextFieldType.phone9_13:
        
        case TextFieldType.phone10_11:
        case TextFieldType.phone10_12:
        case TextFieldType.phone10_13:

        case TextFieldType.phone11_12:
        case TextFieldType.phone11_13:
        
        case TextFieldType.phone12_13:

        case TextFieldType.currency:
        case TextFieldType.integer:

      }
    }
  }

  void defineFocusNode(BuildContext context) {
    _nextFocusNode = nextFocusNode;
    if(focusNodeList != null && focusNodeList.length > focusNodeIndex + 1) {
      _nextFocusNode = _nextFocusNode ?? focusNodeList[focusNodeIndex + 1];
    }
    _focusNode = focusNode;
    if(focusNodeList != null && focusNodeList.length > focusNodeIndex) {
      _focusNode = _focusNode ?? focusNodeList[focusNodeIndex];
    }

    if(_nextFocusNode != null) {
      _textInputAction = TextInputAction.next;
      _goToNextFocusNode = () {
        FocusScope.of(context).requestFocus(_nextFocusNode);
      };
    } else {
      _textInputAction = TextInputAction.done;
      if(unfocusIfNoNextFocusNode) {
        _goToNextFocusNode = () {
          FocusScope.of(context).unfocus();
        };
      }
    }
  }

  Iterable<dynamic> _getSuggestionsList(String string) {
    List<dynamic> suggestions = [];
    if(suggestionsList != null && suggestionsList.isNotEmpty) {
      suggestions = suggestionsList;
    }

    return suggestions.where((element) {
      String item = element.toString();
      String word = string.toString();
      if(!caseSensitiveOnSuggestion) {
        item = item.toLowerCase();
        word = word.toLowerCase();
      }
      if(ignoreAccentsOnSuggestion) {
        item = OwFormat.removeAccentAndPonctuation(item, useLowerCase: false);
        word = OwFormat.removeAccentAndPonctuation(word, useLowerCase: false);
      }
      return item.contains(word);
    });
  }
}



/* // ! Ver depois
https://stackoverflow.com/questions/50395032/flutter-textfield-with-currency-format

[THIS CODE DOESN'T WORKS FOR ALL CASES]

I just got it working this way, sharing in case someone needs too:

TextField

TextFormField(  
    //validator: ,  
    controller: controllerValor,  
    inputFormatters: [  
        WhitelistingTextInputFormatter.digitsOnly,
        // Fit the validating format.
        //fazer o formater para dinheiro
        CurrencyInputFormatter()
    ],
    keyboardType: TextInputType.number, ...

TextInputFormatter

class CurrencyInputFormatter extends TextInputFormatter {

    TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

        if(newValue.selection.baseOffset == 0){
            print(true);
            return newValue;
        }

        double value = double.parse(newValue.text);

        final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

        String newText = formatter.format(value/100);

        return newValue.copyWith(
            text: newText,
            selection: new TextSelection.collapsed(offset: newText.length));
    }
}
*/