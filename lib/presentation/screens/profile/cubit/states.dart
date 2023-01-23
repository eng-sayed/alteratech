abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

// get Profile Data

class ProfilePageGetAdsLoadingState extends ProfileStates {}

class ProfilePageGetAdsErrorState extends ProfileStates {}

class ProfilePageGetAdsSuccessState extends ProfileStates {}

class GetCustomerDataLoadingState extends ProfileStates {}

class GetCustomerDataSuccessState extends ProfileStates {}

class GetCustomerDataErrorState extends ProfileStates {}

class GetShippingMethodeSuccessState extends ProfileStates {}

class GetShippingMethodeErrorState extends ProfileStates {}

class SendOrderLoadingState extends ProfileStates {}

class SendOrderSuccessState extends ProfileStates {}

class SendOrderErrorState extends ProfileStates {}

class UpdateCustomerDataLoadingState extends ProfileStates {}

class UpdateCustomerDataSuccessState extends ProfileStates {}

class UpdateCustomerDataErrorState extends ProfileStates {}

class DeleteCustomerDataLoadingState extends ProfileStates {}

class DeleteCustomerDataSuccessState extends ProfileStates {}

class DeleteCustomerDataErrorState extends ProfileStates {}
