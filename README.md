EMCCountryPickerController
==========================

`EMCCountryPickerController` is a view controller that allow users to choose
a country from a searchable list.  The available countries are taken from the
[ISO 3166-1 standard][iso3166], whose [ISO 3166-1 alpha-2][iso31662] two-letter
country codes are used by the API to represent countries.

[iso3166]: http://en.wikipedia.org/wiki/ISO_3166
[iso31662]: http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2

Features
--------

This library provides the following features:

  * A country can be selected from a list in a table view.
  * The list can be searched using a search bar.
  * Country flags are displayed in the image view of a table cell and can
    optionally be hidden.
  * The flag border color and size can be customised and optionally hidden.
  * All the countries assigned a [ISO 3166-1 alpha-2][iso31662] two-letter code
    are available.
  * The list of countries presented by the controller can be filtered.
  * The following localisations are available:
    - English (en).
    - Italian (it).
    - Spanish (es).

The anatomy of the view presented by `EMCCountryPickerController` is the
following:

  * A search bar is anchored to the bottom of the top layout guide.
  * A table view is anchored to the bottom of the search bar and to the top of
    the bottom layout guide.
  * The view is a full screen view designed to be presented modally.

The table view presents the list of countries, sorted by name, in the current
language of the user, if available, or in English.  A public domain image of
a country's flag is shown at the left of the country name.

![Main view with flags](/Screenshots/main-view-with-flags.png "Main View with Flags")

Prerequisites
-------------

This library has been built with XCode 5.1.1 using iOS 7.1 as a build target.
The library is expected to work down to iOS 6 but it has not been tested with
any target older than iOS 7.0.

This library requires [ARC][arc] (_Automatic Reference Counting_) and
compilation will fail if ARC support is not available.

[arc]: http://en.wikipedia.org/wiki/Automatic_Reference_Counting

Usage
-----

The `EMCCountryPickerController` must be presented modally by the presenting
view controller.  The `EMCCountryPickerController` won't dismiss itself when a
country is chosen.  Instead, `EMCCountryPickerController` instance will rely on
a delegate conforming to the `EMCCountryDelegate` protocol to receive the
country selection event and to dismiss it.  The delegate can be set either in
Interface Builder using the `countryDelegate` outlet or programmatically using
the `countryDelegate` property.  When using a storyboard, since an outlet
cannot be connected to a controller in another controller, the controller setup
is usually performed in `prepareForSegue:sender:`:

```
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openCountryPicker"])
    {
        EMCCountryPickerController *countryPicker = segue.destinationViewController;
        countryPicker.countryDelegate = self;
    }
}
```

The `EMCCountryDelegate` protocol defines one selector which is invoked when a
country has been selected:

```
- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry;
```

The presenting view controller usually conforms to this protocol, receives the
notification and dismisses the `EMCCountryPickerController` instance:

```
- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry;
{
    // Do something with chosenCountry
    [self dismissViewControllerAnimated:YES completion:nil];
}
```

Searching Countries
-------------------

The view provides a search bar that can be used to filter countries _by name_,
as shown in the following screenshot.

![Main view](/Screenshots/main-view-search.png "Main View - Search")

Showing and Hiding Flags
------------------------

Flags are shown by default and can be disabled using the property
`BOOL showFlags`.

![Main view](/Screenshots/main-view.png "Main View")

Flag Borders
------------

By default a grey .5 border is drawn around a flag in order to improve its
visual appearance over the default white background.  The border can be
configured using the following properties:

  * `BOOL drawFlagBorder`: enables the flag border. Defaults to `YES`.
  * `UIColor *flagBorderColor`: sets the border color. Defaults to
    `[UIColor grayColor]`.
  * `CGFloat flagBorderWidth`: sets the border width. Defaults to `0.5f`.

Localised Country Names
-----------------------

The `EMCCountryPickerController` library ships with localised country names in:

  * English (en).
  * Italian (it).
  * Spanish (es).

Support for additional languages can be easily added by updating the
`countries.plist` file.

The current implementation selects the locale using the following algorithm:

  * If the `countryNameDisplayLocale` property of the view controller instance
    is set and not null, then a country name in the specified locale will be
    requested.
  * If a translation in the `countryNameDisplayLocale` locale is not available
    or it is null, then a translation in the first preferred locale will be
    requested, where the preferred locale is obtained using
    `[[NSLocale preferredLanguages] objectAtIndex:0]`.
  * If a translation in the preferred locale is not available, use English.

Demo Code
---------

A demo project named `EMCCountryPickerControllerDemo` using a storyboard and
highlighting the library major features is shipped with the library code.

Installation with CocoaPods
---------------------------

`EMCCountryPickerController` is available through [CocoaPods][cocoapods] and a
dependency to it can be added to your Podfile:

    pod 'EMCCountryPickerController' ~> '1.0'

[cocoapods]: http://cocoapods.org

Build the Software
------------------

The recommended way to get the sources of `EMCCountryPickerController` in order
to build it on your system is getting a [release tarball][release].

[release]: https://github.com/emcrisostomo/EMCCountryPickerController/releases

Bug Reports
-----------

Bug reports can be opened at the [official GitHub repository][cp].

[cp]: https://github.com/emcrisostomo/EMCCountryPickerController

----
Copyright (c) 2014, Enrico Maria Crisostomo
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the {organization} nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
