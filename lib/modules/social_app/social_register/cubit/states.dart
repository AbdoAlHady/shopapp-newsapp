
abstract class SocialRegisterStates{}
class SocialRegisterInitialState extends SocialRegisterStates{}
class SocialRegisterLoadinglState extends SocialRegisterStates{}
class SocialRegisterSuccesslState extends SocialRegisterStates{

}
class SocialRegisterErrorlState extends SocialRegisterStates{
  final String error;

  SocialRegisterErrorlState(this.error);
}
class SocialRegisterChangePasswordVisibility extends SocialRegisterStates{

}


class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;

  SocialCreateUserErrorState(this.error);
}
class SocialCreateUserSuccessState extends SocialRegisterStates{

}