import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../../shared/components/default_form_field.dart';

class SearchScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DefaultFormField(
                  controller: searchController,
                  onTap: () {},
                  onFieldSubmitted: (value) {
                    AppCubit.get(context).search(value);
                  },
                  isPassword: false,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.search,
                  onValidate: (String? value) {
                    if (value!.isEmpty) {
                      return 'enter a text to search';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                  label: const Text(
                    'Search',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (state is AppSearchLoadingState) LinearProgressIndicator(),
                if (state is AppSearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
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
                                              .searchModel!
                                              .data
                                              .data[index]
                                              .image,
                                          height: 120,
                                          width: 120,
                                        ),
                                      ),
                                      if (AppCubit.get(context)
                                              .searchModel!
                                              .data
                                              .data[index]
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
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppCubit.get(context)
                                                .searchModel!
                                                .data
                                                .data[index]
                                                .name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3,
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Text(
                                                '${AppCubit.get(context).searchModel!.data.data[index].price} \$',
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
                                              if (AppCubit.get(context)
                                                      .searchModel!
                                                      .data
                                                      .data[index]
                                                      .discount !=
                                                  0)
                                                Text(
                                                  '${AppCubit.get(context).searchModel!.data.data[index].oldPrice} \$',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
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
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: AppCubit.get(context)
                            .searchModel!
                            .data
                            .data
                            .length),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
