
import 'package:flutter/material.dart';
import 'base.dart';
import 'field.dart';

class AlignControl extends Control{
  AlignControl({super.key});

  @override
  State<StatefulWidget> createState() => _AlignControl();
}

class _AlignControl extends ControlState<AlignControl>{

  late var fields = <Field>[
    AlignmentField(this, 'alignment' , defaultValue : Alignment.center, isDefault : true, isNullable : false),
    DoubleField(this, 'widthFactor' ),
    DoubleField(this, 'heightFactor' ),
    WidgetField(this, 'child' ),
  ];

  @override
  Type get type => Align;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return Align(
      alignment : fields[0].value,
      widthFactor : fields[1].value,
      heightFactor : fields[2].value,
      child : fields[3].value,
    );
  }
}


class AlertDialogControl extends Control{
  AlertDialogControl({super.key});

  @override
  State<StatefulWidget> createState() => _AlertDialogControl();
}

class _AlertDialogControl extends DraggableControlState<AlertDialogControl>{

  late var fields = <Field>[
    WidgetField(this, 'icon' ),
    EdgeInsetsField(this, 'iconPadding' ),
    ColorField(this, 'iconColor' ),
    WidgetField(this, 'title' ),
    EdgeInsetsField(this, 'titlePadding' ),
    TextStyleField(this, 'titleTextStyle' ),
    WidgetField(this, 'content' ),
    EdgeInsetsField(this, 'contentPadding' ),
    TextStyleField(this, 'contentTextStyle' ),
    ListWidgetField(this, 'actions' ),
    EdgeInsetsField(this, 'actionsPadding' ),
    EnumField(this, 'actionsAlignment', choices : MainAxisAlignment.values ),
    EnumField(this, 'actionsOverflowAlignment', choices : OverflowBarAlignment.values ),
    EnumField(this, 'actionsOverflowDirection', choices : VerticalDirection.values ),
    DoubleField(this, 'actionsOverflowButtonSpacing' ),
    EdgeInsetsField(this, 'buttonPadding' ),
    ColorField(this, 'backgroundColor' ),
    DoubleField(this, 'elevation' ),
    StringField(this, 'semanticLabel' ),
    EdgeInsetsField(this, 'insetPadding' , defaultValue : const  EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0), isDefault : true, isNullable : false),
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.none, isDefault : true, isNullable : false),
    ShapeBorderField(this, 'shape' ),
    AlignmentField(this, 'alignment' ),
    BoolField(this, 'scrollable' , defaultValue : false, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => AlertDialog;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return AlertDialog(
      icon : fields[0].value,
      iconPadding : fields[1].value,
      iconColor : fields[2].value,
      title : fields[3].value,
      titlePadding : fields[4].value,
      titleTextStyle : fields[5].value,
      content : fields[6].value,
      contentPadding : fields[7].value,
      contentTextStyle : fields[8].value,
      actions : fields[9].value,
      actionsPadding : fields[10].value,
      actionsAlignment : fields[11].value,
      actionsOverflowAlignment : fields[12].value,
      actionsOverflowDirection : fields[13].value,
      actionsOverflowButtonSpacing : fields[14].value,
      buttonPadding : fields[15].value,
      backgroundColor : fields[16].value,
      elevation : fields[17].value,
      semanticLabel : fields[18].value,
      insetPadding : fields[19].value,
      clipBehavior : fields[20].value,
      shape : fields[21].value,
      alignment : fields[22].value,
      scrollable : fields[23].value,
    );
  }
}

class AbsorbPointerControl extends Control{
  AbsorbPointerControl({super.key});

  @override
  State<StatefulWidget> createState() => _AbsorbPointerControl();
}

class _AbsorbPointerControl extends ControlState<AbsorbPointerControl>{

  late var fields = <Field>[
    BoolField(this, 'absorbing' , defaultValue : true, isDefault : true, isNullable : false),
    WidgetField(this, 'child' )
  ];

