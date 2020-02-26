import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hupaipai/utils/screen_util.dart';
class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with ScreenUtil {
  Widget _listBox(String lable, String title) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Text(
        lable,
        style: TextStyle(fontSize: setSp(17), color: Color(0xff333333)),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(setWidth(24))),
            child: Text(
              title,
              style: TextStyle(fontSize: setSp(17), color: Color(0xff666666)),
            )),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: setWidth(13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑资料'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(setWidth(15)),
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Text(
                  '头像',
                  style: TextStyle(fontSize: setSp(17), color: Color(0xff333333)),
                ),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: setWidth(48),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(setWidth(24))),
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: "http://cdn.duitang.com/uploads/blog/201404/22/20140422142715_8GtUk.thumb.600_0.jpeg",
                        placeholder: (context, url) => Image.asset(
                          'assets/images/img_loading.png',
                          fit: BoxFit.fitWidth,
                        ),
                        width: setWidth(48),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: setWidth(13),
                ),
              ),
              Divider(),
              _listBox('姓名', '黄大仙'),
              Divider(),
              _listBox('身份证号', '3020810282038200382'),
              Divider(),
              _listBox('微信号', '已绑定'),
              Divider(),
              _listBox('手机号', '181738373333')
            ],
          ),
        ),
      ),
    );
  }
}
