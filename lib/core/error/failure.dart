abstract class AppFailure {
  final String message;
  const AppFailure(this.message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure([super.message = '']);
}

class TimeoutFailure extends AppFailure {
  const TimeoutFailure() : super('');
}

class ServerFailure extends AppFailure {
  final int? statusCode;
  const ServerFailure({this.statusCode, String message = ''}) : super(message);
}

class NoDataFailure extends AppFailure {
  const NoDataFailure() : super('');
}

class UnknownFailure extends AppFailure {
  const UnknownFailure([super.message = '']);
}