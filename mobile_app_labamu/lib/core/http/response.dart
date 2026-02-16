class DataResponse<T> {
  Status? status;
  String? message;
  dynamic data;
  dynamic user;

  DataResponse.loading(this.message) : status = Status.Loading;

  DataResponse.success(this.data) : status = Status.Success;

  DataResponse.error(this.message) : status = Status.Error;

  DataResponse.connectivityError() : status = Status.ConnectivityError;

  @override
  String toString() {
    return "Status: $status \n message: $message \n Data : $data";
  }
}

enum Status { Loading, Success, Error, ConnectivityError }
