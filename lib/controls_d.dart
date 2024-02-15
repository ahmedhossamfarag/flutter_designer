import 'package:flutter/cupertino.dart';
import 'base.dart';
import 'field.dart';

class DraggableControl extends Control{
  DraggableControl({super.key});

  @override
  State<StatefulWidget> createState() => _DraggableControl();
}

class _DraggableControl extends ControlState<DraggableControl>{

  late var fields = <Field>[
    WidgetField(this, 'child' , isRequired : () => true),
    WidgetField(this, 'feedback' , isRequired : () => true),
    EnumField(this, 'axis', choices : Axis.values ),
    OffsetField(this, 'feedbackOffset', defaultValue : Offset.zero, isDefault : true, isNullable : false),
    EnumField(this, 'affinity', choices : Axis.values ),
    IntField(this, 'maxSimultaneousDrags' ),
    BoolField(this, 'ignoringFeedbackSemantics' , defaultValue : true, isDefault : true, isNullable : false),
    BoolField(this, 'ignoringFeedbackPointer' , defaultValue : true, isDefault : true, isNullable : false),
    BoolField(this, 'rootOverlay' , defaultValue : false, isDefault : true, isNullable : false),
    EnumField(this, 'hitTestBehavior', choices : HitTestBehavior.values , defaultValue : HitTestBehavior.deferToChild, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => Draggable;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Draggable(
      child : fields[0].value,
      feedback : fields[1].value,
      axis : fields[2].value,
      feedbackOffset : fields[3].value,
      affinity : fields[4].value,
      maxSimultaneousDrags : fields[5].value,
      ignoringFeedbackSemantics : fields[6].value,
      ignoringFeedbackPointer : fields[7].value,
      rootOverlay : fields[8].value,
      hitTestBehavior : fields[9].value,
    );
  }
}

class DragTargetControl extends Control{
  DragTargetControl({super.key});

  @override
  State<StatefulWidget> createState() => _DragTargetControl();
}

class _DragTargetControl extends ControlState<DragTargetControl>{

  late var fields = <Field>[
    DragTargetBuilderField(this, 'builder', isRequired : () => true),
    EnumField(this, 'hitTestBehavior', choices : HitTestBehavior.values , defaultValue : HitTestBehavior.translucent, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => DragTarget;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return DragTarget<Widget>(
      builder : fields[0].value,
      hitTestBehavior : fields[1].value,
    );
  }
}