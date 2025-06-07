import 'package:flutter/material.dart';

import '../../utils/globall_color.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final bool readOnly;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.onTap,
    this.readOnly=false,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: (value) {
            if (!_showError && value.isNotEmpty) {
              setState(() {
                _showError = true;
              });
            }
          },
          onFieldSubmitted: (value) {
            setState(() {
              _showError = true;
            });
          },
          validator: (value) {
            if (_showError) {
              return widget.validator?.call(value);
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            prefixIcon: Icon(widget.prefixIcon, color:Color(0xFF8A8AA3)),
            suffixIcon: widget.obscureText
                ? IconButton(
              icon: Icon(
                  _obscureText ? Icons.visibility_off_outlined : Icons.visibility,
                  color:Color(0xFF8A8AA3)
              ),
              onPressed: _toggleObscureText,
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:  BorderSide(color: GlobalColors.mainColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
            filled: false,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
