part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}

class ConnectionChanged extends InternetEvent {
  final bool isConnected;

  ConnectionChanged({required this.isConnected});
}

class CheckConnectionEvent extends InternetEvent {
  final VoidCallback? onSuccess;
  final VoidCallback? onError;

  CheckConnectionEvent({
    this.onError,
    this.onSuccess,
  });
}
