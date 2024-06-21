class Failure {
  int code; // 200, 201, 400, 303..500 and so on
  String message; // error , success
  String errorCode;

  Failure(this.code, this.message, {this.errorCode = '000000'});
}