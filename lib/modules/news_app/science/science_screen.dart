import 'package:bmi/layout/news_app/cubit/cubit.dart';
import 'package:bmi/layout/news_app/cubit/states.dart';
import 'package:bmi/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        builder: (context,state) {
          var list = NewsCubit.get(context).sciences;
          return ConditionalBuilder(
            condition: list.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index) => buildArticleItems(NewsCubit.get(context).sciences[index],context),
                separatorBuilder: (context,index) => myDivider(),
                itemCount: 20),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(
              ),
            ),
          );
        },
        listener: (context,states) {}
    );
  }
}