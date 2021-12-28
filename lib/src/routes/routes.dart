import 'package:flutter/material.dart';
import 'package:score_domino/src/pages/home_page.dart';


Map<String, WidgetBuilder> getApplicationRoutes(){
   return <String, WidgetBuilder>{
    HomePage.routeName      : (BuildContext context) => const HomePage(),
  };
}