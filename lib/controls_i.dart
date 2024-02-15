import 'package:flutter/material.dart';
import 'base.dart';
import 'field.dart';


class IconControl extends Control{
  IconControl({super.key});

  @override
  State<StatefulWidget> createState() => _IconControl();
}

class _IconControl extends DraggableControlState<IconControl>{

  late var fields = <Field>[
    IconDataField(this, 'icon', isNamed: false, defaultValue: Icons.add ),
    DoubleField(this, 'size' ),
    ColorField(this, 'color' ),
    ListBoxShadowField(this, 'shadows' ),
    StringField(this, 'semanticLabel' ),
    EnumField(this, 'textDirection', choices : TextDirection.values )
  ];

  @override
  Type get type => Icon;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return Icon(
      fields[0].value,
      size : fields[1].value,
      color : fields[2].value,
      shadows : fields[3].value,
      semanticLabel : fields[4].value,
      textDirection : fields[5].value,
    );
  }
}

class IconButtonControl extends Control{
  IconButtonControl({super.key});

  @override
  State<StatefulWidget> createState() => _IconButtonControl();
}

class _IconButtonControl extends ControlState<IconButtonControl>{

  late var fields = <Field>[
    DoubleField(this, 'iconSize' ),
    VisualDensityField(this, 'visualDensity' ),
    EdgeInsetsField(this, 'padding', isNullable: false, defaultValue: const EdgeInsets.all(8.0), isDefault: true ),
    AlignmentField(this, 'alignment', isNullable: false, defaultValue: Alignment.center, isDefault: true),
    DoubleField(this, 'splashRadius' ),
    ColorField(this, 'color' ),
    ColorField(this, 'focusColor' ),
    ColorField(this, 'hoverColor' ),
    ColorField(this, 'highlightColor' ),
    ColorField(this, 'splashColor' ),
    ColorField(this, 'disabledColor' ),
    ClosureField<VoidCallback>(this, 'onPressed' , isRequired : () => true),
    MouseCursorField(this, 'mouseCursor' ),
    BoolField(this, 'autofocus' , defaultValue : false, isDefault : true, isNullable : false),
    StringField(this, 'tooltip' ),
    BoolField(this, 'enableFeedback', isNullable: false, defaultValue: true, isDefault: true ),
    BoxConstraintsField(this, 'constraints' ),
    BoolField(this, 'isSelected' ),
    WidgetField(this, 'selectedIcon' ),
    WidgetField(this, 'icon' , isRequired : () => true)
  ];

  @override
  Type get type => IconButton;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return IconButton(
      iconSize : fields[0].value,
      visualDensity : fields[1].value,
      padding : fields[2].value,
      alignment : fields[3].value,
      splashRadius : fields[4].value,
      color : fields[5].value,
      focusColor : fields[6].value,
      hoverColor : fields[7].value,
      highlightColor : fields[8].value,
      splashColor : fields[9].value,
      disabledColor : fields[10].value,
      onPressed : fields[11].value,
      mouseCursor : fields[12].value,
      autofocus : fields[13].value,
      tooltip : fields[14].value,
      enableFeedback : fields[15].value,
      constraints : fields[16].value,
      isSelected : fields[17].value,
      selectedIcon : fields[18].value,
      icon : fields[19].value,
    );
  }
}

/*
import 'package:flutter/material.dart' hide ColorProperty;
import 'package:flutter_designer/property.dart';
import 'controls.dart';

//  //

class IconControl extends Control{
  const IconControl({super.key, super.parent});

  @override
  State<StatefulWidget> createState() => _IconControl();
}

class _IconControl extends ControlState{


  int? icon;
  double? size;
  Color? color;
  String? semanticLabel;
  TextDirection? textDirection;
  List<Shadow>? shadows;

  @override
  Widget buildWidget(){
    return Icon(
      icon == null ? Icons.label : IconData(icon!, fontFamily: 'MaterialIcons'),
      size : size,
      color : color,
      semanticLabel : semanticLabel,
      textDirection : textDirection,
      shadows : shadows,
    );
  }

  @override
  List<Widget> getProperties(){
    return [
      IntProperty('Icon', icon, (value){setState((){icon = value;});}),
      DoubleProperty('Size', size, (value){setState((){size = value;});}),
      ColorProperty('Color', color, (value){setState((){color = value;});}),
      StringProperty('Semantic Label', semanticLabel, (value){setState((){semanticLabel = value;});}),
      EnumProperty('Text Direction', textDirection, TextDirection.values, (value){setState((){textDirection = value;});}),
      StringProperty('Shadows', '', (value){}),
    ];
  }
}

 */