import 'package:bmi/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
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
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  VoidCallback? onTap,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: (String value) {
        print(value);
      },
      onChanged: (String value) {
        print(value);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email must not be Empty ';
        }
        return null;
      },
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
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
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
                    style:
                        TextStyle
                          (
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                  )
                ],
              ),
            ));

