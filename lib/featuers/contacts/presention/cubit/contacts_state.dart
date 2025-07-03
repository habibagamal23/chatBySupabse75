part of 'contacts_cubit.dart';

@immutable
sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactsLoading extends ContactsState {}

final class ContactsLoaded extends ContactsState {
  List<UserInfoModel> contacts;
  ContactsLoaded(this.contacts);
}

final class ContactsError extends ContactsState {
  String message;
  ContactsError(this.message);
}
