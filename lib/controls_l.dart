import 'package:flutter/material.dart';
import 'base.dart';
import 'field.dart';

class LongPressDraggableControl extends Control{
  LongPressDraggableControl({super.key});

  @override
  State<StatefulWidget> createState() => _LongPressDraggableControl();
}

class _LongPressDraggableControl extends ControlState<LongPressDraggableControl>{

  late var fields = <Field>[
    WidgetField(this, 'child' , isRequired : () => true),
    WidgetField(this, 'feedback' , isRequired : () => true),
    EnumField(this, 'axis', choices : Axis.values ),
    WidgetField(this, 'childWhenDragging' ),
    OffsetField(this, 'feedbackOffset', defaultValue : Offset.zero, isDefault : true, isNullable : false),
    IntField(this, 'maxSimultaneousDrags' ),
    BoolField(this, 'hapticFeedbackOnStart' , defaultValue : true, isDefault : true, isNullable : false),
    BoolField(this, 'ignoringFeedbackSemantics' , defaultValue : true, isDefault : true, isNullable : false),
    BoolField(this, 'ignoringFeedbackPointer' , defaultValue : true, isDefault : true, isNullable : false),
    DurationField(this, 'delay' , defaultValue : const Duration(seconds: 1), defaultString: 'const Duration(seconds: 1)', isDefault : true, isNullable : false),
  ];

  @override
  Type get type => LongPressDraggable;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return LongPressDraggable(
      child : fields[0].value,
      feedback : fields[1].value,
      axis : fields[2].value,
      childWhenDragging : fields[3].value,
      feedbackOffset : fields[4].value,
      maxSimultaneousDrags : fields[5].value,
      hapticFeedbackOnStart : fields[6].value,
      ignoringFeedbackSemantics : fields[7].value,
      ignoringFeedbackPointer : fields[8].value,
      delay : fields[9].value,
    );
  }
}
