import 'dart:developer';

class BaseResp<T> {
  int code;
  String msg;
  T data;
  Page page;

  BaseResp({this.code, this.msg, this.data, this.page});

  BaseResp.fromJson(Map<String, dynamic> json) {
    code = json["status"];
    msg = json["msg"]??'';
    data = json["data"];
    if (json["page"] != null) {
      page = Page.fromJson(json["page"]);
    }
  }
}

class Page {
  int totalRow;
  int currentPage;
  int nextPage;
  int prePage;
  int pageSize;
  int pages;

  Page(this.totalRow, this.currentPage, this.nextPage, this.prePage,
      this.pageSize, this.pages);

  Page.fromJson(Map<String, dynamic> json)
      : totalRow = json["totalRow"],
        currentPage = json["currentPage"],
        nextPage = json["nextPage"],
        prePage = json["prePage"],
        pageSize = json["pageSize"],
        pages = json["pages"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRow'] = this.totalRow;
    data['currentPage'] = this.currentPage;
    data['nextPage'] = this.nextPage;
    data['prePage'] = this.prePage;
    data['pageSize'] = this.pageSize;
    data['pages'] = this.pages;
    return data;
  }
}
