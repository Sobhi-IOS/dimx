import 'package:dimax/get/app_locale.dart';
import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/app/address_screen.dart';
import 'package:dimax/ui/screens/app/condation_screen.dart';
import 'package:dimax/ui/screens/app/favorite_screen.dart';
import 'package:dimax/ui/screens/app/order_screen.dart';
import 'package:dimax/ui/screens/app/policy_screen.dart';
import 'package:dimax/ui/screens/auth/change_password_screen.dart';
import 'package:dimax/ui/screens/auth/contact_us_screen.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:dimax/ui/screens/auth/remove_account.dart';
import 'package:dimax/ui/screens/auth/update_user_profile_screen.dart';
import 'package:dimax/ui/screens/bn_screen/home_screen.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: SharedPreferencesController().loggedIn,
              child: Padding(
                padding: EdgeInsets.only(top: 25.h, bottom: 15.h),
                child: AppTextWidget(
                  content: 'account'.tr,
                  color: Colors.black,
                  fontSize: 15,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Visibility(
              visible: SharedPreferencesController().loggedIn,
              child: SettingWidget(
                  label: 'edit_profile'.tr,
                  leading: Icon(Icons.person_outline,size: 25.h,),
                  onTap: () => Get.to(const UpdateUserProfile())

              ),
            ),

            Visibility(
              visible: SharedPreferencesController().loggedIn,
              child: SettingWidget(
                label: 'change_password'.tr,
                leading: Icon(Icons.lock_outline,size: 25.h),
                onTap: ()=> Get.to(const ChangePasswordScreen()),
              ),
            ),



            Visibility(
              visible: SharedPreferencesController().loggedIn,
              child: SettingWidget(
                label: 'my_address'.tr,
                leading: Icon(Icons.location_on_outlined,size: 25.h),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => Get.to(const AddressScreen()),
              ),
            ),

            Visibility(
              visible: SharedPreferencesController().loggedIn,
              child: SettingWidget(
                label: 'order'.tr,
                leading: Icon(Icons.bookmark_border,size: 25.h),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => Get.to(const OrderScreen()),
              ),
            ),


            Visibility(
              child: SettingWidget(
                label: 'favorite'.tr,
                leading: Icon(Icons.favorite_border,size: 25.h),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => Get.to(FavoriteScreen()),
              ),
              visible: SharedPreferencesController().loggedIn,
            ),


            Padding(
              padding: EdgeInsets.only(top: 25.h, bottom: 15.h),
              child: AppTextWidget(
                content: 'general'.tr,
                color: Colors.black,
                fontSize: 15,
                textAlign: TextAlign.center,
              ),
            ),

            SettingWidget(
              label: 'language'.tr,
              leading: Icon(Icons.language_outlined,size: 25.h),
              trailingIcon: Icons.arrow_forward_ios,
              onTap: ()async{
                AppLocale.changeLang();
              },
            ),

            SettingWidget(
              label: 'contact_us'.tr,
              leading: Icon(Icons.info_outline,size: 25.h),
              trailingIcon: Icons.arrow_forward_ios,
              onTap: ()=> Get.to(const ContactUsScreen()),
            ),

            SettingWidget(
              label: 'policy_policies'.tr,
              leading:  Icon(Icons.security,size: 25.h),
              trailingIcon: Icons.arrow_forward_ios,
              onTap:(){Get.to(PolicyScreen());},
            ),
            SettingWidget(
              label: 'terms_and_conditions'.tr,
              leading:  Icon(Icons.security,size: 25.h),
              trailingIcon: Icons.arrow_forward_ios,
              onTap:(){Get.to(CondationScreen());},

            ),

            Visibility(
              visible: SharedPreferencesController().loggedIn,
              child: SettingWidget(
                  label: 'remove_account'.tr,
                  leading:  Icon(Icons.delete,size: 25.h),
                  onTap: () =>Get.to(const RemoveAccountScreen())
              ),
            ),

            Visibility(
              visible: SharedPreferencesController().loggedIn,
              child: SettingWidget(
                  label: 'logout'.tr,
                  leading:  Icon(Icons.logout,size: 25.h),
                  onTap: () async {
                    bool status = await AuthGetController.to.logout();
                    if(status){
                      Get.offAll(const MainScreen());
                    }
                  }
              ),
              replacement: SettingWidget(
                  label: 'login'.tr,
                  leading: const Icon(Icons.logout),
                  onTap: () =>Get.to(const LoginScreen())
              ),
            ),
          ],
        ),
      ),
    );
  }
}
