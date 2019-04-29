import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BooleanField extends StatefulWidget {
  final String fieldKey;
  final Map<String, dynamic> dataSchema;

  BooleanField({@required this.fieldKey, @required this.dataSchema});

  @override
  _BooleanFieldState createState() => _BooleanFieldState();
}

class _BooleanFieldState extends State<BooleanField> {
  bool _value;

  @override
  void initState() {
    super.initState();
    _value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.dataSchema['title']),
      value: _value,
      onChanged: (bool value) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}
