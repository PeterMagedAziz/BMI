import 'package:bmi/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.deepOrange,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) => TextButton(
    onPressed: function,
    child:  Text(text.toUpperCase(),style: const TextStyle(fontSize: 15.0),),
);

// Widget defaultFormField({
//   required TextEditingController controller,
//   required TextInputType type,
//   required Function(String) validate ,
//   bool isPassword = false,
//   required String label,
//   required IconData prefix,
//   VoidCallback? onTap,
//   IconData? suffix,
//   VoidCallback? suffixPressed,
//   final void Function(String)? onChange,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword,
//       onTap: onTap,
//       onFieldSubmitted: (String value) {
//         print(value);
//       },
//       onChanged: onChange,
//       validator:
//           (value) {
//         if (value!.isEmpty) {
//           return 'Email must not be Empty ';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(
//           prefix,
//         ),
//         suffixIcon: suffix != null
//             ? IconButton(
//                 onPressed: suffixPressed,
//                 icon: Icon(
//                   suffix,
//                 ),
//               )
//             : null,
//         border: const OutlineInputBorder(),
//       ),
//     );

// Widget defaultFormField({
//   required TextEditingController controller,
//   required TextInputType type,
//   final void Function(String)? onSubmit,
//   final void Function(String)? onChange,
//   VoidCallback? onTap,
//   bool isPassword = false,
//   required Function(String) validate ,
//   required String label,
//   required IconData prefix,
//   IconData? suffix,
//   VoidCallback? suffixPressed,
//   bool isClickable = true,
//   // required TextEditingController controller,
// //   required TextInputType type,
// //   final void Function(String)? onSubmit,
// //   final void Function(String)? onChange,
// //   VoidCallback? onTap,
// //   bool isPassword = false,
// //   required Function(String) validate ,
// //   required String label,
// //   required IconData prefix,
// //   IconData? suffix,
// //   VoidCallback? suffixPressed,
// //   bool isClickable = true,
//
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword,
//       enabled: isClickable,
//       onFieldSubmitted: onSubmit,
//       onChanged: onChange,
//       onTap: onTap,
//       validator:
//           (value) {
//         if (value!.isEmpty) {
//           return 'This Form must not be Empty ';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(
//           prefix,
//         ),
//         suffixIcon: suffix != null
//             ? IconButton(
//           onPressed: suffixPressed,
//           icon: Icon(
//             suffix,
//           ),
//         )
//             : null,
//         border: const OutlineInputBorder(),
//       ),
//     );

Widget defaultTextFormField({
  required TextEditingController controller,
  required String label,
  TextInputType? keyboardType,
  int? maxLength,
  required String? Function(String?)? validator,
  required IconData prefix,
  IconData? suffix,
  bool outlineInputBorderStatus = true,
  required TextInputType type,
  bool secureText = false,
  String? hint,
  VoidCallback? suffixPressed,
  dynamic initialValue,
  dynamic onTap,
  bool isClickable = true,
  bool isPassword = false,
  final void Function(String)? onSubmit,
  final void Function(String)? onChange,

}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: (String value) {
        print(value);
      },
      onChanged: onChange,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archived', id: model['id']);
                },
                icon: const Icon(
                  Icons.archive,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
        condition: tasks.isNotEmpty,
        builder: (context) => ListView.separated(
              itemBuilder: (context, index) {
                return buildTaskItem(tasks[index], context);
              },
              separatorBuilder: (context, index) => myDivider(),
              itemCount: tasks.length,
            ),
        fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.menu,
                    size: 80.0,
                    color: Colors.grey,
                  ),
                  Text(
                    'No Tasks Yet, Please Add Some Tasks',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              ),
            ));

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Container(

        width: double.infinity,

        height: 1.0,

        color: Colors.grey[300],

      ),
);
Widget buildArticleItems(articles,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewController()
      ..loadRequest(
        Uri.parse('${articles['url']}'),
      ));
  },
  child:   Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            Container(

              width: 120.0,

              height: 120.0,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.0),

                image:  DecorationImage(

                    image: NetworkImage(

                        '${articles['urlToImage']}'),

                    fit: BoxFit.cover),

              ),

            ),

            const SizedBox(

              width: 20.0,

            ),

            Expanded(

              child: SizedBox(

                height: 120.0,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisSize: MainAxisSize.min,

                  mainAxisAlignment: MainAxisAlignment.start,

                  children:  [

                    Expanded(

                      child: Text(

                        '${articles['title']}',

                        style: Theme.of(context).textTheme.bodyText1,

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                      ),

                    ),

                    Text(

                      '${articles['publishedAt']}',

                      style: const TextStyle(color: Colors.grey, fontSize: 15.0),

                    ),

                  ],

                ),

              ),

            )

          ],

        ),

      ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItems(list[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: 10,
  ),
  fallback: (context) =>
  isSearch ? Container() : const Center(child: CircularProgressIndicator()),
);
Widget buildScienceItems(sciences) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image:  DecorationImage(
                  image: NetworkImage(
                      '${sciences['urlToImage']}'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  Expanded(
                    child: Text(
                      '${sciences['title']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${sciences['publishedAt']}',
                    style: const TextStyle(color: Colors.grey, fontSize: 15.0),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
Widget buildSportsItems(sports) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image:  DecorationImage(
                  image: NetworkImage(
                      '${sports['urlToImage']}'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  Expanded(
                    child: Text(
                      '${sports['title']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${sports['publishedAt']}',
                    style: const TextStyle(color: Colors.grey, fontSize: 15.0),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
void navigateTo (context,widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget
  ),
);

void navigateAndFinish(context,widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget
        ),
        (route) => false
    );

void showToast ({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates {success, error, warning}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch(state){
    case ToastStates.success:
      color = Colors.green;
    break;
    case ToastStates.error:
      color= Colors.red;
    break;
    case ToastStates.warning:
      color= Colors.amber;
    break;
  }
  return color;
}

void showSnackBar({required String message,required BuildContext context,required Color color}){
  var snackBar = SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    content: Text(message,textAlign: TextAlign.center,),
    clipBehavior: Clip.hardEdge,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 70,vertical: 15),
    padding: const EdgeInsets.all(10),
    backgroundColor: color,
    duration: const Duration(seconds: 1),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}