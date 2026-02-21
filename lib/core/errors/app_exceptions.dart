abstract class AppExceptions {
  String message;
  AppExceptions({required this.message});
}

class RemoteException extends AppExceptions {
  RemoteException({required super.message});
}
