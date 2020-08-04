import 'package:flutter/material.dart';

class Custom3dTextInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final String hint;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final bool isNumber;
  final bool lastField;

  Custom3dTextInput(
      {@required this.controller,
      @required this.focus,
      @required this.hint,
      this.onChanged,
      this.onFieldSubmitted,
      this.isNumber = false,
      this.lastField = false});

  @override
  _Custom3dTextInputState createState() => _Custom3dTextInputState();
}

class _Custom3dTextInputState extends State<Custom3dTextInput> {
  final double borderRadius = 8.0;
  final Color primaryColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: widget.controller,
          autofocus: true,
          focusNode: widget.focus,
          textInputAction:
              widget.lastField ? TextInputAction.done : TextInputAction.next,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          keyboardType: widget.isNumber ? TextInputType.number : null,
          decoration: InputDecoration(
            hintText: widget.hint,
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(width: 1, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(width: 1, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
