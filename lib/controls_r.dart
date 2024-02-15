import 'package:flutter/material.dart';
import 'base.dart';
import 'field.dart';

class RowControl extends Control{
  RowControl({super.key});

  @override
  State<StatefulWidget> createState() => _RowControl();
}

class _RowControl extends ControlState<RowControl>{

  late var fields = <Field>[
    EnumField(this, 'mainAxisAlignment', choices : MainAxisAlignment.values , defaultValue : MainAxisAlignment.start, isDefault : true, isNullable : false),
    EnumField(this, 'mainAxisSize', choices : MainAxisSize.values , defaultValue : MainAxisSize.max, isDefault : true, isNullable : false),
    EnumField(this, 'crossAxisAlignment', choices : CrossAxisAlignment.values , defaultValue : CrossAxisAlignment.center, isDefault : true, isNullable : false),
    EnumField(this, 'textDirection', choices : TextDirection.values ),
    EnumField(this, 'verticalDirection', choices : VerticalDirection.values , defaultValue : VerticalDirection.down, isDefault : true),
    EnumField(this, 'textBaseline', choices : TextBaseline.values ),
    ListWidgetField(this, 'children' , defaultValue : [], isDefault : true, isNullable: false),
  ];

  @override
  Type get type => Row;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Row(
      mainAxisAlignment : fields[0].value,
      mainAxisSize : fields[1].value,
      crossAxisAlignment : fields[2].value,
      textDirection : fields[3].value,
      verticalDirection : fields[4].value,
      textBaseline : fields[5].value,
      children : fields[6].value,
    );
  }
}

class RadioControl extends Control{
  RadioControl({super.key});

  @override
  State<StatefulWidget> createState() => _RadioControl();
}

class _RadioControl extends DraggableControlState<RadioControl>{

  late var fields = <Field>[
    StringField(this, 'value' , isNullable : false, defaultValue : '$hashCode', isRequired : () => true),
    StringField(this, 'groupValue' , isRequired : () => true),
    ClosureField<ValueChanged<String>>(this, 'onChanged' , isRequired : () => true),
    MouseCursorField(this, 'mouseCursor' ),
    BoolField(this, 'toggleable' , defaultValue : false, isDefault : true, isNullable : false),
    ColorField(this, 'activeColor' ),
    ColorField(this, 'focusColor' ),
    ColorField(this, 'hoverColor' ),
    DoubleField(this, 'splashRadius' ),
    BoolField(this, 'autofocus' , defaultValue : false, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => Radio;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return Radio(
      value : fields[0].value,
      groupValue : fields[1].value,
      onChanged : fields[2].value,
      mouseCursor : fields[3].value,
      toggleable : fields[4].value,
      activeColor : fields[5].value,
      focusColor : fields[6].value,
      hoverColor : fields[7].value,
      splashRadius : fields[8].value,
      autofocus : fields[9].value,
    );
  }
}

/*
import 'package:flutter/material.dart' hide ColorProperty;
import 'package:flutter_designer/property.dart';
import 'controls.dart';


class RowControl extends Control{
  const RowControl({super.key, super.parent});

  @override
  State<StatefulWidget> createState() => _RowControl();
}

class _RowControl extends MultiChildContainerState{


  MainAxisAlignment? mainAxisAlignment;
  MainAxisSize? mainAxisSize;
  CrossAxisAlignment? crossAxisAlignment;
  TextDirection? textDirection;
  VerticalDirection? verticalDirection;
  TextBaseline? textBaseline;
  bool? hide; 
  
  @override
  Widget buildWidget(){
    return Row(
      mainAxisAlignment : mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize : mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment : crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection : textDirection,
      verticalDirection : verticalDirection ?? VerticalDirection.down,
      textBaseline : textBaseline,
      children : children + (hide == true ? [] : [const Room('Row')]),
    );
  }

  @override
  List<Widget> getProperties(){
    return [
      EnumProperty('Main Axis Alignment', mainAxisAlignment, MainAxisAlignment.values, (value){setState((){mainAxisAlignment = value;});}),
      EnumProperty('Main Axis Size', mainAxisSize, MainAxisSize.values, (value){setState((){mainAxisSize = value;});}),
      EnumProperty('Cross Axis Alignment', crossAxisAlignment, CrossAxisAlignment.values, (value){setState((){crossAxisAlignment = value;});}),
      EnumProperty('Text Direction', textDirection, TextDirection.values, (value){setState((){textDirection = value;});}),
      EnumProperty('Vertical Direction', verticalDirection, VerticalDirection.values, (value){setState((){verticalDirection = value;});}),
      EnumProperty('Text Baseline', textBaseline, TextBaseline.values, (value){setState((){textBaseline = value;});}),
      BooleanProperty('Hide', hide, (value) { setState((){hide = value;});})
    ];
  }
}

 */