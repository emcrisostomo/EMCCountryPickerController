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