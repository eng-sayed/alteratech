class EndPoints {
  static const String URL_STORE_API_PATH = '/alteraApi/public/api/v1/';
  static const String Api_password = 'api_password';
  static const String URL_Default_Api_path = '/wp-json/wc/store/';
  static const String URL_JWT_BASE = '/wp-json/jwt-auth/v1';
  static const URL_JWT_TOKEN = '/$URL_JWT_BASE/token';
  static const String DEFAULT_WC_API_PATH = "/wp-json/wc/v3/";
  static const String URL_WP_BASE = '/wp-json/wp/v2';
  static const String URL_USER_ME = '$URL_WP_BASE/users/me';
  static const String URL_All_data = 'getAll';
  static const String URL_Get_Products = 'getAllProducts';
  static const String URL_Get_Category = 'getAllCategories';
  static const String URL_Get_SubCategory = 'getSubCategoriesForCategoryID';
  static const String URL_Get_SingleProduct = 'getSingleProduct';
  static String restPass = "auth/rest-password";
  static String deleteCustomer(customerId) => "customers/$customerId";
}
