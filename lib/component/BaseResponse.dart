// import 'dart:convert';
//
// import 'package:coresystem/Project/SDMS/Module/Notification/EPush/Api/Core/_Core.dart';
//
// class BaseResponse {
//   String message;
//   int code;
//   int totalCount;
//   int pageSize;
//   int count;
//   int page;
//   List<String> errors = [];
//   String error;
//   bool result;
//   bool IsWarning;
//   BaseResponse.fromJson(Map<String, dynamic> json) {
//     code = json['statusCode'];
//     message = json['errorDescription'];
//     result = json['IsCorrectPassword'];
//   }
// }
//
// class BasicResponse<T> {
//   String message;
//   int code;
//   String errorCode;
//   bool result;
//   String errorData;
//   dynamic DataOther;
//   T data;
//
//   int totalRow;
//
//   BasicResponse();
//
//   BasicResponse.fromJson(Map<String, dynamic> json) {
//     code = json['statusCode'];
//     result = json['statusCode'] == 1 ? true : false;
//     message = json['errorDescription'];
//   }
//
//   BasicResponse.fromJsonOther(dynamic data) {
//     DataOther = data;
//   }
// }
//
// class PageListItem {
//   LoadOptions ?loadOptions;
//   String ?param;
//   PageListItem({this.loadOptions, this.param});
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['loadOptions'] = jsonEncode(loadOptions);
//     data['param'] = '';
//     return data;
//   }
// }
//
// class LoadOptions {
//   int? skip;
//   int? take;
//   bool requireTotalCount;
//   List<String> ?filter;
//   List<SortItem> ?Sort;
//   LoadOptions({this.skip = 0, this.take = 0, this.filter, this.Sort, this.requireTotalCount = false});
//
//   LoadOptions.fromJson(Map<String, dynamic> json) {
//     skip = json['Skip'];
//     take = json['Take'];
//     filter = json['Filter'].cast<String>();
//     if (json['Sort'] != null) {
//       Sort = <SortItem>[];
//       json['Sort'].forEach((v) {
//         Sort!.add(SortItem.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['Skip'] = skip;
//     data['Take'] = take;
//     data['Filter'] = filter;
//     if (Sort != null) {
//       data['Sort'] = Sort.map((v) => v.toJson()).toList();
//     }
//     if (requireTotalCount == true) {
//       data['RequireTotalCount'] = requireTotalCount;
//     }
//     return data;
//   }
// }
//
// class SortItem {
//   String ?selector;
//   bool ?desc;
//
//   SortItem({this.selector, this.desc});
//
//   SortItem.fromJson(Map<String, dynamic> json) {
//     selector = json['Selector'];
//     desc = json['Desc'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['Selector'] = selector;
//     data['Desc'] = desc;
//     return data;
//   }
// }
