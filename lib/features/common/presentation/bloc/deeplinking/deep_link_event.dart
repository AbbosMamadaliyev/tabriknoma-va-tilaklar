part of 'deep_link_bloc.dart';

@immutable
abstract class DeepLinkEvent {}

class DeepLinkChanged extends DeepLinkEvent {
  final String uri;

  DeepLinkChanged({required this.uri});
}

class GetNewsDetails extends DeepLinkEvent {
  final String slug;

  GetNewsDetails({required this.slug});
}
