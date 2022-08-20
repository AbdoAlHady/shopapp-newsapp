import 'package:bmicalc/layout/news_app/cubit/cubit.dart';
import 'package:bmicalc/layout/news_app/cubit/states.dart';
import 'package:bmicalc/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/news_app/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function() function,
  required String text,
  bool isUpperCase = true,
  double raduis = 0,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
      child: MaterialButton(
        height: 40,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String value)? onSubmit,
  Function(String value)? onChange,
  required validate,
  Function()? onTap,
  Function()? sufixPressed,
  bool isPassword = false,
  bool isClickable = true,
  required String label,
  required IconData prefix,
  IconData? sufix,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: sufix != null
            ? IconButton(onPressed: sufixPressed, icon: Icon(sufix))
            : null,
      ),
      validator: validate,
      obscureText: isPassword,
      onTap: onTap,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );

Widget buildTaskItem(Map model, BuildContext context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      AppCubit.get(context).delteDataBase(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35.0,
            child: Text('${model['time']}'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model['title']}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${model['date']}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDataBase(status: "done", id: model['id']);
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDataBase(status: "archive", id: model['id']);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              )),
        ],
      ),
    ),
  );
}

Widget buildArticlesItem({required articles, required context}) {
  return InkWell(
    onTap: (){
      navigateTo(context: context,widget: WebViewScreen(url: "${articles['url']}"));
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: articles['urlToImage'] != null
                    ? NetworkImage('${articles['urlToImage']}')
                    : const NetworkImage(
                        "https://media.wired.com/photos/5f401ecca25385db776c0c46/master/pass/Gear-How-to-Apple-ios-13-home-screen-iphone-xs-06032019_big_large_2x.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "${articles['title']}",
                      textAlign: TextAlign.end,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    "${articles['publishedAt']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget myDivider() {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    ),
  );
}

Widget buildArticleBuilder({required list, context,isSearch=false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) {
      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, index) {
          return buildArticlesItem(articles: list[index], context: context);
        },
        separatorBuilder: (ctx, index) {
          return myDivider();
        },
        itemCount: list.length,
      );
    },
    fallback: (context) {
      return isSearch? Container(): const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

void navigateTo({required context, widget}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
void navigateAndFinish({required context, widget}){
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
      (route)=>false,// الغي الصفحة الي قبلي
  );

}

Widget defaultTextButton( {required Function() function ,required String text}){
  return TextButton(
    onPressed:  function,
    child: Text(text.toUpperCase()),
  );
}
void showToast({
  required String Message,
  required ToastStates state,
})=>

    Fluttertoast.showToast(
        msg:Message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
void ShowToast({
  required String text,
  required ToastStates state,

}){
  Fluttertoast.showToast(
      msg:text ,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
//enum
enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state){
  Color color;
   switch(state){
     case ToastStates.SUCCESS:
       color= Colors.green;
       break;
     case ToastStates.ERROR:
       color= Colors.red;
       break;

     case ToastStates.WARNING:
       color= Colors.amber;
       break;
   }
   return color;
}