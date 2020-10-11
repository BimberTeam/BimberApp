enum Status { OK, ERROR }

extension StatusExtension on Status {
  String toJson() {
    switch (this) {
      case Status.OK:
        return "OK";
      case Status.ERROR:
        return "ERROR";
      default:
        return null;
    }
  }

  static Status fromJson(String name) {
    switch (name) {
      case "OK":
        return Status.OK;
      case "ERROR":
        return Status.ERROR;
      default:
        return null;
    }
  }
}
