import 'package:bmi/layout/shop_app/cubit/cubit.dart';
import 'package:bmi/layout/shop_app/cubit/states.dart';
import 'package:bmi/models/shop_app/categories_model.dart';
import 'package:bmi/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder: (context,state) => ListView.separated
        (
        physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index) => buildCategoryItems(ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context,index) =>myDivider() ,
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length
      ),
    );
  }
  Widget buildCategoryItems(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        Image(image: NetworkImage(model.image),
          height: 120,
          width: 120,
        ),
        const SizedBox(width: 20,),
        Text(model.name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
        ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
