// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/model/get_favorite.dart';
import 'package:project1/presentaions/screen/layout/home_layout/cubit/layout_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetFavoriteLoadingState,
          builder: (BuildContext context) {
            var cubit = LayoutCubit.get(context);
            print(cubit.getFavoriteModel?.data!.data!.length);
            return ListView.builder(
              itemBuilder: (context, index) => buildList(
                  cubit.getFavoriteModel!.data!.data![index], context),
              itemCount: cubit.getFavoriteModel?.data!.data!.length,
            );
          },
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildList(FavData model, context) {
    return Container(
      width: double.infinity,
      height: 170.0,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
        child: Row(
          children: [
            // ConditionalBuilder(
            //     condition: , builder: builder, fallback: fallback),
            Container(
              height: double.infinity,
              width: 150.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(model.product!.image ?? "_"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "title",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${model.product?.price}    \$',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      if (model.product?.price != model.product?.oldPrice)
                        Text(
                          '${model.product?.oldPrice}    \$',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        LayoutCubit.get(context)
                            .cahngeFavorites(model.product?.id);
                        print(model.product?.id);
                      },
                      // LayoutCubit.get(context).myColor
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
