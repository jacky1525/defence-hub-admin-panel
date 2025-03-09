part of 'user_bloc.dart';

class UserState extends Equatable {
  final List<UserModel> userList;

  const UserState({List<UserModel>? userList})
      : userList = userList ?? const <UserModel>[];

  @override
  List<Object?> get props => <Object?>[userList];

  UserState copyWith({List<UserModel>? userList}) {
    return UserState(userList: userList ?? this.userList);
  }
}
