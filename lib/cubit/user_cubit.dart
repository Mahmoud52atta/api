import 'package:api/cubit/user_state.dart';
import 'package:api/models/signin_model.dart';
import 'package:api/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo repo;
  UserCubit(this.repo) : super(SignInInitial());
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  SignInModel? user;
  upLoadProfilePick(XFile image) {
    profilePic = image;
    emit(SignInUpLoadImage());
  }

  userGetProfile() async {
    emit(GetUserLoading());
    final response = await repo.getUserProfile();
    response.fold(
      (erroreMessage) => emit(GetUserFailure(errMessage: erroreMessage)),
      (user) => emit(
        GetUserSuccess(user: user),
      ),
    );
  }

  signUp() async {
    emit(SignUpLoading());
    final Response = await repo.signUp(
        name: signUpName.text,
        email: signUpEmail.text,
        phone: signUpPhoneNumber.text,
        password: signUpPassword.text,
        confirmPassword: confirmPassword.text,
        profilePic: profilePic!);
    Response.fold(
      (errMessage) => emit(SignUpFailure(errMessage: errMessage)),
      (signUpmodel) => emit(
        SignUpSuccess(message: signUpmodel.message),
      ),
    );
  }

  signIn() async {
    emit(SignInLoading());
    final response = await repo.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
      (errMessage) => emit(SignInFailuer(erroreMessage: errMessage)),
      (signInModel) => emit(SignInSuccess()),
    );
  }
}
