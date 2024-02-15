import 'package:flutter/cupertino.dart';
import 'base.dart';
import 'field.dart';


class ExpandedControl extends Control{
  ExpandedControl({super.key});

  @override
  State<StatefulWidget> createState() => _ExpandedControl();
}

class _ExpandedControl extends ControlState<ExpandedControl>{

  late var fields = <Field>[
    IntField(this, 'flex' , defaultValue : 1, isDefault : true, isNullable : false),
    WidgetField(this, 'child' , isRequired : () => true)
  ];

  @override
  Type get type => Expanded;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Expanded(
      flex : fields[0].value,
      child : fields[1].value,
    );
  }
}