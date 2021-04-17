// import 'package:components_venver/theme/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

// class OwTextField extends StatelessWidget {
//   final String labelText;
//   final String hintText;
//   final String errorText;
//   final String helperText;
//   final bool readOnly;
//   final String obscuringCharacter;
//   final Icon icon;
//   final TextInputType keyboardType;
//   final TextInputAction textInputAction;
//   final TextEditingController controller;
//   final FormFieldValidator<String> validatorHandler;
//   final ValueChanged<String> onFieldSubmitted;
//   final FocusNode focusNode;
//   final bool obscureText;
//   final ValueChanged<String> onChanged;
//   final Function onTap;
//   final FormFieldSetter<String> onSaved;
//   final VoidCallback onPressedSuffix;
//   final int maxLength;
//   final int minLines;
//   final int maxLines;
//   final EdgeInsets margin;
//   final bool enabled;
//   final bool enableInteractive;
//   final bool autofocus;
//   final TextCapitalization textCapitalization;
//   final bool maxLengthEnforced;
//   final String counterText;
//   final Color color;
//   final List<TextInputFormatter> inputFormatters;
//   final String suffixText;
//   final String prefixText;
//   final bool suggestions;
//   final List<dynamic> listSuggestions;

//   OwTextField({
//     Key key,
//     this.labelText,
//     this.hintText,
//     this.helperText,
//     this.errorText,
//     this.obscuringCharacter,
//     this.keyboardType,
//     this.controller,
//     this.validatorHandler,
//     this.textInputAction = TextInputAction.next,
//     this.obscureText = false,
//     this.readOnly = false,
//     this.onFieldSubmitted,
//     this.focusNode,
//     this.onChanged,
//     this.onTap,
//     this.onPressedSuffix,
//     this.onSaved,
//     this.maxLength,
//     this.minLines = 1,
//     this.maxLines = 1,
//     this.margin,
//     this.enabled,
//     this.enableInteractive,
//     this.autofocus = false,
//     this.textCapitalization = TextCapitalization.sentences,
//     this.maxLengthEnforced = true,
//     this.counterText,
//     this.color,
//     this.inputFormatters,
//     this.prefixText,
//     this.suffixText,
//   })  : icon = null,
//         suggestions = false,
//         listSuggestions = [],
//         super(key: key);

//   const OwTextField.withSuggestions({
//     Key key,
//     this.labelText,
//     this.hintText,
//     this.helperText,
//     this.errorText,
//     this.keyboardType,
//     this.obscuringCharacter,
//     this.controller,
//     this.validatorHandler,
//     this.textInputAction = TextInputAction.next,
//     this.obscureText = false,
//     this.readOnly = false,
//     this.onFieldSubmitted,
//     this.focusNode,
//     this.onChanged,
//     this.onTap,
//     this.onPressedSuffix,
//     this.onSaved,
//     this.maxLength,
//     this.minLines = 1,
//     this.maxLines = 1,
//     this.margin,
//     this.enabled,
//     this.enableInteractive,
//     this.autofocus = false,
//     this.textCapitalization = TextCapitalization.sentences,
//     this.maxLengthEnforced = true,
//     this.counterText,
//     this.color,
//     this.inputFormatters,
//     this.prefixText,
//     this.suffixText,
//     this.listSuggestions,
//   })  : icon = null,
//         suggestions = true,
//         super(key: key);

