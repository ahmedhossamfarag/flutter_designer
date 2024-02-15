import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'base.dart';
import 'field.dart';

class TextControl extends Control{
  TextControl({super.key});

  @override
  State<StatefulWidget> createState() => _TextControl();
}

class _TextControl extends DraggableControlState<TextControl>{

  late var fields = <Field>[
    StringField(this, 'data' , isNullable : false, isNamed: false, defaultValue: 'data'),
    TextStyleField(this, 'style' ),
    EnumField(this, 'textAlign', choices : TextAlign.values ),
    EnumField(this, 'textDirection', choices : TextDirection.values ),
    BoolField(this, 'softWrap' ),
    EnumField(this, 'overflow', choices : TextOverflow.values ),
    DoubleField(this, 'textScaleFactor' ),
    IntField(this, 'maxLines' ),
    StringField(this, 'semanticsLabel' ),
    EnumField(this, 'textWidthBasis', choices : TextWidthBasis.values ),
    TextHeightBehaviorField(this, 'textHeightBehavior' ),
    ColorField(this, 'selectionColor' ),
  ];

  @override
  Type get type => Text;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return Text(
      fields[0].value,
      style : fields[1].value,
      textAlign : fields[2].value,
      textDirection : fields[3].value,
      softWrap : fields[4].value,
      overflow : fields[5].value,
      textScaleFactor : fields[6].value,
      maxLines : fields[7].value,
      semanticsLabel : fields[8].value,
      textWidthBasis : fields[9].value,
      textHeightBehavior : fields[10].value,
      selectionColor : fields[11].value,
    );
  }
}

class TextButtonControl extends Control{
  TextButtonControl({super.key});

  @override
  State<StatefulWidget> createState() => _TextButtonControl();
}

class _TextButtonControl extends ControlState<TextButtonControl>{

  late var fields = <Field>[
    ClosureField<VoidCallback>(this, 'onPressed' , isRequired : () => true),
    BoolField(this, 'autofocus' , defaultValue : false, isDefault : true, isNullable : false),
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.none, isDefault : true, isNullable : false),
    WidgetField(this, 'child' , isRequired : () => true)
  ];

  @override
  Type get type => TextButton;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return TextButton(
      onPressed : fields[0].value,
      autofocus : fields[1].value,
      clipBehavior : fields[2].value,
      child : fields[3].value,
    );
  }
}
class TextFieldControl extends Control{
  TextFieldControl({super.key});

  @override
  State<StatefulWidget> createState() => _TextFieldControl();
}

class _TextFieldControl extends DraggableControlState<TextFieldControl>{

  late var fields = <Field>[
    FocusNodeField(this, 'focusNode' ),
    EnumField(this, 'textInputAction', choices : TextInputAction.values ),
    EnumField(this, 'textCapitalization', choices : TextCapitalization.values , defaultValue : TextCapitalization.none, isDefault : true, isNullable : false),
    TextStyleField(this, 'style' ),
    EnumField(this, 'textAlign', choices : TextAlign.values , defaultValue : TextAlign.start, isDefault : true, isNullable : false),
    EnumField(this, 'textDirection', choices : TextDirection.values ),
    BoolField(this, 'readOnly' , defaultValue : false, isDefault : true, isNullable : false),
    BoolField(this, 'showCursor' ),
    BoolField(this, 'autofocus' , defaultValue : false, isDefault : true, isNullable : false),
    StringField(this, 'obscuringCharacter' , defaultValue : '•', isDefault : true, isNullable : false),
    BoolField(this, 'obscureText' , defaultValue : false, isDefault : true, isNullable : false),
    BoolField(this, 'autocorrect' , defaultValue : true, isDefault : true, isNullable : false),
    EnumField(this, 'smartDashesType', choices : SmartDashesType.values ),
    EnumField(this, 'smartQuotesType', choices : SmartQuotesType.values ),
    BoolField(this, 'enableSuggestions' , defaultValue : true, isDefault : true, isNullable : false),
    IntField(this, 'maxLines' , defaultValue : 1, isDefault : true),
    IntField(this, 'minLines' ),
    BoolField(this, 'expands' , defaultValue : false, isDefault : true, isNullable : false),
    IntField(this, 'maxLength' ),
    BoolField(this, 'enabled' ),
    DoubleField(this, 'cursorWidth' , defaultValue : 2.0, isDefault : true, isNullable : false),
    DoubleField(this, 'cursorHeight' ),
    ColorField(this, 'cursorColor' ),
    EnumField(this, 'selectionHeightStyle', choices : BoxHeightStyle.values , defaultValue : BoxHeightStyle.tight, isDefault : true, isNullable : false),
    EnumField(this, 'selectionWidthStyle', choices : BoxWidthStyle.values , defaultValue : BoxWidthStyle.tight, isDefault : true, isNullable : false),
    EdgeInsetsField(this, 'scrollPadding' , defaultValue : const EdgeInsets.all(20.0), isDefault : true, isNullable : false),
    EnumField(this, 'dragStartBehavior', choices : DragStartBehavior.values , defaultValue : DragStartBehavior.start, isDefault : true, isNullable : false),
    BoolField(this, 'enableInteractiveSelection' ),
    MouseCursorField(this, 'mouseCursor' ),
    EnumField(this, 'maxLengthEnforcement', choices : MaxLengthEnforcement.values )
  ];

