import 'package:flutter/material.dart';
import 'base.dart';
import 'field.dart';


class FloatingActionButtonControl extends Control{
  FloatingActionButtonControl({super.key});

  @override
  State<StatefulWidget> createState() => _FloatingActionButtonControl();
}

class _FloatingActionButtonControl extends ControlState<FloatingActionButtonControl>{

  late var fields = <Field>[
    WidgetField(this, 'child' ),
    StringField(this, 'tooltip' ),
    ColorField(this, 'foregroundColor' ),
    ColorField(this, 'backgroundColor' ),
    ColorField(this, 'focusColor' ),
    ColorField(this, 'hoverColor' ),
    ColorField(this, 'splashColor' ),
    DoubleField(this, 'elevation' ),
    DoubleField(this, 'focusElevation' ),
    DoubleField(this, 'hoverElevation' ),
    DoubleField(this, 'highlightElevation' ),
    DoubleField(this, 'disabledElevation' ),
    ClosureField<VoidCallback>(this, 'onPressed' , isRequired : () => true, defaultValue: (){}, defaultString: '(){}'),
    MouseCursorField(this, 'mouseCursor' ),
    BoolField(this, 'mini' , defaultValue : false, isDefault : true, isNullable : false),
    ShapeBorderField(this, 'shape' ),
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.none, isDefault : true, isNullable : false),
    BoolField(this, 'autofocus' , defaultValue : false, isDefault : true, isNullable : false),
    EnumField(this, 'materialTapTargetSize', choices : MaterialTapTargetSize.values ),
    BoolField(this, 'isExtended' , defaultValue : false, isDefault : true, isNullable : false),
    BoolField(this, 'enableFeedback' )
  ];

  @override
  Type get type => FloatingActionButton;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return FloatingActionButton(
      child : fields[0].value,
      tooltip : fields[1].value,
      foregroundColor : fields[2].value,
      backgroundColor : fields[3].value,
      focusColor : fields[4].value,
      hoverColor : fields[5].value,
      splashColor : fields[6].value,
      elevation : fields[7].value,
      focusElevation : fields[8].value,
      hoverElevation : fields[9].value,
      highlightElevation : fields[10].value,
      disabledElevation : fields[11].value,
      onPressed : fields[12].value,
      mouseCursor : fields[13].value,
      mini : fields[14].value,
      shape : fields[15].value,
      clipBehavior : fields[16].value,
      autofocus : fields[17].value,
      materialTapTargetSize : fields[18].value,
      isExtended : fields[19].value,
      enableFeedback : fields[20].value,
    );
  }
}
