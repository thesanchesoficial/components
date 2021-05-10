import 'package:components_venver/functions.dart';
import 'package:components_venver/src/settings/filter_mask.dart';
import 'package:components_venver/src/settings/mask_type.dart';
import 'package:components_venver/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:components_venver/src/material/components/widgets/text_field_type/text_field_type.dart';
export 'package:components_venver/src/material/components/widgets/text_field_type/text_field_type.dart';

// ! VER controllers / formatters
/*
https://pub.dev/packages/flutter_masked_text
https://pub.dev/packages/mask_text_input_formatter
https://pub.dev/packages/masked_text_formatter
https://pub.dev/packages/extended_masked_text
https://pub.dev/packages/masked_controller
https://pub.dev/packages/masked_text_input_formatter
*/

// ! Pq a rota não é feita com enum?
// ! Adicionar autoFocus (lista de focusNode) no withSuggestions (e no dropdown)
/* // ! Ver sobre enum's
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
  final dynamic controller; // TextEditingController
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
  final ValueChanged<String> onSuggestionSelected;
  final bool automaticFocusWithFocusNodeList;
  // final VoidCallback onPressedSuffix;

  static final String assetMsgFocusNodeList = "If you pass 'focusNodeList', you need to pass its position with 'focusNodeIndex'";
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
    this.automaticFocusWithFocusNodeList = true,
  })  : this.fieldType = null,
        this.suggestionsList = null,
        this.ignoreAccentsOnSuggestion = null,
        this.caseSensitiveOnSuggestion = null,
        this.onSuggestionSelected = null,
        // assert(
        //   controller is TextEditingController,
        //   "'controller' is not TextEditingController",
        // ),
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
    this.automaticFocusWithFocusNodeList = true,
    this.onSuggestionSelected,
  })  : this.fieldType = null,
        this.onSaved = null,
        this.validator = null,
        // assert(
        //   !(controller is TextEditingController),
        //   "'controller' is not TextEditingController",
        // ),
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
    this.automaticFocusWithFocusNodeList = true,
  })  : this.suggestionsList = null,
        this.onSuggestionSelected = null,
        this.ignoreAccentsOnSuggestion = null,
        this.caseSensitiveOnSuggestion = null,
        // assert(
        //   !(controller is MaskedTextController),
        //   "'controller' is not MaskedTextController",
        // ),
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
            borderSide: const BorderSide(color: AppTheme.errorColor ?? Colors.red),
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
          if(onSuggestionSelected != null) {
            onSuggestionSelected(suggestion?.toString());
          }
          if(controller != null) {
            controller.text = suggestion?.toString() ?? "";
          }
        },
      );
    }
  }

  void changeTextFieldType(BuildContext context) {
    if(fieldType != null) {
      switch(fieldType.type) {
        case TextFieldMaskType.name:
          _keyboardType = TextInputType.name;
          _textCapitalization = TextCapitalization.words;
          break;

        case TextFieldMaskType.email:
          _keyboardType = TextInputType.emailAddress;
          _textCapitalization = TextCapitalization.none;
          break;

        case TextFieldMaskType.password: // ! Ver se dá para melhorar
          _keyboardType = TextInputType.text; // TextInputType.visiblePassword,
          _textCapitalization = TextCapitalization.none;
          break;

        case TextFieldMaskType.multiText: // ! Terminar
          break;

        case TextFieldMaskType.cep:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          controller.updateMask(MaskType.cep);
          // var _mask = OwMaskedFormatter.cep(); // initialText: controller?.text ?? ""
          // _inputFormatters = [_mask];
          break;

        case TextFieldMaskType.search: // ! Terminar
          _keyboardType = TextInputType.text;
          _textInputAction = TextInputAction.search;
          // textInputAction: TextInputAction.done, // Nos filtros, é usado done, pq ao digitar, ele já pesquisa automaticamente, já em outros lugares, deve ser serach, pois só pesquisará quando pressionar
          // icon: controller.text.isNotEmpty
          //   ? const Icon(Icons.close, color: Colors.grey,)
          //   : const Icon(Icons.search, color: Colors.grey,),
          // onPressedSuffix: controller.text.isNotEmpty ? (){
          //   controller.clear();
          //   pesquisar(categoria, controller.text);
          // } : null,
          break;

        case TextFieldMaskType.cardNumber:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          controller.updateMask(MaskType.cardNumber);
          // final _mask = OwMaskedFormatter.cardNumber(initialText: controller?.text); // initialText: controller?.text ?? ""
          // _inputFormatters = [_mask];
          break;

        case TextFieldMaskType.cardCvv:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          controller.updateMask(MaskType.cardCvv);
          // final _mask = OwMaskedFormatter.cardCvv(initialText: controller?.text); // initialText: controller?.text ?? ""
          // _inputFormatters = [_mask];
          break;

        case TextFieldMaskType.cardDateYY:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          controller.updateMask(MaskType.cardDateYY);
          // final _mask = OwMaskedFormatter.cardDateYY(initialText: controller?.text); // initialText: controller?.text ?? ""
          // _inputFormatters = [_mask];
          break;

        case TextFieldMaskType.cardDateYYYY:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          controller.updateMask(MaskType.cardDateYYYY);
          // final _mask = OwMaskedFormatter.cardDateYYYY(initialText: controller?.text); // initialText: controller?.text ?? ""
          // _inputFormatters = [_mask];
          break;

        case TextFieldMaskType.date:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.datetime;
          controller.updateMask(MaskType.date);
          // final _mask = OwMaskedFormatter.date(initialText: controller?.text); // initialText: controller?.text ?? ""
          // _inputFormatters = [_mask];
          break;

        case TextFieldMaskType.cpf:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          controller.updateMask(MaskType.cpf);
          // final _mask = OwMaskedFormatter.cpf(initialText: controller?.text); // initialText: controller?.text ?? ""
          // _inputFormatters = [_mask];
          break;

        case TextFieldMaskType.cnpj:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          controller.updateMask(MaskType.cnpj);
          // final _mask = OwMaskedFormatter.cnpj(initialText: controller?.text); // initialText: controller?.text ?? ""
          // _inputFormatters = [_mask];
          break;
        
        case TextFieldMaskType.cpfCnpj:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          String _cpfMask = MaskType.cpf + "0";
          _changeMask = () {
            if(controller.text.length <= MaskType.cpf.length && controller.mask != _cpfMask) {
              controller.updateMask(_cpfMask);
            } else if(controller.text.length > MaskType.cpf.length && controller.mask != MaskType.cnpj) {
              controller.updateMask(MaskType.cnpj);
            }
          };
          _changeMask();
          // if(!(controller is MaskedTextController)) {
          //   throw ArgumentError.value(
          //     controller,
          //     "controller is not MaskedTextController", // Name
          //     "Invalid controller: The controller needs to be instantiated as MaskedTextController class", // Message
          //   );
          // } 
          // MaskTextInputFormatter _maskFormatter;
          // if(controller?.text?.length == MaskType.cpf.length) { // ! E se controller?.text for null ?
          //   _maskFormatter = OwMaskedFormatter.cpf(initialText: controller?.text); // initialText: controller?.text ?? ""
          // } else {
          //   _maskFormatter = OwMaskedFormatter.cnpj(initialText: controller?.text); // initialText: controller?.text ?? ""
          // }
          // _inputFormatters = [_maskFormatter];
          // _changeMask = () {
          //   int _position = controller?.selection?.baseOffset;
          //   String _text = _maskFormatter.getUnmaskedText();
          //   String _mask = _maskFormatter.getMask();
          //   if(_text.length > 10 && _mask != MaskType.cpf) {
          //     _maskFormatter.updateMask(mask: MaskType.cpf, filter: FilterMask.number);
          //     controller.updateMask(MaskType.cpf);
          //     controller.selection = TextSelection.fromPosition(TextPosition(offset: _position));
          //   } else if(_text.length <= 10 && _mask != MaskType.cnpj) {
          //     _maskFormatter.updateMask(mask: MaskType.cnpj, filter: FilterMask.number);
          //     controller.updateMask(MaskType.cnpj);
          //     controller.selection = TextSelection.fromPosition(TextPosition(offset: _position));
          //   }
          // };
          break;

        case TextFieldMaskType.landlineCell:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          String _landlineMask = MaskType.phones(10) + "0";
          _changeMask = () {
            if(controller.text.length <= MaskType.phones(10).length && controller.mask != _landlineMask) {
              controller.updateMask(_landlineMask);
            } else if(controller.text.length > MaskType.phones(10).length && controller.mask != MaskType.phones(11)) {
              controller.updateMask(MaskType.phones(11));
            }
          };
          _changeMask();
          // if(!(controller is MaskedTextController)) {
          //   throw ArgumentError.value(
          //     controller,
          //     "controller is not MaskedTextController", // Name
          //     "Invalid controller: The controller needs to be instantiated as MaskedTextController class", // Message
          //   );
          // } 
          // var maskFormatter = OwMaskedFormatter.phones(11, initialText: controller?.text);
          // // _inputFormatters = [maskFormatter];
          // _changeMask = () {
          //   int position = controller?.selection?.baseOffset;
          //   String text = maskFormatter.getUnmaskedText();
          //   String mask = maskFormatter.getMask();
          //   if(text.length >= 11 && mask != '(00) 00000-0000') {
          //     maskFormatter.updateMask(mask: '(00) 00000-0000', filter: { "0": RegExp(r'[0-9]') });
          //     controller.updateMask('(00) 00000-0000');
          //     controller.selection = TextSelection.fromPosition(TextPosition(offset: position));
          //   } else if(text.length <= 10 && mask != '(00) 0000-00000') {
          //     maskFormatter.updateMask(mask: '(00) 0000-00000', filter: { "0": RegExp(r'[0-9]') });
          //     controller.updateMask('(00) 0000-00000');
          //     controller.selection = TextSelection.fromPosition(TextPosition(offset: position));
          //   }
          // };
          // // MaskTextInputFormatter _maskFormatter;
          // // if(controller?.text?.length == MaskType.phones(10).length) { // ! E se controller?.text for null ?????
          // //   _maskFormatter = OwMaskedFormatter.phones(10, initialText: controller?.text); // initialText: controller?.text ?? ""
          // // } else {
          // //   _maskFormatter = OwMaskedFormatter.phones(11, initialText: controller?.text); // initialText: controller?.text ?? ""
          // // }
          // // _inputFormatters = [_maskFormatter];
          // // _changeMask = () {
          // //   int _position = controller?.selection?.baseOffset;
          // //   String _text = _maskFormatter.getUnmaskedText();
          // //   String _mask = _maskFormatter.getMask();
          // //   if(_text.length > 10 && _mask != MaskType.phones(10)) {
          // //     _maskFormatter.updateMask(mask: MaskType.phones(10), filter: FilterMask.number);
          // //     controller.updateMask(MaskType.cpf); // ! Descomentar
          // //     controller.selection = TextSelection.fromPosition(TextPosition(offset: _position));
          // //   } else if(_text.length <= 10 && _mask != MaskType.phones(11)) {
          // //     _maskFormatter.updateMask(mask: MaskType.phones(11), filter: FilterMask.number);
          // //     controller.updateMask(MaskType.cnpj); // ! Descomentar
          // //     controller.selection = TextSelection.fromPosition(TextPosition(offset: _position));
          // //   }
          // };
          break;
          
        case TextFieldMaskType.phones:
          assert(controller is MaskedTextController);
          _keyboardType = TextInputType.phone;
          if(fieldType.numbersQuantity != null) {
            final _mask = OwMaskedFormatter.phones(
              fieldType.numbersQuantity,
              initialText: controller?.text, // initialText: controller?.text ?? ""
            );
            _inputFormatters = [_mask];
          } else {
            // ! Terminar
          }
          break;

        case TextFieldMaskType.money:
          assert(controller is MoneyMaskedTextController);
          // _hintText = "0,00";
          // _prefixText = "R\$ ";
          _keyboardType = TextInputType.phone;
          break;

        case TextFieldMaskType.integer:
          break;

        case TextFieldMaskType.chat:
          break;

        default:
          break;
      }
    }
  }

  void defineFocusNode(BuildContext context) {
    _focusNode = focusNode;
    _nextFocusNode = nextFocusNode;

    if(focusNodeList != null && focusNodeList.length > focusNodeIndex) {
      _focusNode = _focusNode ?? focusNodeList[focusNodeIndex];
    }
    if(focusNodeList != null && focusNodeList.length > focusNodeIndex + 1) {
      _nextFocusNode = _nextFocusNode ?? focusNodeList[focusNodeIndex + 1];
    }

    if(_nextFocusNode != null) {
      _textInputAction = TextInputAction.next;
      if(automaticFocusWithFocusNodeList) {
        _goToNextFocusNode = () {
          FocusScope.of(context).requestFocus(_nextFocusNode); // ! Passar para classe FN
        };
      }
    } else {
      _textInputAction = TextInputAction.done;
      if(unfocusIfNoNextFocusNode && automaticFocusWithFocusNodeList) {
        _goToNextFocusNode = () {
          FocusScope.of(context).unfocus(); // ! Passar para classe FN
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


/*
DV (conta banco)

final _regExpMeiFancyName = RegExp(r'^[a-zA-Z0-9]+');

inputFormatters: [
  UpperCaseTextFormatter(),
  FilteringTextInputFormatter.allow(_regExpMeiFancyName),
],
*/