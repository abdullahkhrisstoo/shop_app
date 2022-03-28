// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/model/categories.dart';
import 'package:project1/model/home_model.dart';
import 'package:project1/presentaions/screen/layout/home_layout/cubit/layout_cubit.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: LayoutCubit.get(context).homeModel != null &&
              LayoutCubit.get(context).categoriesModel != null,
          builder: (context) => products(LayoutCubit.get(context).homeModel,
              LayoutCubit.get(context).categoriesModel, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget products(
    HomeModel? model,
    CategoriesModel? categoriesModel,
    context,
  ) =>
      SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 200,
            //   child: CarouselSlider(
            //     items: model?.data?.banners
            //         ?.map(
            //           (e) => Image(
            //             image: NetworkImage(e.image ?? " "),
            //             width: double.infinity,
            //             fit: BoxFit.fill,
            //           ),
            //         )
            //         .toList(),
            //     options: CarouselOptions(
            //       height: 400,
            //       aspectRatio: 16 / 9,
            //       viewportFraction: 0.8,
            //       initialPage: 0,
            //       enableInfiniteScroll: true,
            //       reverse: false,
            //       autoPlay: true,
            //       autoPlayInterval: const Duration(seconds: 3),
            //       autoPlayAnimationDuration: const Duration(milliseconds: 800),
            //       autoPlayCurve: Curves.fastOutSlowIn,
            //       enlargeCenterPage: true,
            //       scrollDirection: Axis.horizontal,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => buildCategories(
                    categoriesModel!.data!.data![index], context),
                itemCount: categoriesModel!.data!.data!.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                    "products",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 1.44,
                ),
                itemBuilder: (context, index) =>
                    buildGridProduct(model!.data!.products![index], context),
                itemCount: model!.data!.products!.length,
              ),
            ),
          ],
        ),
      );
  buildGridProduct(Products model, context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  width: double.infinity,
                  fit: BoxFit.fill,
                  image: NetworkImage(model.image),
                  height: 200,
                ),
                if (model.price != model.oldPrice)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const Text(
                      "discount",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
              ],
            ),
            Text(
              model.name ?? 'no name to show',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, height: 1.2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  model.price.toString() + '  \$',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                if (model.price != model.oldPrice)
                  Text(
                    model.oldPrice.toString() + '  \$',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    LayoutCubit.get(context).cahngeFavorites(model.id);
                    print(model.id);
                    print(LayoutCubit.get(context).favorites.toString());
                  },
                  // LayoutCubit.get(context).myColor

                  icon: Icon(
                    Icons.favorite_border,
                    color: LayoutCubit.get(context).favorites[model.id] == true
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  buildCategories(DataModel dataModel, context) => Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Image(
            image: NetworkImage(dataModel.image ?? "_"),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            child: Text(
              dataModel.name ?? "_",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Colors.black.withOpacity(0.8),
          ),
        ],
      );
}
