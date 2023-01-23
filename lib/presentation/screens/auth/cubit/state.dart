abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginErrorState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterErrorState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class LogoutLoadingState extends AuthStates {}

class LogoutErrorState extends AuthStates {}

class LogoutSuccessState extends AuthStates {}

class SendOtpLoadingState extends AuthStates {}

class SendOtpErrorState extends AuthStates {}

class SendOtpSuccessState extends AuthStates {}

class ResetPasswordLoadingState extends AuthStates {}

class ResetPasswordErrorState extends AuthStates {}

class ResetPasswordSuccessState extends AuthStates {}

class ForgotPasswordLoadingState extends AuthStates {}

class ForgotPasswordErrorState extends AuthStates {}

class ForgotPasswordSuccessState extends AuthStates {}

class ChangePasswordLoadingState extends AuthStates {}

class ChangePasswordErrorState extends AuthStates {}

class ChangePasswordSuccessState extends AuthStates {}
