//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var font: font { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var nib: nib { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func font(bundle: Foundation.Bundle) -> font {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
    .init(bundle: bundle)
  }
  func nib(bundle: Foundation.Bundle) -> nib {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.font.validate()
    try self.nib.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var localizable: localizable { .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale)) }

    func localizable(preferredLanguages: [String]) -> localizable {
      .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.localizable` struct is generated, and contains static references to 20 localization keys.
    struct localizable {
      let source: RswiftResources.StringResource.Source

      /// en translation: Add
      ///
      /// Key: Add
      ///
      /// Locales: en, ar
      var add: RswiftResources.StringResource { .init(key: "Add", tableName: "Localizable", source: source, developmentValue: "Add", comment: nil) }

      /// en translation: Create New Account
      ///
      /// Key: Create_New_Account
      ///
      /// Locales: en, ar
      var create_New_Account: RswiftResources.StringResource { .init(key: "Create_New_Account", tableName: "Localizable", source: source, developmentValue: "Create New Account", comment: nil) }

      /// en translation: Don't have an account?
      ///
      /// Key: Dont_Have_Account
      ///
      /// Locales: en, ar
      var dont_Have_Account: RswiftResources.StringResource { .init(key: "Dont_Have_Account", tableName: "Localizable", source: source, developmentValue: "Don't have an account?", comment: nil) }

      /// en translation: No Data Found
      ///
      /// Key: Empty_No_Result_Found
      ///
      /// Locales: en, ar
      var empty_No_Result_Found: RswiftResources.StringResource { .init(key: "Empty_No_Result_Found", tableName: "Localizable", source: source, developmentValue: "No Data Found", comment: nil) }

      /// en translation: There are no results at the moment, the results will appear here
      ///
      /// Key: Empty_No_Result_Found_Description
      ///
      /// Locales: en, ar
      var empty_No_Result_Found_Description: RswiftResources.StringResource { .init(key: "Empty_No_Result_Found_Description", tableName: "Localizable", source: source, developmentValue: "There are no results at the moment, the results will appear here", comment: nil) }

      /// en translation: Enter the phone number
      ///
      /// Key: Enter_Phone_Number
      ///
      /// Locales: en, ar
      var enter_Phone_Number: RswiftResources.StringResource { .init(key: "Enter_Phone_Number", tableName: "Localizable", source: source, developmentValue: "Enter the phone number", comment: nil) }

      /// en translation: Enter your mobile number
      ///
      /// Key: Enter_Your_Phone
      ///
      /// Locales: en, ar
      var enter_Your_Phone: RswiftResources.StringResource { .init(key: "Enter_Your_Phone", tableName: "Localizable", source: source, developmentValue: "Enter your mobile number", comment: nil) }

      /// en translation: Please enter password
      ///
      /// Key: Error_Password_Required
      ///
      /// Locales: en, ar
      var error_Password_Required: RswiftResources.StringResource { .init(key: "Error_Password_Required", tableName: "Localizable", source: source, developmentValue: "Please enter password", comment: nil) }

      /// en translation: Please enter phone number
      ///
      /// Key: Error_Phone_Required
      ///
      /// Locales: en, ar
      var error_Phone_Required: RswiftResources.StringResource { .init(key: "Error_Phone_Required", tableName: "Localizable", source: source, developmentValue: "Please enter phone number", comment: nil) }

      /// en translation: Did you forget your password?
      ///
      /// Key: Forget_Password
      ///
      /// Locales: en, ar
      var forget_Password: RswiftResources.StringResource { .init(key: "Forget_Password", tableName: "Localizable", source: source, developmentValue: "Did you forget your password?", comment: nil) }

      /// en translation: Loading...
      ///
      /// Key: Loading
      ///
      /// Locales: en, ar
      var loading: RswiftResources.StringResource { .init(key: "Loading", tableName: "Localizable", source: source, developmentValue: "Loading...", comment: nil) }

      /// en translation: Login
      ///
      /// Key: Login
      ///
      /// Locales: en, ar
      var login: RswiftResources.StringResource { .init(key: "Login", tableName: "Localizable", source: source, developmentValue: "Login", comment: nil) }

      /// en translation: Main
      ///
      /// Key: Main
      ///
      /// Locales: en, ar
      var main: RswiftResources.StringResource { .init(key: "Main", tableName: "Localizable", source: source, developmentValue: "Main", comment: nil) }

      /// en translation: Messages
      ///
      /// Key: Messages
      ///
      /// Locales: en, ar
      var messages: RswiftResources.StringResource { .init(key: "Messages", tableName: "Localizable", source: source, developmentValue: "Messages", comment: nil) }

      /// en translation: Account
      ///
      /// Key: MyAccount
      ///
      /// Locales: en, ar
      var myAccount: RswiftResources.StringResource { .init(key: "MyAccount", tableName: "Localizable", source: source, developmentValue: "Account", comment: nil) }

      /// en translation: Entert the password
      ///
      /// Key: Password
      ///
      /// Locales: en, ar
      var password: RswiftResources.StringResource { .init(key: "Password", tableName: "Localizable", source: source, developmentValue: "Entert the password", comment: nil) }

      /// en translation: An error occurred while accessing the data, please try again
      ///
      /// Key: Please_Try_Again
      ///
      /// Locales: en, ar
      var please_Try_Again: RswiftResources.StringResource { .init(key: "Please_Try_Again", tableName: "Localizable", source: source, developmentValue: "An error occurred while accessing the data, please try again", comment: nil) }

      /// en translation: Services
      ///
      /// Key: Services
      ///
      /// Locales: en, ar
      var services: RswiftResources.StringResource { .init(key: "Services", tableName: "Localizable", source: source, developmentValue: "Services", comment: nil) }

      /// en translation: Something went wrong
      ///
      /// Key: Something_Wrong
      ///
      /// Locales: en, ar
      var something_Wrong: RswiftResources.StringResource { .init(key: "Something_Wrong", tableName: "Localizable", source: source, developmentValue: "Something went wrong", comment: nil) }

      /// en translation: Try again
      ///
      /// Key: Try_Again
      ///
      /// Locales: en, ar
      var try_Again: RswiftResources.StringResource { .init(key: "Try_Again", tableName: "Localizable", source: source, developmentValue: "Try again", comment: nil) }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 10 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `Color172B4D`.
    var color172B4D: RswiftResources.ColorResource { .init(name: "Color172B4D", path: [], bundle: bundle) }

    /// Color `Color42526E`.
    var color42526E: RswiftResources.ColorResource { .init(name: "Color42526E", path: [], bundle: bundle) }

    /// Color `Color7A869A`.
    var color7A869A: RswiftResources.ColorResource { .init(name: "Color7A869A", path: [], bundle: bundle) }

    /// Color `ColorBBC1CE`.
    var colorBBC1CE: RswiftResources.ColorResource { .init(name: "ColorBBC1CE", path: [], bundle: bundle) }

    /// Color `ColorF5F5F5`.
    var colorF5F5F5: RswiftResources.ColorResource { .init(name: "ColorF5F5F5", path: [], bundle: bundle) }

    /// Color `ColorF7F8F8`.
    var colorF7F8F8: RswiftResources.ColorResource { .init(name: "ColorF7F8F8", path: [], bundle: bundle) }

    /// Color `ColorF8B945`.
    var colorF8B945: RswiftResources.ColorResource { .init(name: "ColorF8B945", path: [], bundle: bundle) }

    /// Color `ColorFD4343`.
    var colorFD4343: RswiftResources.ColorResource { .init(name: "ColorFD4343", path: [], bundle: bundle) }

    /// Color `ColorPrimary`.
    var colorPrimary: RswiftResources.ColorResource { .init(name: "ColorPrimary", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 29 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `Add`.
    var add: RswiftResources.ImageResource { .init(name: "Add", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Apple-icon`.
    var appleIcon: RswiftResources.ImageResource { .init(name: "Apple-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Chat`.
    var chat: RswiftResources.ImageResource { .init(name: "Chat", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `City-life-icon`.
    var cityLifeIcon: RswiftResources.ImageResource { .init(name: "City-life-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `DropDown_icon`.
    var dropDown_icon: RswiftResources.ImageResource { .init(name: "DropDown_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Google-icon`.
    var googleIcon: RswiftResources.ImageResource { .init(name: "Google-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `No-wifi`.
    var noWifi: RswiftResources.ImageResource { .init(name: "No-wifi", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `NoInternet`.
    var noInternet: RswiftResources.ImageResource { .init(name: "NoInternet", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `NoResult`.
    var noResult: RswiftResources.ImageResource { .init(name: "NoResult", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Password-icon`.
    var passwordIcon: RswiftResources.ImageResource { .init(name: "Password-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Phone-icon`.
    var phoneIcon: RswiftResources.ImageResource { .init(name: "Phone-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Profile-icon`.
    var profileIcon: RswiftResources.ImageResource { .init(name: "Profile-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Success_Ads`.
    var success_Ads: RswiftResources.ImageResource { .init(name: "Success_Ads", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Sucess`.
    var sucess: RswiftResources.ImageResource { .init(name: "Sucess", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `back_button_left_icon`.
    var back_button_left_icon: RswiftResources.ImageResource { .init(name: "back_button_left_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `back_button_right_icon`.
    var back_button_right_icon: RswiftResources.ImageResource { .init(name: "back_button_right_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `checkmark_Success`.
    var checkmark_Success: RswiftResources.ImageResource { .init(name: "checkmark_Success", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `email-icon`.
    var emailIcon: RswiftResources.ImageResource { .init(name: "email-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `facebook-icon`.
    var facebookIcon: RswiftResources.ImageResource { .init(name: "facebook-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `hide-password-icon`.
    var hidePasswordIcon: RswiftResources.ImageResource { .init(name: "hide-password-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `house-searchin-icon`.
    var houseSearchinIcon: RswiftResources.ImageResource { .init(name: "house-searchin-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `logo-icon`.
    var logoIcon: RswiftResources.ImageResource { .init(name: "logo-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `main`.
    var main: RswiftResources.ImageResource { .init(name: "main", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `message`.
    var message: RswiftResources.ImageResource { .init(name: "message", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `profile`.
    var profile: RswiftResources.ImageResource { .init(name: "profile", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `services`.
    var services: RswiftResources.ImageResource { .init(name: "services", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `show-password`.
    var showPassword: RswiftResources.ImageResource { .init(name: "show-password", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `success-verify-icon`.
    var successVerifyIcon: RswiftResources.ImageResource { .init(name: "success-verify-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `x-circle`.
    var xCircle: RswiftResources.ImageResource { .init(name: "x-circle", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.font` struct is generated, and contains static references to 6 fonts.
  struct font: Sequence {
    let bundle: Foundation.Bundle

    /// Font `Cairo-Bold`.
    var cairoBold: RswiftResources.FontResource { .init(name: "Cairo-Bold", bundle: bundle, filename: "Cairo-Bold.ttf") }

    /// Font `Cairo-ExtraBold`.
    var cairoExtraBold: RswiftResources.FontResource { .init(name: "Cairo-ExtraBold", bundle: bundle, filename: "Cairo-ExtraBold.ttf") }

    /// Font `Cairo-Light`.
    var cairoLight: RswiftResources.FontResource { .init(name: "Cairo-Light", bundle: bundle, filename: "Cairo-Light.ttf") }

    /// Font `Cairo-Medium`.
    var cairoMedium: RswiftResources.FontResource { .init(name: "Cairo-Medium", bundle: bundle, filename: "Cairo-Medium.ttf") }

    /// Font `Cairo-Regular`.
    var cairoRegular: RswiftResources.FontResource { .init(name: "Cairo-Regular", bundle: bundle, filename: "Cairo-Regular.ttf") }

    /// Font `Cairo-SemiBold`.
    var cairoSemiBold: RswiftResources.FontResource { .init(name: "Cairo-SemiBold", bundle: bundle, filename: "Cairo-SemiBold.ttf") }

    func makeIterator() -> IndexingIterator<[RswiftResources.FontResource]> {
      [cairoBold, cairoExtraBold, cairoLight, cairoMedium, cairoRegular, cairoSemiBold].makeIterator()
    }
    func validate() throws {
      for font in self {
        if !font.canBeLoaded() { throw RswiftResources.ValidationError("[R.swift] Font '\(font.name)' could not be loaded, is '\(font.filename)' added to the UIAppFonts array in this targets Info.plist?") }
      }
    }
  }

  /// This `_R.file` struct is generated, and contains static references to 7 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `Cairo-Bold.ttf`.
    var cairoBoldTtf: RswiftResources.FileResource { .init(name: "Cairo-Bold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Cairo-ExtraBold.ttf`.
    var cairoExtraBoldTtf: RswiftResources.FileResource { .init(name: "Cairo-ExtraBold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Cairo-Light.ttf`.
    var cairoLightTtf: RswiftResources.FileResource { .init(name: "Cairo-Light", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Cairo-Medium.ttf`.
    var cairoMediumTtf: RswiftResources.FileResource { .init(name: "Cairo-Medium", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Cairo-Regular.ttf`.
    var cairoRegularTtf: RswiftResources.FileResource { .init(name: "Cairo-Regular", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Cairo-SemiBold.ttf`.
    var cairoSemiBoldTtf: RswiftResources.FileResource { .init(name: "Cairo-SemiBold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `ReadMee.md`.
    var readMeeMd: RswiftResources.FileResource { .init(name: "ReadMee", pathExtension: "md", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    let bundle: Foundation.Bundle

    /// Nib `LoadingView`.
    var loadingView: RswiftResources.NibReference<LoadingView> { .init(name: "LoadingView", bundle: bundle) }

    func validate() throws {
      if UIKit.UIColor(named: "StateViewBackground", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Color named 'StateViewBackground' is used in nib 'LoadingView', but couldn't be loaded.") }
    }
  }
}