  @override
  Type get type => TextField;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return TextField(
      focusNode : fields[0].value,
      textInputAction : fields[1].value,
      textCapitalization : fields[2].value,
      style : fields[3].value,
      textAlign : fields[4].value,
      textDirection : fields[5].value,
      readOnly : fields[6].value,
      showCursor : fields[7].value,
      autofocus : fields[8].value,
      obscuringCharacter : fields[9].value,
      obscureText : fields[10].value,
      autocorrect : fields[11].value,
      smartDashesType : fields[12].value,
      smartQuotesType : fields[13].value,
      enableSuggestions : fields[14].value,
      maxLines : fields[15].value,
      minLines : fields[16].value,
      expands : fields[17].value,
      maxLength : fields[18].value,
      enabled : fields[19].value,
      cursorWidth : fields[20].value,
      cursorHeight : fields[21].value,
      cursorColor : fields[22].value,
      selectionHeightStyle : fields[23].value,
      selectionWidthStyle : fields[24].value,
      scrollPadding : fields[25].value,
      dragStartBehavior : fields[26].value,
      enableInteractiveSelection : fields[27].value,
      mouseCursor : fields[28].value,
      maxLengthEnforcement : fields[29].value,
    );
  }
}
/*
import 'package:flutter/material.dart' hide ColorProperty;
import 'package:flutter_designer/property.dart';
import 'controls.dart';

class TextControl extends Control{
  const TextControl({super.key, super.parent});

  @override
  State<StatefulWidget> createState() => _TextControl();
}

class _TextControl extends ControlState{


  String? data;
  TextStyle? style;
  StrutStyle? strutStyle;
  TextAlign? textAlign;
  TextDirection? textDirection;
  String? locale;
  bool? softWrap;
  TextOverflow? overflow;
  double? textScaleFactor;
  int? maxLines;
  String? semanticsLabel;
  TextWidthBasis? textWidthBasis;
  TextHeightBehavior? textHeightBehavior;
  Color? selectionColor;

  @override
  Widget buildWidget(){
    return Text(
      data ?? 'Text',
      style : style,
      strutStyle : strutStyle,
      textAlign : textAlign,
      textDirection : textDirection,
      locale : locale == null ? null : Locale(locale!),
      softWrap : softWrap,
      overflow : overflow,
      textScaleFactor : textScaleFactor,
      maxLines : maxLines,
      semanticsLabel : semanticsLabel,
      textWidthBasis : textWidthBasis,
      textHeightBehavior : textHeightBehavior,
      selectionColor : selectionColor,
    );
  }

  @override
  List<Widget> getProperties(){
    return [
      StringProperty('Data', data, (value){setState((){data = value;});}),
      FontProperty('Style', style ?? const TextStyle(), (value){setState((){style = value;});}),
      StrutStyleProperty('Strut Style', strutStyle, (value){setState((){strutStyle = value;});}),
      EnumProperty('Text Align', textAlign, TextAlign.values, (value){setState((){textAlign = value;});}),
      EnumProperty('Text Direction', textDirection, TextDirection.values, (value){setState((){textDirection = value;});}),
      StringProperty('Locale', locale, (value){setState((){locale = value;});}),
      BooleanProperty('Soft Wrap', softWrap, (value){setState((){softWrap = value;});}),
      EnumProperty('Overflow', overflow, TextOverflow.values, (value){setState((){overflow = value;});}),
      DoubleProperty('Text Scale Factor', textScaleFactor, (value){setState((){textScaleFactor = value;});}),
      IntProperty('Max Lines', maxLines, (value){setState((){maxLines = value;});}),
      StringProperty('Semantics Label', semanticsLabel, (value){setState((){semanticsLabel = value;});}),
      EnumProperty('Text Width Basis', textWidthBasis, TextWidthBasis.values, (value){setState((){textWidthBasis = value;});}),
      StringProperty('Text Height Behavior', '', (value){}),
      ColorProperty('Selection Color', selectionColor, (value){setState((){selectionColor = value;});})
    ];
  }
}

 */