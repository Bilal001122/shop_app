import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return state is! AppGetFavLoadingState
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 120,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Center(
                                  child: Image.network(
                                    AppCubit.get(context)
                                        .favoritesModel!
                                        .data
                                        .data[index]
                                        .productModel
                                        .image,
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                                if (AppCubit.get(context)
                                        .favoritesModel!
                                        .data
                                        .data[index]
                                        .productModel
                                        .discount !=
                                    0)
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
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppCubit.get(context)
                                          .favoritesModel!
                                          .data
                                          .data[index]
                                          .productModel
                                          .name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3,
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          '${AppCubit.get(context).favoritesModel!.data.data[index].productModel.price} \$',
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
                                        if (1 != 0)
                                          Text(
                                            '${AppCubit.get(context).favoritesModel!.data.data[index].productModel.oldPrice} \$',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            AppCubit.get(context)
                                                .changeFavorites(
                                                    AppCubit.get(context)
                                                        .favoritesModel!
                                                        .data
                                                        .data[index]
                                                        .productModel
                                                        .id);
                                          },
                                          icon: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                AppCubit.get(context).favorites[
                                                        AppCubit.get(context)
                                                            .favoritesModel!
                                                            .data
                                                            .data[index]
                                                            .productModel
                                                            .id]!
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
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 5,
              );
            },
            itemCount: AppCubit.get(context).favoritesModel!.data.data.length);
      },
      listener: (context, state) {},
    );
  }
}