  @override
  Type get type => AbsorbPointer;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AbsorbPointer(
      absorbing : fields[0].value,
      child : fields[1].value,
    );
  }
}
class AnimatedAlignControl extends Control{
  AnimatedAlignControl({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedAlignControl();
}

class _AnimatedAlignControl extends ControlState<AnimatedAlignControl>{

  late var fields = <Field>[
    AlignmentField(this, 'alignment' , isNullable : false, defaultValue : Alignment.center, isRequired : () => true),
    WidgetField(this, 'child' ),
    DoubleField(this, 'heightFactor' ),
    DoubleField(this, 'widthFactor' ),
    CurveField(this, 'curve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    DurationField(this, 'duration' , isNullable : false, defaultValue : const Duration(seconds: 1), defaultString: 'const Duration(seconds: 1)', isRequired : () => true),
    ClosureField<VoidCallback>(this, 'onEnd' , defaultValue: (){}, defaultString: '() {}'),
  ];

  @override
  Type get type => AnimatedAlign;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AnimatedAlign(
      alignment : fields[0].value,
      child : fields[1].value,
      heightFactor : fields[2].value,
      widthFactor : fields[3].value,
      curve : fields[4].value,
      duration : fields[5].value,
      onEnd : fields[6].value,
    );
  }
}

class AnimatedContainerControl extends Control{
  AnimatedContainerControl({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedContainerControl();
}

class _AnimatedContainerControl extends ControlState<AnimatedContainerControl>{

  late var fields = <Field>[
    AlignmentField(this, 'alignment' ),
    EdgeInsetsField(this, 'padding' ),
    ColorField(this, 'color' ),
    BoxDecorationField(this, 'decoration' ),
    BoxDecorationField(this, 'foregroundDecoration' ),
    DoubleField(this, 'width' ),
    DoubleField(this, 'height' ),
    BoxConstraintsField(this, 'constraints' ),
    EdgeInsetsField(this, 'margin' ),
    AlignmentField(this, 'transformAlignment' ),
    WidgetField(this, 'child' ),
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.none, isDefault : true, isNullable : false),
    CurveField(this, 'curve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    BoxDecorationField( this, 'duration' , isNullable : false, defaultValue : const BoxDecoration(), isRequired : () => true),
  ];

  @override
  Type get type => AnimatedContainer;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AnimatedContainer(
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
      curve : fields[12].value,
      duration : fields[13].value,
    );
  }
}

class AnimatedCrossFadeControl extends Control{
  AnimatedCrossFadeControl({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedCrossFadeControl();
}

class _AnimatedCrossFadeControl extends ControlState<AnimatedCrossFadeControl>{

  late var fields = <Field>[
    WidgetField(this, 'firstChild' , isRequired : () => true),
    WidgetField(this, 'secondChild' , isRequired : () => true),
    CurveField(this, 'firstCurve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    CurveField(this, 'secondCurve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    CurveField(this, 'sizeCurve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    AlignmentField(this, 'alignment' , defaultValue : Alignment.topCenter, isDefault : true, isNullable : false),
    EnumField(this, 'crossFadeState', choices : CrossFadeState.values , isNullable : false, defaultValue : CrossFadeState.showFirst, isRequired : () => true),
    DurationField(this, 'duration' , isNullable : false, defaultValue : const Duration(seconds: 1), defaultString: 'const Duration(seconds: 1)', isRequired : () => true),
    DurationField(this, 'reverseDuration' ),
    BoolField(this, 'excludeBottomFocus' , defaultValue : true, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => AnimatedCrossFade;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild : fields[0].value,
      secondChild : fields[1].value,
      firstCurve : fields[2].value,
      secondCurve : fields[3].value,
      sizeCurve : fields[4].value,
      alignment : fields[5].value,
      crossFadeState : fields[6].value,
      duration : fields[7].value,
      reverseDuration : fields[8].value,
      excludeBottomFocus : fields[9].value,
    );
  }
}

class AnimatedDefaultTextStyleControl extends Control{
  AnimatedDefaultTextStyleControl({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedDefaultTextStyleControl();
}

class _AnimatedDefaultTextStyleControl extends ControlState<AnimatedDefaultTextStyleControl>{

  late var fields = <Field>[
    WidgetField(this, 'child' , isRequired : () => true),
    TextStyleField(this, 'style' , isNullable : false, defaultValue : const TextStyle(), isRequired : () => true),
    EnumField(this, 'textAlign', choices : TextAlign.values ),
    BoolField(this, 'softWrap' , defaultValue : true, isDefault : true, isNullable : false),
    EnumField(this, 'overflow', choices : TextOverflow.values , defaultValue : TextOverflow.clip, isDefault : true, isNullable : false),
    IntField(this, 'maxLines' ),
    EnumField(this, 'textWidthBasis', choices : TextWidthBasis.values , defaultValue : TextWidthBasis.parent, isDefault : true, isNullable : false),
    CurveField(this, 'curve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    DurationField(this, 'duration' , isNullable : false, defaultValue : const Duration(seconds: 1), defaultString: 'const Duration(seconds: 1)', isRequired : () => true),
  ];

  @override
  Type get type => AnimatedDefaultTextStyle;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      child : fields[0].value,
      style : fields[1].value,
      textAlign : fields[2].value,
      softWrap : fields[3].value,
      overflow : fields[4].value,
      maxLines : fields[5].value,
      textWidthBasis : fields[6].value,
      curve : fields[7].value,
      duration : fields[8].value,
    );
  }
}

class AnimatedOpacityControl extends Control{
  AnimatedOpacityControl({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedOpacityControl();
}

class _AnimatedOpacityControl extends ControlState<AnimatedOpacityControl>{

  late var fields = <Field>[
    WidgetField(this, 'child' ),
    DoubleField(this, 'opacity' , isNullable : false, defaultValue : 1, isRequired : () => true, constrain: (v) => v == null || v <= 1),
    CurveField(this, 'curve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    DurationField(this, 'duration' , isNullable : false, defaultValue : const Duration(seconds: 1), defaultString: 'const Duration(seconds: 1)', isRequired : () => true),
    BoolField(this, 'alwaysIncludeSemantics' , defaultValue : false, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => AnimatedOpacity;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AnimatedOpacity(
      child : fields[0].value,
      opacity : fields[1].value,
      curve : fields[2].value,
      duration : fields[3].value,
      alwaysIncludeSemantics : fields[4].value,
    );
  }
}

class AnimatedPositionedControl extends Control{
  AnimatedPositionedControl({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedPositionedControl();
}

class _AnimatedPositionedControl extends ControlState<AnimatedPositionedControl>{

  late var fields = <Field>[
    WidgetField(this, 'child' ,  isRequired : () => true),
    DoubleField(this, 'left' ),
    DoubleField(this, 'top' ),
    DoubleField(this, 'right' ),
    DoubleField(this, 'bottom' ),
    DoubleField(this, 'width' ),
    DoubleField(this, 'height' ),
    CurveField(this, 'curve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    DurationField(this, 'duration' , isNullable : false, defaultValue : const Duration(seconds: 1), defaultString: 'const Duration(seconds: 1)', isRequired : () => true),
  ];

  @override
  Type get type => AnimatedPositioned;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AnimatedPositioned(
      child : fields[0].value,
      left : fields[1].value,
      top : fields[2].value,
      right : fields[3].value,
      bottom : fields[4].value,
      width : fields[5].value,
      height : fields[6].value,
      curve : fields[7].value,
      duration : fields[8].value,
    );
  }
}

class AnimatedSizeControl extends Control{
  AnimatedSizeControl({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedSizeControl();
}

class _AnimatedSizeControl extends ControlState<AnimatedSizeControl>{

  late var fields = <Field>[
    WidgetField(this, 'child' ),
    AlignmentField(this, 'alignment' , defaultValue : Alignment.center, isDefault : true, isNullable : false),
    CurveField(this, 'curve' , defaultValue : Curves.linear, isDefault : true, isNullable : false),
    DurationField(this, 'duration' , isNullable : false, defaultValue : const Duration(seconds: 1), defaultString: 'const Duration(seconds: 1)', isRequired : () => true),
    DurationField(this, 'reverseDuration' ),
    EnumField(this, 'clipBehavior', choices : Clip.values , defaultValue : Clip.hardEdge, isDefault : true, isNullable : false)
  ];

  @override
  Type get type => AnimatedSize;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AnimatedSize(
      child : fields[0].value,
      alignment : fields[1].value,
      curve : fields[2].value,
      duration : fields[3].value,
      reverseDuration : fields[4].value,
      clipBehavior : fields[5].value,
    );
  }
}

class AppBarControl extends Control{
  AppBarControl({super.key});

  @override
  State<StatefulWidget> createState() => _AppBarControl();
}

class _AppBarControl extends DraggableControlState<AppBarControl>{

  late var fields = <Field>[
    WidgetField(this, 'leading' ),
    BoolField(this, 'automaticallyImplyLeading' , defaultValue : true, isDefault : true, isNullable : false),
    WidgetField(this, 'title' ),
    ListWidgetField(this, 'actions' ),
    WidgetField(this, 'flexibleSpace' ),
    PreferredSizeField(this, 'bottom' ,),
    DoubleField(this, 'elevation' ),
    DoubleField(this, 'scrolledUnderElevation' ),
    ColorField(this, 'shadowColor' ),
    ColorField(this, 'surfaceTintColor' ),
    ShapeBorderField(this, 'shape' ),
    ColorField(this, 'backgroundColor' ),
    ColorField(this, 'foregroundColor' ),
    IconThemeDataField(this, 'iconTheme' ),
    IconThemeDataField(this, 'actionsIconTheme' ),
    BoolField(this, 'primary' , defaultValue : true, isDefault : true, isNullable : false),
    BoolField(this, 'centerTitle' ),
    BoolField(this, 'excludeHeaderSemantics' , defaultValue : false, isDefault : true, isNullable : false),
    DoubleField(this, 'titleSpacing' ),
    DoubleField(this, 'toolbarOpacity' , defaultValue : 1.0, isDefault : true, isNullable : false),
    DoubleField(this, 'bottomOpacity' , defaultValue : 1.0, isDefault : true, isNullable : false),
    DoubleField(this, 'toolbarHeight' ),
    DoubleField(this, 'leadingWidth' ),
    TextStyleField(this, 'toolbarTextStyle' ),
    TextStyleField(this, 'titleTextStyle' ),
    SystemUiOverlayStyleField(this, 'systemOverlayStyle' ),
  ];

  @override
  Type get type => AppBar;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return AppBar(
      leading : fields[0].value,
      automaticallyImplyLeading : fields[1].value,
      title : fields[2].value,
      actions : fields[3].value,
      flexibleSpace : fields[4].value,
      bottom : fields[5].value,
      elevation : fields[6].value,
      scrolledUnderElevation : fields[7].value,
      shadowColor : fields[8].value,
      surfaceTintColor : fields[9].value,
      shape : fields[10].value,
      backgroundColor : fields[11].value,
      foregroundColor : fields[12].value,
      iconTheme : fields[13].value,
      actionsIconTheme : fields[14].value,
      primary : fields[15].value,
      centerTitle : fields[16].value,
      excludeHeaderSemantics : fields[17].value,
      titleSpacing : fields[18].value,
      toolbarOpacity : fields[19].value,
      bottomOpacity : fields[20].value,
      toolbarHeight : fields[21].value,
      leadingWidth : fields[22].value,
      toolbarTextStyle : fields[23].value,
      titleTextStyle : fields[24].value,
      systemOverlayStyle : fields[25].value,
    );
  }
}

class AspectRatioControl extends Control{
  AspectRatioControl({super.key});

  @override
  State<StatefulWidget> createState() => _AspectRatioControl();
}

class _AspectRatioControl extends ControlState<AspectRatioControl>{

  late var fields = <Field>[
    DoubleField(this, 'aspectRatio' , isNullable : false, defaultValue : 1, isRequired : () => true),
    WidgetField(this, 'child' )
  ];

  @override
  Type get type => AspectRatio;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return AspectRatio(
      aspectRatio : fields[0].value,
      child : fields[1].value,
    );
  }
}

