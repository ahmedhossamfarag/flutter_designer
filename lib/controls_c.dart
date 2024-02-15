import 'package:flutter/material.dart';
import 'base.dart';
import 'field.dart';

class CenterControl extends Control{
  CenterControl({super.key});

  @override
  State<StatefulWidget> createState() => _CenterControl();
}

class _CenterControl extends ControlState<CenterControl>{

  late var fields = <Field>[
    DoubleField(this, 'widthFactor' ),
    DoubleField(this, 'heightFactor' ),
    WidgetField(this, 'child' ),
  ];

  @override
  Type get type => Center;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Center(
      widthFactor : fields[0].value,
      heightFactor : fields[1].value,
      child : fields[2].value,
    );
  }
}

class ColoredBoxControl extends Control{
  ColoredBoxControl({super.key});

  @override
  State<StatefulWidget> createState() => _ColoredBoxControl();
}

class _ColoredBoxControl extends ControlState<ColoredBoxControl>{

  late var fields = <Field>[
    ColorField(this, 'color' , isNullable : false, defaultValue: Colors.white),
    WidgetField(this, 'child' ),
  ];

  @override
  Type get type => ColoredBox;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return ColoredBox(
      color : fields[0].value,
      child : fields[1].value,
    );
  }
}

class ColumnControl extends Control{
  ColumnControl({super.key});

  @override
  State<StatefulWidget> createState() => _ColumnControl();
}

class _ColumnControl extends ControlState<ColumnControl>{

  late var fields = <Field>[
    EnumField(this, 'mainAxisAlignment', choices : MainAxisAlignment.values , defaultValue : MainAxisAlignment.start, isDefault : true, isNullable : false),
    EnumField(this, 'mainAxisSize', choices : MainAxisSize.values , defaultValue : MainAxisSize.max, isDefault : true, isNullable : false),
    EnumField(this, 'crossAxisAlignment', choices : CrossAxisAlignment.values , defaultValue : CrossAxisAlignment.center, isDefault : true, isNullable : false),
    EnumField(this, 'textDirection', choices : TextDirection.values ),
    EnumField(this, 'verticalDirection', choices : VerticalDirection.values , defaultValue : VerticalDirection.down, isDefault : true),
    EnumField(this, 'textBaseline', choices : TextBaseline.values ),
    ListWidgetField(this, 'children' , isNullable: false, defaultValue : [], isDefault : true),
  ];

  @override
  Type get type => Column;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Column(
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

class CardControl extends Control{
  CardControl({super.key});

  @override
  State<StatefulWidget> createState() => _CardControl();
}

class _CardControl extends ControlState<CardControl>{

  late var fields = <Field>[
    ColorField(this, 'color' ),
    ColorField(this, 'shadowColor' ),
    ColorField(this, 'surfaceTintColor' ),
    DoubleField(this, 'elevation' ),
    ShapeBorderField(this, 'shape' ),
    BoolField(this, 'borderOnForeground' , defaultValue : true, isDefault : true),
    EdgeInsetsField(this, 'margin' ),
    EnumField(this, 'clipBehavior', choices : Clip.values ),
    WidgetField(this, 'child' ),
    BoolField(this, 'semanticContainer' , defaultValue : true, isDefault : true),
  ];

  @override
  Type get type => Card;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Card(
      color : fields[0].value,
      shadowColor : fields[1].value,
      surfaceTintColor : fields[2].value,
      elevation : fields[3].value,
      shape : fields[4].value,
      borderOnForeground : fields[5].value,
      margin : fields[6].value,
      clipBehavior : fields[7].value,
      child : fields[8].value,
      semanticContainer : fields[9].value,
    );
  }
}

class CheckboxControl extends Control{
  CheckboxControl({super.key});

  @override
  State<StatefulWidget> createState() => _CheckboxControl();
}

class _CheckboxControl extends DraggableControlState<CheckboxControl>{

  late var fields = <Field>[
    BoolField(this, 'value' , constrain: (v) => fields[1].value == true || v != null),
    BoolField(this, 'tristate' , defaultValue : true, isNullable: false , isRequired: () => fields[0].value == null , constrain: (v) => fields[0].value != null || v == true),
    ColorField(this, 'activeColor' ),
    ColorField(this, 'checkColor' ),
    ColorField(this, 'focusColor' ),
    ColorField(this, 'hoverColor' ),
    DoubleField(this, 'splashRadius' ),
    EnumField(this, 'materialTapTargetSize', choices : MaterialTapTargetSize.values ),
    BoolField(this, 'autofocus' , defaultValue : false, isDefault : true),
    ShapeBorderField(this, 'shape' ),
    BorderSideField(this, 'side' ),
    ClosureField<ValueChanged<bool?>>(this, 'onChange', defaultValue: (bool? b){}, defaultString: '(bool? b){}', isRequired: () => true)
  ];

