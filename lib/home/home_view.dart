import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../brand_colors.dart';
import '../brand_texts.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: Colors.amber,
            body: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      // color: Colors.amber,
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 50.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(MediaQuery.of(context).size.width / 2, 40.0),
                            topRight: Radius.elliptical(MediaQuery.of(context).size.width / 2, 40.0),
                          ),
                        ),
                        child: _Form(),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        viewModelBuilder: () => HomeViewModel());
  }
}

class _Form extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Form(
        child: ListView(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      children: [
        // SizedBox(height: 50.0),
        Row(
          children: [
            Expanded(
              child: _CommonTextFeild(
                hintText: "Start Date",
                enable: false,
                suffix: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _CommonTextFeild(
                hintText: "End Date",
                enable: false,
                suffix: Icon(Icons.calendar_today),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _CommonTextFeild(
                hintText: "Start Time",
                enable: false,
                suffix: Icon(Icons.timer),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _CommonTextFeild(
                hintText: "End Time",
                enable: false,
                suffix: Icon(Icons.timer),
              ),
            ),
          ],
        ),
        _CommonTextFeild(
          hintText: "Where I want to pick up?",
          suffix: Icon(Icons.search),
        ),
        SizedBox(height: 20.0),
      ],
    ));
  }
}

class _CommonTextFeild extends ViewModelWidget<HomeViewModel> {
  final String hintText;
  final String errorText;
  final bool isPhoneNumber;
  final bool enable;
  final Widget suffix;
  final int showPaswordIndex;

  _CommonTextFeild({
    @required this.hintText,
    this.isPhoneNumber = false,
    this.enable = true,
    this.errorText = "",
    this.suffix,
    this.showPaswordIndex = 0,
  });
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    // var controller = useTextEditingController();
    return Container(
      // padding: EdgeInsets.symmetric(
      //   horizontal: 50.0,
      //   vertical: 2.0,
      // ),
      // color: BrandColors.light.withOpacity(0.4),
      child: TextFormField(
        // controller: controller,
        // obscureText: isPassword ? !model.showPasswords[showPaswordIndex] : false,
        enabled: enable,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.text,
        style: BrandTexts.textStyle(
          fontWeight: BrandTexts.bold,
          color: BrandColors.dark,
        ),
        cursorColor: BrandColors.brandColorLight,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) => model.validateLoginSignUpFeilds(loginSignupEnum: loginSignupEnum, value: value),
        // onChanged: (value) => model.setFeildValue(loginSignupEnum: loginSignupEnum, value: value),
        maxLength: /* isPhoneNumber ? 10 : */ null,
        enableSuggestions: false,
        // strutStyle: StrutStyle(height: 2.0),
        decoration: InputDecoration(
          // hintText: hintText,
          // suffix: Icon(Icons.ac_unit),
          suffixIcon: suffix,
          // icon: Icon(Icons.calendar_today),
          labelText: hintText,
          labelStyle: BrandTexts.textStyle(
            fontWeight: BrandTexts.bold,
            color: BrandColors.shadow.withOpacity(0.8),
          ),
          counter: null,
          counterText: "",
          fillColor: BrandColors.light,
          filled: true,
          // prefixIcon: isPhoneNumber
          //     ? GestureDetector(
          //         onTap: () => model.showCountryCode(context),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             SizedBox(width: 12.0),
          //             App.svgImage(svg: model.selectedCounrtyCode.flag, height: 24.0, width: 24.0),
          //             SizedBox(width: 4.0),
          //             BrandTexts.commonText(
          //               text: "${model.selectedCounrtyCode.code}",
          //               fontWeight: BrandTexts.bold,
          //               color: BrandColors.dark,
          //               fontSize: 16.0,
          //             ),
          //             SizedBox(width: 4.0),
          //             SizedBox(
          //               height: 32.0,
          //               child: VerticalDivider(
          //                 thickness: 1.0,
          //                 width: 0.0,
          //               ),
          //             ),
          //             SizedBox(width: 8.0),
          //           ],
          //         ),
          //       )
          //     : null,
          helperText: "",
          helperStyle: BrandTexts.textStyle(color: BrandColors.shadow, fontSize: 9.0, height: 0.4),
          errorText: null,
          errorStyle: BrandTexts.textStyle(color: BrandColors.dangers, fontSize: 9.0, height: 1.0),
          errorMaxLines: 2,
          contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.amber,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.amber,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            /*  borderSide: BorderSide(
                color: Colors.amber,
              ) */
          ),
          // suffixIcon: isPassword
          //     ? GestureDetector(
          //         onTap: () => model.setShowPassword(index: showPaswordIndex),
          //         child: Icon(
          //           !model.showPasswords[showPaswordIndex] ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          //           color: BrandColors.shadow,
          //         ),
          //       )
          //     : SizedBox.shrink(),
        ),
      ),
    );
  }
}
