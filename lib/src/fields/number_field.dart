import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class NumberField extends StatefulWidget {
  final String fieldKey;
  final Map<String, dynamic> dataSchema;

  NumberField({@required this.fieldKey, @required this.dataSchema});

  @override
  _NumberFieldState createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: widget.dataSchema['default']);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.dataSchema['title'],
        ),
      ),
    );
  }
}
