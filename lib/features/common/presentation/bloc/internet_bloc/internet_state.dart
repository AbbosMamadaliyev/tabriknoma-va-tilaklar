part of 'internet_bloc.dart';

@immutable
class InternetState extends Equatable {
  final bool isConnected;
  final FormzSubmissionStatus status;
  final bool isCheck;

  const InternetState({required this.status, this.isConnected = true, this.isCheck = false});

  InternetState copyWith({
    FormzSubmissionStatus? status,
    bool? isConnected,
    bool? isCheck,
  }) =>
      InternetState(
          status: status ?? this.status,
          isConnected: isConnected ?? this.isConnected,
          isCheck: isCheck ?? this.isCheck);

  @override
  List<Object?> get props => [isConnected, status, isCheck];
}
