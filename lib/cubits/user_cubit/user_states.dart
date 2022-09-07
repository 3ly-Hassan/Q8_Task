abstract class UserState {}

class InitialState extends UserState {}

class GetUsersError extends UserState {}

class UserLoadedSuccessfully extends UserState {}

class PlayerChangedSuccessfully extends UserState {}

class ToggleClear extends UserState {}

class SearchedComplet extends UserState {}
