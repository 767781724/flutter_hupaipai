import 'package:flutter/material.dart';
import 'package:hupaipai/widgets/loading_widget.dart';
import 'package:hupaipai/net/service_api.dart';
import 'package:hupaipai/models/tender_model.dart';
import 'package:hupaipai/store/user_notifier.dart';
import 'package:hupaipai/route/app_router.dart';
import 'package:hupaipai/utils/log_util.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:hupaipai/widgets/tender_card_widget.dart';

class TenderPage extends StatefulWidget {
  @override
  _TenderPageState createState() => _TenderPageState();
}

class _TenderPageState extends State<TenderPage> with ScreenUtil {
  Widget _ListBox(TenderModel tenderModel) {
    return Padding(
      padding: EdgeInsets.only(left: setWidth(15), right: setWidth(15)),
      child: Column(
        children: <Widget>[
          TenderCardWidget(
              bidNumber: '标书号${tenderModel.bid_number}',
              password: tenderModel.bid_passwd,
              status: BidStateDisplay[tenderModel.state],
              tactics: '比较激进策略',
              id: tenderModel.id_number,
              is_default: tenderModel.is_default,
              payment:
                  BidState.values[tenderModel.state] == BidState.successful,
              btn: SizedBox(
                width: setWidth(90),
                height: setWidth(34),
                child: FlatButton(
                  child: Text(tenderModel.is_default == 1 ? '默认' : '设为默认',
                      style: TextStyle(
                          color: Color(0xff1CCAD6),
                          fontWeight: FontWeight.w400,
                          fontSize: setSp(13))),
                  color: Colors.white,
                  highlightColor: Colors.white,
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: tenderModel.is_default == 1
                      ? null
                      : () {
                          ServiceApi()
                              .setDefaultTender(context, tenderModel.id)
                              .then((_) {
                            setState(() {});
                          });
                        },
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: setWidth(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: setWidth(80),
                  height: setWidth(30),
                  margin: EdgeInsets.only(right: setWidth(30)),
                  child: OutlineButton(
                    onPressed: () {
                      var bjson =
                          AppRouter.jsonUtf8Encode(tenderModel.toJson());
                      AppRouter.navigateTo(
                          context, Routes.tenderSettingPage + '/$bjson');
                    },
                    padding: EdgeInsets.all(0),
                    highlightedBorderColor: Color(0xFF666666),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    borderSide: BorderSide(color: Color(0xFF666666)),
                    child: Text(
                      '编辑',
                      style: TextStyle(
                          fontSize: setSp(12), color: Color(0xff333333)),
                    ),
                  ),
                ),
                SizedBox(
                  width: setWidth(80),
                  height: setWidth(30),
                  child: OutlineButton(
                    onPressed: tenderModel.is_default == 1
                        ? null
                        : () {
                            ServiceApi()
                                .deleteTender(context, tenderModel.id)
                                .then((_) {
                              LogUtil.i("删除标书成功");
                              setState(() {});
                            });
                          },
                    padding: EdgeInsets.all(0),
                    highlightedBorderColor: Color(0xFF666666),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    borderSide: BorderSide(color: Color(0xFF666666)),
                    child: Text('删除',
                        style: TextStyle(
                            fontSize: setSp(12), color: Color(0xff333333))),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<List<TenderModel>> _loadData() async {
    var um = UserNotifier.userModel;
    var data = await ServiceApi().getTenders(context, um.id);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text("全部标书"),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      var tenderModel = TenderModel();
                      var bjson =
                          AppRouter.jsonUtf8Encode(tenderModel.toJson());
                      AppRouter.navigateTo(
                          context, Routes.tenderSettingPage + '/$bjson');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(
              future: _loadData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var tenderModels = snapshot.data as List<TenderModel>;
                  if (tenderModels != null) {
                    return ListView.builder(
                        itemCount: tenderModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _ListBox(tenderModels[index]);
                        });
                  }
                } else {
                  return LoadingWidget(text: '加载中...');
                }
              }),
        ));
  }
}
