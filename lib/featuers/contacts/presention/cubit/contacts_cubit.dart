import 'package:bloc/bloc.dart';
import 'package:chat75/featuers/Auth/data/model/UserInfoModel.dart';
import 'package:meta/meta.dart';

import '../../data/repo/contactsRepo.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit(this.contactsRepo) : super(ContactsInitial());
  ContactsRepo contactsRepo;

  fechConcts() async {
    emit(ContactsLoading());
    final result = await contactsRepo.getAllContacts();
    result.fold(
        (l) => emit(ContactsError(l.message)), (r) => emit(ContactsLoaded(r)));
  }
}
