import 'package:flutter/material.dart';
import 'package:jsonschema_forms/jsonschema_forms.dart';

Map<String, dynamic> dataSchema = {
  "title": "Member Profile",
  "description": "Organization member details.",
  "type": "object",
  "required": [],
  "properties": {
    "personal": {
      "type": "object",
      "title": "Personal Details",
      "properties": {
        "name": {
          "type": "object",
          "properties": {
            "firstName[0]": {
              "type": "string",
              "title": "First name",
              "default": "Chuck"
            },
            "lastName": {
              "type": "string",
              "title": "Last name",
              "default": "Norris"
            }
          }
        },
        "bio": {"type": "string", "title": "Biography"}
      }
    },
    "startOfService": {"type": "string", "title": "Date Entered Fire Service"},
    "startOfMembership": {
      "type": "string",
      "title": "Date Joined Organization"
    },
    "telephone": {"type": "string", "title": "Telephone", "minLength": 10},
    "scheduling": {
      "type": "object",
      "title": "Scheduling",
      "properties": {
        "scheduled": {"type": "boolean", "title": "Scheduled"},
        "fullTime": {"type": "boolean", "title": "Full Time"},
        "targetHours": {"type": "number", "title": "Target Hours"},
        "shift": {"type": "string", "title": "Shift"}
      }
    },
    "qualifications": {
      "type": "array",
      "title": "Qualifications",
      "items": {
        "type": "string",
        "enum": ["FF1", "FF2", "FO1", "FO2"]
      }
    }
  }
};

Map<String, dynamic> formData = {
  "personal": {
    "name": {"firstName": "Ethan", "lastName": "Harstad"},
    "bio":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vestibulum faucibus varius. Donec id lorem vitae est tempor volutpat. Fusce aliquet vehicula felis, sed efficitur ante interdum ac. Nullam semper turpis eget sem congue commodo. Pellentesque eget risus rutrum, molestie felis quis, posuere justo. Morbi rutrum nibh ac dictum elementum. Mauris non sagittis est. Vivamus pharetra, nunc non facilisis commodo, erat nisl tempor ante, eget vulputate tellus purus eget diam. Aenean tristique ut metus blandit elementum. Nam sodales velit dolor, in laoreet orci malesuada at. In pellentesque dignissim lectus at pretium. Vestibulum sed nunc vel mauris consectetur congue. Pellentesque sit amet pretium ipsum. Sed ligula risus, laoreet nec viverra eu, laoreet id diam."
  },
  "startOfService": "2017-10-01",
  "startOfMembership": "2017-10-01",
  "telephone": "5159990334"
};

Map<String, dynamic> uiSchema = {
  "personal": {
    "bio": {"ui:widget": "textarea"}
  },
  "startOfService": {"ui:widget": "date"},
  "startOfMembership": {"ui:widget": "date"},
  "telephone": {
    "ui:options": {"inputType": "tel"}
  }
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jsonschema_forms example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('jsonschema_forms example'),
        ),
        body: FormWidget(
          dataSchema: dataSchema,
          uiSchema: uiSchema,
          formData: formData,
        ),
      ),
    );
  }
}
