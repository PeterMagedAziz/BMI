import 'package:bmi/layout/shop_app/shop_layout.dart';
import 'package:bmi/modules/shop_app/login/cubit/cubit.dart';
import 'package:bmi/modules/shop_app/login/cubit/states.dart';
import 'package:bmi/modules/shop_app/register/shop_register_screen.dart';
import 'package:bmi/shared/components/components.dart';
import 'package:bmi/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be Empty';
                              }
                              return null;
                            },
                            label: 'Email',
                            prefix: Icons.email,
                            suffixPressed: () {},
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultTextFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              },
                              isPassword: ShopLoginCubit.get(context).isPassword,
                              onSubmit: (value){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Your Password';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (BuildContext context) => defaultButton(
                              function: () {
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'Login',
                              isUpperCase: true,
                            ),
                            fallback: (context) =>
                                 const Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              defaultTextButton(
                                function: () {
                                  navigateTo(
                                    context,
                                    const ShopRegisterScreen(),
                                  );
                                },
                                text: 'Register',
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if(state is ShopLoginSuccessState){
              if(state.loginModel.status){
                print(state.loginModel.data.token);
                print(state.loginModel.message);

                showSnackBar(message: state.loginModel.message,context: context,color: Colors.green);
                CacheHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value) {
                  navigateAndFinish(context, const ShopLayout());
                });

              }else {
                print(state.loginModel.message);

                showSnackBar(message: state.loginModel.message,context: context,color: Colors.red);

              }
                }
            }
      ),
    );
  }
}


