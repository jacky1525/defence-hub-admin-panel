import 'package:defence_hub_admin_panel/features/authentication/data/auth_repository.dart';
import 'package:defence_hub_admin_panel/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;

  UserBloc(this.authRepository)
      : super(const UserState(userList: <UserModel>[])) {
    on<FetchUserEvent>(_getUser);
  }

  Future<void> _getUser(FetchUserEvent event, Emitter<UserState> emit) async {
    final userStream = authRepository.getUsers();
    
    await emit.forEach<List<UserModel>>(
      userStream,
      onData: (userList) {
        return UserState(userList: userList);
      },
      onError: (error, stackTrace) {
        debugPrint("Error fetching user: $error");
        return state;
      },
    );
  }
}