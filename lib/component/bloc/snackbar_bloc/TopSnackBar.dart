import 'dart:async';
import 'package:flutter/material.dart';
import '../../ScreenUtils.dart';
import '../../style/elevation.dart';
import 'SnackBarBloc.dart';
import 'TopSnackBarRoute.dart';

typedef TopSnackBarStatusCallBack = void Function(TopSnackBarStatus status);

const String topSnackBarRouteName = '/topSnackBarRoute';

// ignore: must_be_immutable
class TopSnackBar<T extends Object> extends StatefulWidget {
  final BuildContext ?context;
  final String ?title;
  final SnackBarType ?type;
  final Function ?function;
  TopSnackBarStatusCallBack ?onStatusChanged;

  TopSnackBar({Key ?key, this.context, this.title, this.type = SnackBarType.error, this.function}) : super(key: key) {
    onStatusChanged = onStatusChanged ?? (status) {};
  }

  int duration = 4;

  TopSnackBarRoute<T>? _topSnackBarRoute;

  Future<T?> show(BuildContext context) async {
    _topSnackBarRoute = showSnackBar<T>(context: context, topSnackBar: this) as TopSnackBarRoute<T>;

    return Navigator.of(context, rootNavigator: false).push(_topSnackBarRoute!);
  }

  Future<T?> showWithNavigator(NavigatorState navigator, BuildContext context) async {
    _topSnackBarRoute = showSnackBar<T>(context: context, topSnackBar: this) as TopSnackBarRoute<T>;
    return navigator.push(_topSnackBarRoute!);
  }


  Future<T?> dismiss([T? result]) async {
    if (_topSnackBarRoute == null) {
      return null;
    }

    return null;
  }

  /// Checks if the top snack bar is visible
  bool isShowing() => _topSnackBarRoute?.currentStatus == TopSnackBarStatus.showing;

  /// Checks if the top snack bar is dismissed
  bool isDismissed() => _topSnackBarRoute?.currentStatus == TopSnackBarStatus.dismissed;

  @override
  State createState() {
    return _TopSnackBarState<T>();
  }
}

class _TopSnackBarState<K extends Object> extends State<TopSnackBar> with TickerProviderStateMixin {
  FocusScopeNode ?_focusScopeNode;
  FocusAttachment ?_focusAttachment;

  TopSnackBarStatus ?currentStatus;

  GlobalKey backgroundBoxKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _focusScopeNode = FocusScopeNode();
    _focusAttachment = _focusScopeNode!.attach(context);
  }

  @override
  void dispose() {
    _focusScopeNode!.dispose();
    _focusAttachment!.detach();
    super.dispose();
  }

  Widget _buildIcon() {
    if (widget.type == SnackBarType.success) {
      return Container(key: const Key('success_container_icon_key'), child: Icon(Icons.check));
    } else {
      return Container(key: const Key('close_container_icon_key'), child: Icon(Icons.error));
    }
  }

  Widget _buildTitleText() {
    return Text(
      widget.title ?? '',
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      key: const ValueKey('snackbar_title_key'),
      style: Theme.of(context).snackBarTheme.contentTextStyle,
    );
  }

  List<Widget> _buildRowLayout() {
    return <Widget>[
      _buildIcon(),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 12.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _buildTitleText(),
          ),
        ),
      )
    ];
  }

  BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.0),
    boxShadow: FElevation.elevation,
  );

  Widget _buildSnackBar(void Function() function) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        key: backgroundBoxKey,
        decoration: boxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: _buildRowLayout(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight! + 20),
      child: Material(type: MaterialType.transparency, child: _buildSnackBar(() {
        widget.function?.call();
      })),
    );
  }
}

enum TopSnackBarStatus { showing, dismissed, isHiding, isAppearing }

/// Indicates if snack bar is going to start at the [top]
enum TopSnackBarPosition { top }
