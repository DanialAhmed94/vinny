import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants{

 static final  apiKey = dotenv.env['API_KEY'];

 static String baseUrl = "https://stagingvinnyai.appjeeni.com/public/api";
 static String assetBaseUrl = "https://stagingvinnyai.appjeeni.com/public/asset";
 static String homeUnselected = "assets/svg/homeUnselected.svg";
 static String homeSelected = "assets/svg/homeSelected.svg";
 static String chatSelected = "assets/svg/chatSelected.svg";
 static String chatUnselected = "assets/svg/chatUnselected.svg";
 static String upgradeUnselected = "assets/svg/upgradeUnselected.svg";
 static String upgradeSelected = "assets/svg/upgradeSelected.svg";
 static String accountUnselected = "assets/svg/accountUnselected.svg";
 static String accountSelected = "assets/svg/accountSelected.svg";
 static String navHomeBackground = "assets/svg/navHomeBackground.svg";
 static String likeIcon = 'assets/svg/like.svg';
 static String dislikeIcon = 'assets/svg/message.svg';
 static String mentalHealthIcon = 'assets/svg/mentalhealthIcon.svg';
 static String cardIcon = 'assets/svg/cardIcon.svg';
 static String recomendedIcon = 'assets/svg/recomendedIcon.svg';
 static String featuredIcon = 'assets/svg/featured.svg';
 static String categoryIcon = 'assets/svg/category.svg';
 static String searchIcon = 'assets/svg/search.svg';
 static String settingIcon = 'assets/svg/setting.svg';
 static String proIcon = 'assets/svg/pro.svg';
 static String angerIcon = 'assets/svg/anger.svg';
 static String anxiety = 'assets/svg/anxiety.svg';
 static String behaviourCircle = 'assets/svg/behaviourCircl.svg';
 static String depression = 'assets/svg/depression.svg';
 static String negativeThoughts = 'assets/svg/negativeThoughts.svg';
 static String stress = 'assets/svg/stress.svg';
 static String boatOptionsButton = 'assets/svg/boatOptionsButton.svg';
 static String similarBoatsButton = 'assets/svg/SimilarBoatsButton.svg';
static String premiumLabel= 'assets/svg/premiumLabel.svg';
static String privacyIcon= 'assets/svg/privacyIcon.svg';
static String rateAppIcon= 'assets/svg/rateAppIcon.svg';
static String shareIcon= 'assets/svg/shareSvgIcon.svg';
static String feedbackIcon= 'assets/svg/feedbackIcon.svg';
static String logoutIcon= 'assets/svg/logout.svg';


 static String duplicateBoatIcon = 'assets/svg/duplicateBoat.svg';
 static String clearTextIcon = 'assets/svg/clearText.svg';
 static String shareBoatIcon = 'assets/svg/shareBoatIcon.svg';
 static String reportBoatIcon = 'assets/svg/reportBoatIcon.svg';




 static String profileAvatar = "assets/images/profileAvatar.jpg";


 static Color navigationBarColor = Color(0xFF111111);
 static Color fontColor = Color(0xFFFFFFFF);
 static Color shadedfontColor = Color(0xFF0CF3E9);

}