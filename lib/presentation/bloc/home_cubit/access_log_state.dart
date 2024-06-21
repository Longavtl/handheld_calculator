// import 'package:equatable/equatable.dart';
//
// import '../../../data/models/home_access_log_model.dart';
//
// sealed class AccessLogState extends Equatable {
//   const AccessLogState();
//
//   @override
//   List<Object> get props => [];
// }
// final class AccessLogInitial extends AccessLogState {}
//
// final class AccessLogLoading extends AccessLogState {}
//
// final class AccessLogSuccess extends AccessLogState {
// final AccessLogModel accessLogModel;
// const AccessLogSuccess({required this.accessLogModel});
// }
//
// final class AccessLogFailed extends AccessLogState{
// final String? message;
// const AccessLogFailed({required this.message});
// @override
// List<Object> get props => [];
// }