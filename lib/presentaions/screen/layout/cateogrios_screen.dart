// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/constant/colors.dart';
import 'package:project1/model/categories.dart';

import 'home_layout/cubit/layout_cubit.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCatItem(
              LayoutCubit.get(context).categoriesModel!.data!.data![index]),
          itemCount:
              LayoutCubit.get(context).categoriesModel?.data!.data?.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel dataModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Card(
          shadowColor: ConstantColor.primaryColor,
          elevation: 5,
          child: Row(
            children: [
              Image(
                image: NetworkImage(dataModel.image ?? "_"),
                width: 150,
                height: 150,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                dataModel.name ?? '_',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
}
