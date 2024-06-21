import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackBarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  // Test test = GetIt.instance();
  SnackBarBloc() : super(InitialSnackbarState());

  @override
  Stream<SnackbarState> mapEventToState(SnackbarEvent event) async* {
    // print(test.a);
    if (event is ShowSnackbarEvent) {
      yield ShowSnackBarState(content: event.content, type: event.type, function: event.function);
    }
  }
}

abstract class SnackbarEvent {}

class ShowSnackbarEvent extends SnackbarEvent {
  String ?content;
  SnackBarType ?type;
  Function ?function;

  ShowSnackbarEvent({
    this.content,
    this.type,
    this.function,
  });
}

enum SnackBarType { success, error }

class ShowSnackBarState extends SnackbarState {
  ShowSnackBarState({
    @required type,
    String ?content,
    Function ?function,
  }) : super(
          type: type,
          content: content ?? '',
          function: function,
        );
}

abstract class SnackbarState {
  final String ?content;
  final SnackBarType ?type;
  final Function ?function;
  SnackbarState({
    this.content,
    this.type,
    this.function,
  });
}

class InitialSnackbarState extends SnackbarState {}
