// import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
// import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/category_field.dart';
// import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/description_field.dart';
// import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/price_field.dart';
// import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/product_name_field.dart';
// import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/save_product_button.dart';
// import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/stock_field.dart';
// import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/upload_image_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddProductScreen extends StatelessWidget {
//   const AddProductScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => AddProductCubit(),
//       child: BlocListener<
//           AddProductCubit,
//           AddProductState>(
//         listener: (context, state) {
//           if (state is AddProductSuccess) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(
//               const SnackBar(
//                 content: Text(
//                   "Product added successfully.",
//                 ),
//               ),
//             );

//             if (context.mounted) {
//               Navigator.pop(
//                 context,
//                 true,
//               );
//             }
//           }

//           if (state is AddProductFailure) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(
//               SnackBar(
//                 content: Text(
//                   state.message,
//                 ),
//               ),
//             );
//           }
//         },
//         child: Scaffold(
//           backgroundColor:
//               const Color(0xffF8FAFC),

//           appBar: AppBar(
//             elevation: 0,
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             foregroundColor:
//                 const Color(0xff001A2C),
//             surfaceTintColor: Colors.white,
//             scrolledUnderElevation: 0,

//             title: const Text(
//               "Add New Product",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight:
//                     FontWeight.bold,
//               ),
//             ),
//           ),

//           body: SafeArea(
//             child: BlocBuilder<
//                 AddProductCubit,
//                 AddProductState>(
//               builder: (
//                 context,
//                 state,
//               ) {
//                 final cubit =
//                     context.read<
//                         AddProductCubit>();

//                 return Form(
//                   key: cubit.formKey,
//                   child:
//                       SingleChildScrollView(
//                     padding:
//                         const EdgeInsets.all(
//                       20,
//                     ),
//                     child: Column(
//                       children: [
//                         const UploadImageCard(),

//                         const SizedBox(
//                           height: 24,
//                         ),

//                         const ProductNameField(),

//                         const SizedBox(
//                           height: 20,
//                         ),

//                         const CategoryField(),

//                         const SizedBox(
//                           height: 20,
//                         ),

//                         const DescriptionField(),

//                         const SizedBox(
//                           height: 20,
//                         ),

//                         const PriceField(),

//                         const SizedBox(
//                           height: 20,
//                         ),

//                         const StockField(),

//                         const SizedBox(
//                           height: 30,
//                         ),

//                         if (state
//                             is AddProductLoading)
//                           const Center(
//                             child:
//                                 CircularProgressIndicator(),
//                           )
//                         else
//                           const SaveProductButton(),

//                         const SizedBox(
//                           height: 30,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/category_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/description_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/price_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/product_name_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/save_product_button.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/stock_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/upload_image_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddProductScreen extends StatelessWidget {
  const AddProductScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => AddProductCubit(),

      child: BlocListener<AddProductCubit, AddProductState>(

        listener: (context, state) {

          if (state is AddProductSuccess) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  "Product added successfully.",
                ),
              ),
            );


            Navigator.pop(
              context,
              true,
            );
          }


          if (state is AddProductFailure) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
          }
        },


        child: Scaffold(

          backgroundColor:
              const Color(0xffF8FAFC),


          appBar: AppBar(

            elevation: 0,

            centerTitle: true,

            backgroundColor:
                Colors.white,

            foregroundColor:
                const Color(0xff001A2C),

            surfaceTintColor:
                Colors.white,

            scrolledUnderElevation:
                0,


            title: const Text(
              "Add New Product",

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),



          body: SafeArea(

            child: BlocBuilder<AddProductCubit, AddProductState>(

              builder: (context, state) {


                final cubit =
                    context.read<AddProductCubit>();


                return Form(

                  key: cubit.formKey,


                  child: SingleChildScrollView(

                    padding:
                        const EdgeInsets.all(20),


                    child: Column(

                      children: [

                        const UploadImageCard(),


                        const SizedBox(
                          height: 24,
                        ),


                        const ProductNameField(),


                        const SizedBox(
                          height: 20,
                        ),


                        const CategoryField(),


                        const SizedBox(
                          height: 20,
                        ),


                        const DescriptionField(),


                        const SizedBox(
                          height: 20,
                        ),


                        const PriceField(),


                        const SizedBox(
                          height: 20,
                        ),


                        const StockField(),


                        const SizedBox(
                          height: 30,
                        ),



                        if(state is AddProductLoading)

                          const CircularProgressIndicator()


                        else

                          const SaveProductButton(),



                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}