//   OwTextField.withSuffix({
//     Key key,
//     this.labelText,
//     this.hintText,
//     this.helperText,
//     this.errorText,
//     this.obscuringCharacter,
//     this.readOnly = false,
//     this.keyboardType,
//     this.controller,
//     this.validatorHandler,
//     this.textInputAction = TextInputAction.next,
//     this.obscureText = false,
//     this.onFieldSubmitted,
//     this.focusNode,
//     @required this.icon,
//     this.onChanged,
//     this.onTap,
//     this.onPressedSuffix,
//     this.onSaved,
//     this.maxLength,
//     this.minLines = 1,
//     this.maxLines = 1,
//     this.margin,
//     this.enabled,
//     this.enableInteractive,
//     this.autofocus = false,
//     this.textCapitalization = TextCapitalization.sentences,
//     this.maxLengthEnforced = true,
//     this.counterText,
//     this.color,
//     this.inputFormatters,
//     this.prefixText,
//     this.suffixText,
//   })  : suggestions = false,
//         listSuggestions = [],
//         assert(icon != null),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if(suggestions) {
//       return Container(
//         key: key,
//         margin: margin,
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         child: TypeAheadField(
//           textFieldConfiguration: TextFieldConfiguration(
//             autofocus: autofocus,
//             controller: controller,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: color ?? Theme.of(context).cardColor,
//               labelText: labelText,
//               hintText: hintText,
//               errorText: errorText,
//               counterText: counterText,
//               alignLabelWithHint: true,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Theme.of(context).secondaryHeaderColor,
//                   width: 1,
//                 ),
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 borderSide: BorderSide(
//                   color: Theme.of(context).secondaryHeaderColor,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                 borderSide: BorderSide(
//                   color: Theme.of(context).secondaryHeaderColor,
//                 ),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 20, 
//                 vertical: 18,
//               ),
//               labelStyle: TextStyle(
//                 color: Theme.of(context).primaryTextTheme.bodyText1.color,
//               ),
//               errorBorder: const UnderlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 borderSide: BorderSide(
//                   color: AppTheme.errorColor ?? Colors.red,
//                 ),
//               ),
//               helperText: helperText,
//               helperMaxLines: 3,
//               errorStyle: const TextStyle(
//                 color: AppTheme.errorColor ?? Colors.red,
//               ),
//               suffixText: suffixText,
//               prefixText: prefixText,
//               suffixIcon: (icon != null)
//                 ? IconButton(
//                   icon: icon,
//                   onPressed: onPressedSuffix,
//                 )
//                 : null,
//             ),
//           ),
//           suggestionsCallback: (string) async {
//             return await _getSuggestionsList(string);
//           },
//           noItemsFoundBuilder: (_) {
//             return SizedBox();
//           },
//           itemBuilder: (context, suggestion) {
//             return ListTile(
//               title: Text(
//                 suggestion.toString(),
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               trailing: Icon(Icons.touch_app_outlined),
//             );
//           },
//           onSuggestionSelected: (suggestion) {
//             controller.text = suggestion;
//           },
//         ),
//       );
//     } else {
//       return Container(
//         key: key,
//         margin: margin,
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         child: TextFormField(
//           inputFormatters: inputFormatters ??
//               [
//                 BlacklistingTextInputFormatter(RegExp("")),
//               ],
//           minLines: minLines,
//           maxLines: maxLines,
//           maxLengthEnforced: maxLengthEnforced,
//           enabled: enabled ?? true,
//           enableInteractiveSelection: enableInteractive ?? true,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: color ?? Theme.of(context).cardColor,
//             labelText: labelText,
//             hintText: hintText,
//             errorText: errorText,
//             counterText: counterText,
//             alignLabelWithHint: false,
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Theme.of(context).secondaryHeaderColor,
//                 width: 1,
//               ),
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//               borderSide:
//                   BorderSide(color: Theme.of(context).secondaryHeaderColor),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//               borderSide:
//                   BorderSide(color: Theme.of(context).secondaryHeaderColor),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//             labelStyle: TextStyle(
//               color: Theme.of(context).primaryTextTheme.bodyText1.color,
//             ),
//             errorBorder: const UnderlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               borderSide: BorderSide(color: AppTheme.errorColor ?? Colors.red),
//             ),
//             helperText: helperText,
//             helperMaxLines: 3,
//             errorStyle:
//                 const TextStyle(color: AppTheme.errorColor ?? Colors.red),
//             suffixText: suffixText,
//             prefixText: prefixText,
//             suffixIcon: (icon != null)
//                 ? IconButton(
//                     icon: icon,
//                     onPressed: onPressedSuffix,
//                   )
//                 : null,
//           ),
//           onTap: onTap,
//           onSaved: onSaved,
//           onChanged: onChanged,
//           maxLength: maxLength,
//           readOnly: readOnly,
//           validator: validatorHandler,
//           controller: controller,
//           textInputAction: textInputAction,
//           onFieldSubmitted: onFieldSubmitted,
//           focusNode: focusNode,
//           keyboardType: keyboardType,
//           obscureText: obscureText,
//           autofocus: autofocus,
//           textCapitalization:
//               textCapitalization ?? TextCapitalization.sentences,
//         ),
//       );
//     }
//   }

//   _getSuggestionsList(string) {
//     List listaDeSugestoes = [];
//     if (suggestions && listSuggestions.isNotEmpty) {
//       listaDeSugestoes = listSuggestions;
//     }
//     return listaDeSugestoes.where((element) => element
//         .toString()
//         .toLowerCase()
//         .contains(string.toString().toLowerCase()));
//   }
// }
