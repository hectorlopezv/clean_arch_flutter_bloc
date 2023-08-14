import 'package:bloc/bloc.dart';
import 'package:clean_arch_bloc/src/features/feed/domain/use_cases/get_users.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetUsers _getUsers;

  DiscoverBloc({required GetUsers getUsers})
      : assert(getUsers != null),
        _getUsers = getUsers,
        super(DiscoverLoading()) {
    on<DiscoverGetUsers>(_onDiscoverGetUsers);
  }

  void _onDiscoverGetUsers(
    DiscoverGetUsers event,
    Emitter<DiscoverState> emit,
  ) async {
    debugPrint('DiscoverGetUsers');
    emit(DiscoverLoading());
    final users = await _getUsers(
      NoParams(),
    );
    emit(DiscoverLoaded(users: users));
  }
}
