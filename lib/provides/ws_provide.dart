import 'package:flutter/material.dart';

class WsBloc with ChangeNotifier{
  List<Map> _infoList=[];

  List<Map> get infoList=>_infoList;
  WsBloc(){
  }
  //初始化信息列表
  initInfoList(data){
    _infoList.addAll(data);
  }
  //插入信息
  pushInfo(data){print('---${data['type']}');
    switch(data['type']){
      case 'verify':
        _infoList.add({'url':data['action']['pic'],'mask':0});
        break;
      case 'codelogin':
        break;
      default:
        break;
    }
  }
}