  @override
  Type get type => Checkbox;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return Checkbox(
      value : fields[0].value,
      tristate : fields[1].value,
      activeColor : fields[2].value,
      checkColor : fields[3].value,
      focusColor : fields[4].value,
      hoverColor : fields[5].value,
      splashRadius : fields[6].value,
      materialTapTargetSize : fields[7].value,
      autofocus : fields[8].value,
      shape : fields[9].value,
      side : fields[10].value,
      onChanged: fields[11].value,
    );
  }
}

class ContainerControl extends Control{
  ContainerControl({super.key});

  @override
  State<StatefulWidget> createState() => _ContainerControl();
}

class _ContainerControl extends ControlState<ContainerControl>{

  late var fields = <Field>[
    AlignmentField(this, 'alignment' ),
    EdgeInsetsField(this, 'padding' ),
    ColorField(this, 'color', constrain: (v) => fields[3].value == null),
    BoxDecorationField(this, 'decoration' ,  constrain: (v) => fields[2].value == null),
    BoxDecorationField(this, 'foregroundDecoration' ),
    DoubleField(this, 'width' ),
    DoubleField(this, 'height' ),
    BoxConstraintsField(this, 'constraints' ),
    EdgeInsetsField(this, 'margin' ),
    AlignmentField(this, 'transformAlignment' ),
    WidgetField(this, 'child' ),
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.none, isDefault : true, isNullable : false),
  ];

  @override
  Type get type => Container;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Container(
      alignment : fields[0].value,
      padding : fields[1].value,
      color : fields[2].value,
      decoration : fields[3].value,
      foregroundDecoration : fields[4].value,
      width : fields[5].value,
      height : fields[6].value,
      constraints : fields[7].value,
      margin : fields[8].value,
      transformAlignment : fields[9].value,
      child : fields[10].value,
      clipBehavior : fields[11].value,
    );
  }
}

class ChipControl extends Control{
  ChipControl({super.key});

  @override
  State<StatefulWidget> createState() => _ChipControl();
}

class _ChipControl extends ControlState<ChipControl>{

  late var fields = <Field>[
    WidgetField(this, 'avatar' ),
    WidgetField(this, 'label' , isRequired : () => true),
    TextStyleField(this, 'labelStyle' ),
    EdgeInsetsField(this, 'labelPadding' ),
    WidgetField(this, 'deleteIcon' ),
    ColorField(this, 'deleteIconColor' ),
    StringField(this, 'deleteButtonTooltipMessage' ),
    BorderSideField(this, 'side' ),
    ShapeBorderField(this, 'shape' ),
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.none, isDefault : true, isNullable : false),
    BoolField(this, 'autofocus' , defaultValue : false, isDefault : true, isNullable : false),
    ColorField(this, 'backgroundColor' ),
    EdgeInsetsField(this, 'padding' ),
    VisualDensityField(this, 'visualDensity' ),
    DoubleField(this, 'elevation' ),
    ColorField(this, 'shadowColor' ),
    ColorField(this, 'surfaceTintColor' ),
    IconThemeDataField(this, 'iconTheme' )
  ];

  @override
  Type get type => Chip;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Chip(
      avatar : fields[0].value,
      label : fields[1].value,
      labelStyle : fields[2].value,
      labelPadding : fields[3].value,
      deleteIcon : fields[4].value,
      deleteIconColor : fields[5].value,
      deleteButtonTooltipMessage : fields[6].value,
      side : fields[7].value,
      shape : fields[8].value,
      clipBehavior : fields[9].value,
      autofocus : fields[10].value,
      backgroundColor : fields[11].value,
      padding : fields[12].value,
      visualDensity : fields[13].value,
      elevation : fields[14].value,
      shadowColor : fields[15].value,
      surfaceTintColor : fields[16].value,
      iconTheme : fields[17].value,
    );
  }
}

class CircularProgressIndicatorControl extends Control{
  CircularProgressIndicatorControl({super.key});

  @override
  State<StatefulWidget> createState() => _CircularProgressIndicatorControl();
}

class _CircularProgressIndicatorControl extends DraggableControlState<CircularProgressIndicatorControl>{

  late var fields = <Field>[
    DoubleField(this, 'value' ),
    ColorField(this, 'backgroundColor' ),
    ColorField(this, 'color' ),
    DoubleField(this, 'strokeWidth' , defaultValue : 4.0, isDefault : true, isNullable : false),
    StringField(this, 'semanticsLabel' ),
    StringField(this, 'semanticsValue' )
  ];

  @override
  Type get type => CircularProgressIndicator;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return CircularProgressIndicator(
      value : fields[0].value,
      backgroundColor : fields[1].value,
      color : fields[2].value,
      strokeWidth : fields[3].value,
      semanticsLabel : fields[4].value,
      semanticsValue : fields[5].value,
    );
  }
}

class ClipOvalControl extends Control{
  ClipOvalControl({super.key});

  @override
  State<StatefulWidget> createState() => _ClipOvalControl();
}

class _ClipOvalControl extends ControlState<ClipOvalControl>{

  late var fields = <Field>[
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.antiAlias, isDefault : true, isNullable : false),
    WidgetField(this, 'child' )
  ];

  @override
  Type get type => ClipOval;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return ClipOval(
      clipBehavior : fields[0].value,
      child : fields[1].value,
    );
  }
}
