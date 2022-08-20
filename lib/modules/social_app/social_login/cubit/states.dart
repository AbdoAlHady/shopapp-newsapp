
abstract class SocialLoginStates{}
class SocialLoginInitialState extends SocialLoginStates{}
class SocialLoginLoadinglState extends SocialLoginStates{}
class SocialLoginSuccesslState extends SocialLoginStates{

}
class SocialLoginErrorlState extends SocialLoginStates{
  final String error;

  SocialLoginErrorlState(this.error);
}
class SocialLoginChangePasswordVisibility extends SocialLoginStates{

}