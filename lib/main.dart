import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'route/routes.dart';
import 'models/state_model/main_state_model.dart';
import 'config/application.dart';
import 'ui/page/mainpage.dart';

void main() {
  runApp(App());
}


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();

}

///Scoped_model是一个dart第三方库，提供了让您能够轻松地将数据模型从父Widget传递到它的后代的功能。此外，它还会在模型更新时重新渲染使用该模型的所有子项。
///它直接来自于Google正在开发的新系统Fuchsia核心Widgets 中对Model类的简单提取，作为独立使用的独立Flutter插件发布。
///Scoped model使用了观察者模式，将数据模型放在父代，后代通过找到父代的model进行数据渲染，最后数据改变时将数据传回，父代再通知所有用到了该model的子代去更新状态。
class _AppState extends State<App>  with AutomaticKeepAliveClientMixin{

  MainStateModel mainStateModel;
  String token;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {

    mainStateModel = MainStateModel();
    Application.eventBus = EventBus();
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    saveStorageString('18846086270','1111');

  }

  Future saveStorageString(key,value) async {
    print("save");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        key, value);
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //状态管理
    return ScopedModel<MainStateModel>(
        model: mainStateModel,
        child: ScopedModelDescendant<MainStateModel>(
            builder: (context, child, model)
            {
              return new MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Hotel',
                theme: ThemeData( accentColor: Colors.black54, dialogBackgroundColor: Colors.transparent),
                home: MainPage(),
                onGenerateRoute: Application.router.generator,
                //routes: PageRoutes.getRoutes()
              );
            }
        )
    );
  }
}
