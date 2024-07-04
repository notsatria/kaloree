part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

final class EditProfile extends EditProfileEvent {
  final String fullName;
  final File? image;

  const EditProfile(this.fullName, this.image);
}
