import 'package:bmi/layout/shop_app/cubit/cubit.dart';
import 'package:bmi/layout/shop_app/cubit/states.dart';
import 'package:bmi/models/shop_app/categories_model.dart';
import 'package:bmi/models/shop_app/home_model.dart';
import 'package:bmi/modules/shop_app/favourites/favourite__screen.dart';
import 'package:bmi/shared/components/components.dart';
import 'package:bmi/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (BuildContext context) =>
              productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
        );
      },
    );
  }

  Widget productsBuilder(
    HomeModel? model,
      CategoriesModel? categoriesModel,
  context
  ) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data.banners
                    .map((e) => Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Image(
                            image: NetworkImage(e.image),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(
                    seconds: 3,
                  ),
                  autoPlayAnimationDuration: const Duration(
                    seconds: 3,
                  ),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  scrollDirection: Axis.horizontal,
                  enlargeCenterPage: true,
                )),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCategoryItem(categoriesModel!.data.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10.0,
                            ),
                        itemCount: categoriesModel!.data.data.length),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'New Products',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: 1 / 1.38,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(model.data.products.length,
                      (index) => buildGridProduct(model.data.products[index],context)),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
         Image(
          image: NetworkImage(
              model.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100.0,
          color: Colors.white.withOpacity(0.8),
          child:  Text(
            model.name.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget buildGridProduct(
    ProductModel model,
      context
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0)),
                        child: Stack(
                          children: [
                            Image(
                              image: NetworkImage(model.image),
                              height: 120,
                              width: double.infinity,
                            ),
                            if (model.discount != 0)
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.red),
                                child: const Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                      fontSize: 8.0, color: Colors.white),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.5),
                ),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style:
                          const TextStyle(color: defaultColor, fontSize: 14.0),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        print(model.id);
                        ShopCubit.get(context).changeFavourites(model.id);                        print(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ?defaultColor:Colors.grey,                        child: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
