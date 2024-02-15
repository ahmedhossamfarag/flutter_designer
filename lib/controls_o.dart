import 'package:flutter/cupertino.dart';
import 'base.dart';
import 'field.dart';

class OpacityControl extends Control{
  OpacityControl({super.key});

  @override
  State<StatefulWidget> createState() => _OpacityControl();
}

class _OpacityControl extends ControlState<OpacityControl>{

  late var fields = <Field>[
    DoubleField(this, 'opacity' , isNullable : false, defaultValue : 1, isRequired : () => true, constrain: (v) => v == null || v <= 1),
    BoolField(this, 'alwaysIncludeSemantics' , defaultValue : false, isDefault : true, isNullable : false),
    WidgetField(this, 'child' )
  ];

  @override
  Type get type => Opacity;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Opacity(
      opacity : fields[0].value,
      alwaysIncludeSemantics : fields[1].value,
      child : fields[2].value,
    );
  }
}