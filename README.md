EMCCountryPickerController
==========================

`EMCCountryPickerController` is a view controller that allow users to choose
a country from a searchable list.  The available countries are taken from the
[ISO 3166-1 standard][iso3166], whose [ISO 3166-1 alpha-2] two-letter country
codes are used internally by the controller implementation.

[iso3166]: http://en.wikipedia.org/wiki/ISO_3166
[iso31662]: http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2

Features
--------

The anatomy of the view presented by `EMCCountryPickerController` is the
following:

  * A search bar is anchored to the bottom of the top layout guide.
  * A table view is anchored to the bottom of the search bar and to the top of
    the bommom layout guide.
  * The view is a full screen view designed to be presented modally.

The table view presents the list of countries, sorted by name, in the current
language of the user, if available, or in English.  A public domain image of
a country's flag is shown at the left of the country name.

![Main view](/Screenshots/main-view.png "Main View")
![Main view with flags](/Screenshots/main-view-with-flags.png "Main View with Flags")
