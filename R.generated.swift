//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `MockAPIResult.json`.
    static let mockAPIResultJson = Rswift.FileResource(bundle: R.hostingBundle, name: "MockAPIResult", pathExtension: "json")

    /// `bundle.url(forResource: "MockAPIResult", withExtension: "json")`
    static func mockAPIResultJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.mockAPIResultJson
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 10 images.
  struct image {
    /// Image `CloudyIcon`.
    static let cloudyIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "CloudyIcon")
    /// Image `ConnectionError`.
    static let connectionError = Rswift.ImageResource(bundle: R.hostingBundle, name: "ConnectionError")
    /// Image `DayBG`.
    static let dayBG = Rswift.ImageResource(bundle: R.hostingBundle, name: "DayBG")
    /// Image `LaunchScreenBG`.
    static let launchScreenBG = Rswift.ImageResource(bundle: R.hostingBundle, name: "LaunchScreenBG")
    /// Image `NightBG`.
    static let nightBG = Rswift.ImageResource(bundle: R.hostingBundle, name: "NightBG")
    /// Image `RainyIcon`.
    static let rainyIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "RainyIcon")
    /// Image `SnowingIcon`.
    static let snowingIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "SnowingIcon")
    /// Image `SunnyIcon`.
    static let sunnyIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "SunnyIcon")
    /// Image `cityPlaceHolder`.
    static let cityPlaceHolder = Rswift.ImageResource(bundle: R.hostingBundle, name: "cityPlaceHolder")
    /// Image `unknownWeather`.
    static let unknownWeather = Rswift.ImageResource(bundle: R.hostingBundle, name: "unknownWeather")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CloudyIcon", bundle: ..., traitCollection: ...)`
    static func cloudyIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.cloudyIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ConnectionError", bundle: ..., traitCollection: ...)`
    static func connectionError(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.connectionError, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "DayBG", bundle: ..., traitCollection: ...)`
    static func dayBG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dayBG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "LaunchScreenBG", bundle: ..., traitCollection: ...)`
    static func launchScreenBG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.launchScreenBG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "NightBG", bundle: ..., traitCollection: ...)`
    static func nightBG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.nightBG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "RainyIcon", bundle: ..., traitCollection: ...)`
    static func rainyIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.rainyIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "SnowingIcon", bundle: ..., traitCollection: ...)`
    static func snowingIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.snowingIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "SunnyIcon", bundle: ..., traitCollection: ...)`
    static func sunnyIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sunnyIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "cityPlaceHolder", bundle: ..., traitCollection: ...)`
    static func cityPlaceHolder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.cityPlaceHolder, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "unknownWeather", bundle: ..., traitCollection: ...)`
    static func unknownWeather(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.unknownWeather, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `CustomCityCell`.
    static let customCityCell = _R.nib._CustomCityCell()
    /// Nib `CustomTempDegreeCell`.
    static let customTempDegreeCell = _R.nib._CustomTempDegreeCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "CustomCityCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.customCityCell) instead")
    static func customCityCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.customCityCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "CustomTempDegreeCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.customTempDegreeCell) instead")
    static func customTempDegreeCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.customTempDegreeCell)
    }
    #endif

    static func customCityCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> CustomCityCell? {
      return R.nib.customCityCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? CustomCityCell
    }

    static func customTempDegreeCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> CustomTempDegreeCell? {
      return R.nib.customTempDegreeCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? CustomTempDegreeCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `CustomCityCell`.
    static let customCityCell: Rswift.ReuseIdentifier<CustomCityCell> = Rswift.ReuseIdentifier(identifier: "CustomCityCell")
    /// Reuse identifier `CustomTempDegreeCell`.
    static let customTempDegreeCell: Rswift.ReuseIdentifier<CustomTempDegreeCell> = Rswift.ReuseIdentifier(identifier: "CustomTempDegreeCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 3 localization tables.
  struct string {
    /// This `R.string.launchScreen` struct is generated, and contains static references to 0 localization keys.
    struct launchScreen {
      fileprivate init() {}
    }

    /// This `R.string.localizable` struct is generated, and contains static references to 18 localization keys.
    struct localizable {
      /// en translation: April
      ///
      /// Locales: nl-NL, en
      static let april = Rswift.StringResource(key: "april", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: August
      ///
      /// Locales: nl-NL, en
      static let august = Rswift.StringResource(key: "august", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: Connection error
      ///
      /// Locales: nl-NL, en
      static let connectionError = Rswift.StringResource(key: "connection error", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: December
      ///
      /// Locales: nl-NL, en
      static let december = Rswift.StringResource(key: "december", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: February
      ///
      /// Locales: nl-NL, en
      static let february = Rswift.StringResource(key: "february", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: January
      ///
      /// Locales: nl-NL, en
      static let january = Rswift.StringResource(key: "january", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: July
      ///
      /// Locales: nl-NL, en
      static let july = Rswift.StringResource(key: "july", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: June
      ///
      /// Locales: nl-NL, en
      static let june = Rswift.StringResource(key: "june", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: Loading ...
      ///
      /// Locales: nl-NL, en
      static let loading = Rswift.StringResource(key: "loading", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: Make sure of connection
      ///
      /// Locales: nl-NL, en
      static let makeSureOfConnection = Rswift.StringResource(key: "make sure of connection", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: March
      ///
      /// Locales: nl-NL, en
      static let march = Rswift.StringResource(key: "march", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: May
      ///
      /// Locales: nl-NL, en
      static let may = Rswift.StringResource(key: "may", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: November
      ///
      /// Locales: nl-NL, en
      static let november = Rswift.StringResource(key: "november", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: October
      ///
      /// Locales: nl-NL, en
      static let october = Rswift.StringResource(key: "october", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: Please make sure of connection. We are trying again
      ///
      /// Locales: nl-NL, en
      static let retryConnect = Rswift.StringResource(key: "retry connect", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: Please wait ...
      ///
      /// Locales: nl-NL, en
      static let pleaseWait = Rswift.StringResource(key: "please wait", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: September
      ///
      /// Locales: nl-NL, en
      static let september = Rswift.StringResource(key: "september", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)
      /// en translation: Unkown
      ///
      /// Locales: nl-NL, en
      static let unkown = Rswift.StringResource(key: "unkown", tableName: "Localizable", bundle: R.hostingBundle, locales: ["nl-NL", "en"], comment: nil)

      /// en translation: April
      ///
      /// Locales: nl-NL, en
      static func april(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("april", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "april"
        }

        return NSLocalizedString("april", bundle: bundle, comment: "")
      }

      /// en translation: August
      ///
      /// Locales: nl-NL, en
      static func august(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("august", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "august"
        }

        return NSLocalizedString("august", bundle: bundle, comment: "")
      }

      /// en translation: Connection error
      ///
      /// Locales: nl-NL, en
      static func connectionError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("connection error", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "connection error"
        }

        return NSLocalizedString("connection error", bundle: bundle, comment: "")
      }

      /// en translation: December
      ///
      /// Locales: nl-NL, en
      static func december(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("december", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "december"
        }

        return NSLocalizedString("december", bundle: bundle, comment: "")
      }

      /// en translation: February
      ///
      /// Locales: nl-NL, en
      static func february(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("february", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "february"
        }

        return NSLocalizedString("february", bundle: bundle, comment: "")
      }

      /// en translation: January
      ///
      /// Locales: nl-NL, en
      static func january(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("january", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "january"
        }

        return NSLocalizedString("january", bundle: bundle, comment: "")
      }

      /// en translation: July
      ///
      /// Locales: nl-NL, en
      static func july(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("july", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "july"
        }

        return NSLocalizedString("july", bundle: bundle, comment: "")
      }

      /// en translation: June
      ///
      /// Locales: nl-NL, en
      static func june(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("june", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "june"
        }

        return NSLocalizedString("june", bundle: bundle, comment: "")
      }

      /// en translation: Loading ...
      ///
      /// Locales: nl-NL, en
      static func loading(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("loading", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "loading"
        }

        return NSLocalizedString("loading", bundle: bundle, comment: "")
      }

      /// en translation: Make sure of connection
      ///
      /// Locales: nl-NL, en
      static func makeSureOfConnection(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("make sure of connection", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "make sure of connection"
        }

        return NSLocalizedString("make sure of connection", bundle: bundle, comment: "")
      }

      /// en translation: March
      ///
      /// Locales: nl-NL, en
      static func march(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("march", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "march"
        }

        return NSLocalizedString("march", bundle: bundle, comment: "")
      }

      /// en translation: May
      ///
      /// Locales: nl-NL, en
      static func may(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("may", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "may"
        }

        return NSLocalizedString("may", bundle: bundle, comment: "")
      }

      /// en translation: November
      ///
      /// Locales: nl-NL, en
      static func november(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("november", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "november"
        }

        return NSLocalizedString("november", bundle: bundle, comment: "")
      }

      /// en translation: October
      ///
      /// Locales: nl-NL, en
      static func october(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("october", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "october"
        }

        return NSLocalizedString("october", bundle: bundle, comment: "")
      }

      /// en translation: Please make sure of connection. We are trying again
      ///
      /// Locales: nl-NL, en
      static func retryConnect(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("retry connect", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "retry connect"
        }

        return NSLocalizedString("retry connect", bundle: bundle, comment: "")
      }

      /// en translation: Please wait ...
      ///
      /// Locales: nl-NL, en
      static func pleaseWait(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("please wait", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "please wait"
        }

        return NSLocalizedString("please wait", bundle: bundle, comment: "")
      }

      /// en translation: September
      ///
      /// Locales: nl-NL, en
      static func september(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("september", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "september"
        }

        return NSLocalizedString("september", bundle: bundle, comment: "")
      }

      /// en translation: Unkown
      ///
      /// Locales: nl-NL, en
      static func unkown(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("unkown", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "unkown"
        }

        return NSLocalizedString("unkown", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    /// This `R.string.main` struct is generated, and contains static references to 1 localization keys.
    struct main {
      /// nl-NL translation: Amsterdam
      ///
      /// Locales: nl-NL
      static let iCoXBWVgText = Rswift.StringResource(key: "iCo-XB-wVg.text", tableName: "Main", bundle: R.hostingBundle, locales: ["nl-NL"], comment: nil)

      /// nl-NL translation: Amsterdam
      ///
      /// Locales: nl-NL
      static func iCoXBWVgText(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("iCo-XB-wVg.text", tableName: "Main", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Main", preferredLanguages: preferredLanguages) else {
          return "iCo-XB-wVg.text"
        }

        return NSLocalizedString("iCo-XB-wVg.text", tableName: "Main", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _CustomCityCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = CustomCityCell

      let bundle = R.hostingBundle
      let identifier = "CustomCityCell"
      let name = "CustomCityCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> CustomCityCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? CustomCityCell
      }

      fileprivate init() {}
    }

    struct _CustomTempDegreeCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = CustomTempDegreeCell

      let bundle = R.hostingBundle
      let identifier = "CustomTempDegreeCell"
      let name = "CustomTempDegreeCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> CustomTempDegreeCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? CustomTempDegreeCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "LaunchScreenBG", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'LaunchScreenBG' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let citiesListViewController = StoryboardViewControllerResource<CitiesListViewController>(identifier: "CitiesListViewController")
      let cityDetailsViewController = StoryboardViewControllerResource<CityDetailsViewController>(identifier: "CityDetailsViewController")
      let name = "Main"
      let splashViewController = StoryboardViewControllerResource<SplashViewController>(identifier: "SplashViewController")

      func citiesListViewController(_: Void = ()) -> CitiesListViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: citiesListViewController)
      }

      func cityDetailsViewController(_: Void = ()) -> CityDetailsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: cityDetailsViewController)
      }

      func splashViewController(_: Void = ()) -> SplashViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: splashViewController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "LaunchScreenBG", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'LaunchScreenBG' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "NightBG", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'NightBG' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().citiesListViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'citiesListViewController' could not be loaded from storyboard 'Main' as 'CitiesListViewController'.") }
        if _R.storyboard.main().cityDetailsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'cityDetailsViewController' could not be loaded from storyboard 'Main' as 'CityDetailsViewController'.") }
        if _R.storyboard.main().splashViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'splashViewController' could not be loaded from storyboard 'Main' as 'SplashViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
