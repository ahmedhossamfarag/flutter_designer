import 'package:flutter/cupertino.dart';
import 'base.dart';
import 'field.dart';


class CupertinoActionSheetControl extends Control{
  CupertinoActionSheetControl({super.key});

  @override
  State<StatefulWidget> createState() => _CupertinoActionSheetControl();
}

class _CupertinoActionSheetControl extends DraggableControlState<CupertinoActionSheetControl>{

  late var fields = <Field>[
    WidgetField(this, 'title' ),
    WidgetField(this, 'message' ),
    ListWidgetField(this, 'actions' ),
    WidgetField(this, 'cancelButton' )
  ];

  @override
  Type get type => CupertinoActionSheet;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return CupertinoActionSheet(
      title : fields[0].value,
      message : fields[1].value,
      actions : fields[2].value,
      cancelButton : fields[3].value,
    );
  }
}

class CupertinoActivityIndicatorControl extends Control{
  CupertinoActivityIndicatorControl({super.key});

  @override
  State<StatefulWidget> createState() => _CupertinoActivityIndicatorControl();
}

class _CupertinoActivityIndicatorControl extends DraggableControlState<CupertinoActivityIndicatorControl>{

  late var fields = <Field>[
    ColorField(this, 'color' ),
    BoolField(this, 'animating' , defaultValue : true, isDefault : true, isNullable : false),
    DoubleField(this, 'radius' , defaultValue : 10, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => CupertinoActivityIndicator;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return CupertinoActivityIndicator(
      color : fields[0].value,
      animating : fields[1].value,
      radius : fields[2].value,
    );
  }
}

class CupertinoAlertDialogControl extends Control{
  CupertinoAlertDialogControl({super.key});

  @override
  State<StatefulWidget> createState() => _CupertinoAlertDialogControl();
}

class _CupertinoAlertDialogControl extends DraggableControlState<CupertinoAlertDialogControl>{

  late var fields = <Field>[
  WidgetField(this, 'title' ),
  WidgetField(this, 'content' ),
  ListWidgetField(this, 'actions' , defaultValue : [], isDefault : true, isNullable : false),
  DurationField(this, 'insetAnimationDuration' , defaultValue : const Duration(milliseconds:100), isDefault : true, isNullable : false),
  CurveField(this, 'insetAnimationCurve' , defaultValue : Curves.decelerate, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => CupertinoAlertDialog;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
  return CupertinoAlertDialog(
  title : fields[0].value,
  content : fields[1].value,
  actions : fields[2].value,
  insetAnimationDuration : fields[3].value,
  insetAnimationCurve : fields[4].value,
  );
  }
}

class CupertinoButtonControl extends Control{
  CupertinoButtonControl({super.key});

  @override
  State<StatefulWidget> createState() => _CupertinoButtonControl();
}

class _CupertinoButtonControl extends ControlState<CupertinoButtonControl>{

  late var fields = <Field>[
    WidgetField(this, 'child' , isRequired : () => true),
    EdgeInsetsField(this, 'padding' ),
    ColorField(this, 'color' ),
    ColorField(this, 'disabledColor' , defaultValue : CupertinoColors.quaternarySystemFill, isDefault : true, isNullable : false),
    DoubleField(this, 'minSize' , defaultValue : kMinInteractiveDimensionCupertino, isDefault : true),
    DoubleField(this, 'pressedOpacity' , defaultValue : 0.4, isDefault : true),
    BorderRadiusGeometryField(this, 'borderRadius' , defaultValue : const BorderRadius.all(Radius.circular(8.0)), isDefault : true),
    AlignmentField(this, 'alignment' , defaultValue : Alignment.center, isDefault : true, isNullable : false),
    ClosureField<VoidCallback>(this, 'onPressed' , isRequired : () => true, defaultValue: (){}, defaultString: '(){}'),
  ];

  @override
  Type get type => CupertinoButton;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return CupertinoButton(
      child : fields[0].value,
      padding : fields[1].value,
      color : fields[2].value,
      disabledColor : fields[3].value,
      minSize : fields[4].value,
      pressedOpacity : fields[5].value,
      borderRadius : fields[6].value,
      alignment : fields[7].value,
      onPressed : fields[8].value,
    );
  }
}

class CupertinoContextMenuControl extends Control{
  CupertinoContextMenuControl({super.key});

  @override
  State<StatefulWidget> createState() => _CupertinoContextMenuControl();
}

class _CupertinoContextMenuControl extends DraggableControlState<CupertinoContextMenuControl>{

  late var fields = <Field>[
    ListWidgetField(this, 'actions' , isNullable : false, defaultValue : [], isRequired : () => true),
    WidgetField(this, 'child' , isRequired : () => true),
  ];

  @override
  Type get type => CupertinoContextMenu;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return CupertinoContextMenu(
      actions : fields[0].value,
      child : fields[1].value,
    );
  }
}

class CupertinoDatePickerControl extends Control{
  CupertinoDatePickerControl({super.key});

  @override
  State<StatefulWidget> createState() => _CupertinoDatePickerControl();
}

class _CupertinoDatePickerControl extends DraggableControlState<CupertinoDatePickerControl>{

  late var fields = <Field>[
    EnumField(this, 'mode', choices : CupertinoDatePickerMode.values , defaultValue : CupertinoDatePickerMode.dateAndTime, isDefault : true, isNullable : false),
    ClosureField<ValueChanged<DateTime>>(this, 'onDateTimeChanged' , isNullable : false, defaultValue : (dateTime){}, defaultString: '(dateTime){}', isRequired : () => true),
    DateTimeField(this, 'initialDateTime' ),
    DateTimeField(this, 'minimumDate' ),
    DateTimeField(this, 'maximumDate' ),
    IntField(this, 'minimumYear' , defaultValue : 1, isDefault : true, isNullable : false),
    IntField(this, 'maximumYear' ),
    IntField(this, 'minuteInterval' , defaultValue : 1, isDefault : true, isNullable : false),
    BoolField(this, 'use24hFormat' , defaultValue : false, isDefault : true, isNullable : false),
    EnumField(this, 'dateOrder', choices : DatePickerDateOrder.values ),
    ColorField(this, 'backgroundColor' ),
  ];

  @override
  Type get type => CupertinoDatePicker;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return CupertinoDatePicker(
      onDateTimeChanged : fields[1].value,
      initialDateTime : fields[2].value,
      minimumDate : fields[3].value,
      maximumDate : fields[4].value,
      minimumYear : fields[5].value,
      maximumYear : fields[6].value,
      minuteInterval : fields[7].value,
      use24hFormat : fields[8].value,
      dateOrder : fields[9].value,
      backgroundColor : fields[10].value,
    );
  }
}
