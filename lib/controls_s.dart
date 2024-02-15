import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'base.dart';
import 'field.dart';

class SizedBoxControl extends Control{
  SizedBoxControl({super.key});

  @override
  State<StatefulWidget> createState() => _SizedBoxControl();
}

class _SizedBoxControl extends ControlState<SizedBoxControl>{

  late var fields = <Field>[
    DoubleField(this, 'width' ),
    DoubleField(this, 'height' ),
    WidgetField(this, 'child' )
  ];

  @override
  Type get type => SizedBox;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return SizedBox(
      width : fields[0].value,
      height : fields[1].value,
      child : fields[2].value,
    );
  }
}

class StackControl extends Control{
  StackControl({super.key});

  @override
  State<StatefulWidget> createState() => _StackControl();
}

class _StackControl extends ControlState<StackControl>{

  late var fields = <Field>[
    AlignmentField(this, 'alignment' , defaultValue : Alignment.center, isDefault : true, isNullable : false),
    EnumField(this, 'textDirection', choices : TextDirection.values ),
    EnumField(this, 'fit', choices : StackFit.values , defaultValue : StackFit.loose, isDefault : true, isNullable : false),
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.hardEdge, isDefault : true, isNullable : false),
    ListWidgetField(this, 'children' , defaultValue : [], isDefault : true, isNullable : false)
  ];

  @override
  Type get type => Stack;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Stack(
      alignment : fields[0].value,
      textDirection : fields[1].value,
      fit : fields[2].value,
      clipBehavior : fields[3].value,
      children : fields[4].value,
    );
  }
}

class SwitchControl extends Control{
  SwitchControl({super.key});

  @override
  State<StatefulWidget> createState() => _SwitchControl();
}

class _SwitchControl extends DraggableControlState<SwitchControl>{

  late var fields = <Field>[
    BoolField(this, 'value' , isNullable : false, defaultValue : false, isRequired : () => true),
    ClosureField<ValueChanged<bool>>(this, 'onChanged' , isRequired : () => true),
    ColorField(this, 'activeColor' ),
    ColorField(this, 'activeTrackColor' ),
    ColorField(this, 'inactiveThumbColor' ),
    ColorField(this, 'inactiveTrackColor' ),
    EnumField(this, 'dragStartBehavior', choices : DragStartBehavior.values , defaultValue : DragStartBehavior.start, isDefault : true, isNullable : false),
    MouseCursorField(this, 'mouseCursor' ),
    ColorField(this, 'focusColor' ),
    ColorField(this, 'hoverColor' ),
    DoubleField(this, 'splashRadius' ),
    BoolField(this, 'autofocus' , defaultValue : false, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => Switch;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return Switch(
      value : fields[0].value,
      onChanged : fields[1].value,
      activeColor : fields[2].value,
      activeTrackColor : fields[3].value,
      inactiveThumbColor : fields[4].value,
      inactiveTrackColor : fields[5].value,
      dragStartBehavior : fields[6].value,
      mouseCursor : fields[7].value,
      focusColor : fields[8].value,
      hoverColor : fields[9].value,
      splashRadius : fields[10].value,
      autofocus : fields[11].value,
    );
  }
}

/*
import 'package:flutter/material.dart' hide ColorProperty;
import 'package:flutter_designer/property.dart';
import 'controls.dart';

//  //

class SizedBoxControl extends Control{
  const SizedBoxControl({super.key, super.parent});

  @override
  State<StatefulWidget> createState() => _SizedBoxControl();
}

class _SizedBoxControl extends ChildContainerState{


  double? width;
  double? height;

  @override
  Widget buildWidget(){
    return SizedBox(
      width : width,
      height : height,
      child : child ?? const Room('Sized Box'),
    );
  }

  @override
  List<Widget> getProperties(){
    return [
      DoubleProperty('Width', width, (value){setState((){width = value;});}),
      DoubleProperty('Height', height, (value){setState((){height = value;});}),
    ];
  }
}

//  //

class StackControl extends Control{
  const StackControl({super.key, super.parent});

  @override
  State<StatefulWidget> createState() => _StackControl();
}

class _StackControl extends MultiChildContainerState{


  AlignmentGeometry? alignment;
  TextDirection? textDirection;
  StackFit? fit;
  Clip? clipBehavior;
  bool? hide;

  @override
  Widget buildWidget(){
    return Stack(
      alignment : alignment ?? AlignmentDirectional.topStart,
      textDirection : textDirection,
      fit : fit ?? StackFit.loose,
      clipBehavior : clipBehavior ?? Clip.hardEdge,
      children: children + [if(hide != true) const Room('Stack')],
    );
  }

  @override
  List<Widget> getProperties(){
    return [
      AlignmentProperty('Alignment', alignment, (value){setState((){alignment = value;});}),
      EnumProperty('Text Direction', textDirection, TextDirection.values, (value){setState((){textDirection = value;});}),
      EnumProperty('Fit', fit, StackFit.values, (value){setState((){fit = value;});}),
      EnumProperty('Clip Behavior', clipBehavior, Clip.values, (value){setState((){clipBehavior = value;});}),
      BooleanProperty('Hide', hide, (value){setState((){hide = value;});})
    ];
  }
}

 */