
import 'package:flutter/cupertino.dart';

import 'base.dart';
import 'field.dart';

class PaddingControl extends Control{
  PaddingControl({super.key});

  @override
  State<StatefulWidget> createState() => _PaddingControl();
}

class _PaddingControl extends ControlState<PaddingControl>{

  late var fields = <Field>[
    EdgeInsetsField(this, 'padding' , isNullable : false),
    WidgetField(this, 'child' ),
  ];

  @override
  Type get type => Padding;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Padding(
      padding : fields[0].value,
      child : fields[1].value,
    );
  }
}

/*
import 'package:flutter/material.dart' hide ColorProperty;
import 'package:flutter_designer/property.dart';
import 'controls.dart';

class PaddingControl extends Control{
  const PaddingControl({super.key, super.parent});

  @override
  State<StatefulWidget> createState() => _PaddingControl();
}

class _PaddingControl extends ChildContainerState{


  EdgeInsets? padding;

  @override
  Widget buildWidget(){
    return Padding(
      padding : padding ?? const EdgeInsets.all(0),
      child : child ?? const Room('Padding'),
    );
  }

  @override
  List<Widget> getProperties(){
    return [
      PaddingProperty('Padding', padding, (value){setState((){print(value); padding = value;});}),
     ];
  }
}

 */