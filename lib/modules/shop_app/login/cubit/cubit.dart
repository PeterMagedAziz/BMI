import 'package:bmi/models/shop_app/shop_login_model.dart';
import 'package:bmi/modules/shop_app/login/cubit/states.dart';
import 'package:bmi/shared/network/end_points/end__points.dart';
import 'package:bmi/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());


  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel ? loginModel;


  void userLogin({
    required String email,
    required String password
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }).then((value) {
          print(value.data);
          loginModel = ShopLoginModel.fromJson(value.data);
          // print(loginModel!.status);
          // print(loginModel!.message);
          // print(loginModel!.data.token);
          emit(ShopLoginSuccessState(loginModel!)
          );
    }).catchError((error){
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });

  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());

  }

}