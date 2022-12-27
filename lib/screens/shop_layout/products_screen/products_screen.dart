import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppChangeFavoritesSuccessState) {
          if (!state.changeFavoritesModel!.status) {
            Fluttertoast.showToast(
              msg: state.changeFavoritesModel!.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        }
      },
      builder: (context, state) {
        HomeModel? homeModel = AppCubit.get(context).homeModel;
        CategoriesModel? categoriesModel =
            AppCubit.get(context).categoriesModel;
        return AppCubit.get(context).homeModel != null &&
                AppCubit.get(context).categoriesModel != null
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: AppCubit.get(context)
                          .homeModel!
                          .data
                          .banners
                          .map(
                            (element) => Image.network(
                              element.image,
                              fit: BoxFit.cover,
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: 200,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        viewportFraction: 1,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CategoriesScroll(
                            categoriesModel: categoriesModel!,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'New Products',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    ProductsScroll(
                        homeModel: homeModel!,
                        favorites: AppCubit.get(context).favorites),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class CategoriesScroll extends StatelessWidget {
  final CategoriesModel categoriesModel;

  const CategoriesScroll({Key? key, required this.categoriesModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    categoriesModel.categoriesDataModel.data[index].image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.8),
                    child: Text(
                      categoriesModel.categoriesDataModel.data[index].name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
            );
          },
          itemCount: categoriesModel.categoriesDataModel.data.length),
    );
  }
}

class ProductsScroll extends StatelessWidget {
  final HomeModel homeModel;
  final Map<int, bool> favorites;

  const ProductsScroll(
      {Key? key, required this.homeModel, required this.favorites})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 10,
      childAspectRatio: 1 / 1.7,
      children: List.generate(
        homeModel.data.products.length,
        (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Center(
                    child: Image.network(
                      homeModel.data.products[index].image,
                      height: 200,
                    ),
                  ),
                  if (homeModel.data.products[index].discount != 0)
                    Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'DISCOUNT',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homeModel.data.products[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${homeModel.data.products[index].price.round()} \$',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (homeModel.data.products[index].discount != 0)
                          Text(
                            '${homeModel.data.products[index].oldPrice.round()} \$',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            AppCubit.get(context).changeFavorites(
                                homeModel.data.products[index].id);
                            print(
                                favorites[homeModel.data.products[index].id]!);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                favorites[homeModel.data.products[index].id]!
                                    ? Colors.blue
                                    : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          splashRadius: 23,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
