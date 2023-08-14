part of 'add_content_bloc.dart';

enum AddContentStatus { initial, loading, success }

class AddContentState extends Equatable {
  final File? video;
  final String caption;
  final AddContentStatus status;

  const AddContentState({
    required this.video,
    required this.caption,
    required this.status,
  });

  factory AddContentState.initial() {
    return const AddContentState(
      video: null,
      caption: "",
      status: AddContentStatus.initial,
    );
  }

  AddContentState copyWith({
    File? video,
    String? caption,
    AddContentStatus? status,
  }) {
    return AddContentState(
      video: video ?? this.video,
      caption: caption ?? this.caption,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [video, caption, status];
}
