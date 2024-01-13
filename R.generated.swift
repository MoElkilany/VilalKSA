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
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var font: font { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var nib: nib { .init(bundle: bundle) }

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

  /// This `_R.image` struct is generated, and contains static references to 20 images.
  struct image {
    let bundle: Foundation.Bundle

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

    /// Image `Password-icon`.
    var passwordIcon: RswiftResources.ImageResource { .init(name: "Password-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Phone-icon`.
    var phoneIcon: RswiftResources.ImageResource { .init(name: "Phone-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Profile-icon`.
    var profileIcon: RswiftResources.ImageResource { .init(name: "Profile-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `QRCode`.
    var qrCode: RswiftResources.ImageResource { .init(name: "QRCode", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

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

    /// Image `show-password`.
    var showPassword: RswiftResources.ImageResource { .init(name: "show-password", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `success-verify-icon`.
    var successVerifyIcon: RswiftResources.ImageResource { .init(name: "success-verify-icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `x-circle`.
    var xCircle: RswiftResources.ImageResource { .init(name: "x-circle", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.font` struct is generated, and contains static references to 1 fonts.
  struct font: Sequence {
    let bundle: Foundation.Bundle

    /// Font `FSAlbertArabic-Bold`.
    var fsAlbertArabicBold: RswiftResources.FontResource { .init(name: "FSAlbertArabic-Bold", bundle: bundle, filename: "FSAlbertArabic-Bold.otf") }

    func makeIterator() -> IndexingIterator<[RswiftResources.FontResource]> {
      [fsAlbertArabicBold].makeIterator()
    }
    func validate() throws {
      for font in self {
        if !font.canBeLoaded() { throw RswiftResources.ValidationError("[R.swift] Font '\(font.name)' could not be loaded, is '\(font.filename)' added to the UIAppFonts array in this targets Info.plist?") }
      }
    }
  }

  /// This `_R.file` struct is generated, and contains static references to 2 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `FSAlbertArabic-Bold.otf`.
    var fsAlbertArabicBoldOtf: RswiftResources.FileResource { .init(name: "FSAlbertArabic-Bold", pathExtension: "otf", bundle: bundle, locale: LocaleReference.none) }

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