## 1.2.1

* Updated dependencies

## 1.2.0

* Removed `bloc` and provider `dependencies`
* Changed FeatureManager initialization. Now it's required to call `FeatureManager.initialize()` function to provide `sharePreferences` for `FeatureManager`. Otherwise it would crash.

## 1.1.2

* Upgraded Dart and Flutter versions

## 1.1.1

* Updated Readme

## 1.1.0

* BREAKING: now you need to provide SharedPreferences instance to create feature manager
* Added sync calls for FeatureManager
* Added additional getters for FeatureManger
* Added json type for Feature

## 1.0.0

* Initial release of Feature Manager
