Pod::Spec.new do |s|
  s.name         = "EMCCountryPickerController"
  s.version      = "1.3.4"
  s.summary      = "EMCCountryPickerController is a view controller allowing users to choose and filter countries in a list."
  s.description  = <<-DESC
                   `EMCCountryPickerController` is a view controller that allow users to choose
                   a country from a searchable list.  The available countries are taken from the
                   [ISO 3166-1 standard][iso3166], whose [ISO 3166-1 alpha-2] two-letter country
                   codes are used internally by the controller implementation.  Public domain
                   flags are available for every country.
                   DESC
  s.homepage     = "https://github.com/emcrisostomo/EMCCountryPickerController"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author             = { "Enrico M. Crisostomo" => "http://thegreyblog.blogspot.com/" }
  s.social_media_url   = "http://thegreyblog.blogspot.com"
  s.platform     = :ios, "6.1"
  s.source       = { :git => "https://github.com/emcrisostomo/EMCCountryPickerController.git", :tag => "1.3.3" }
  s.source_files  = "EMCCountryPickerController", "EMCCountryPickerController/**/*.{h,m}"
  s.exclude_files = "EMCCountryPickerController/Exclude"
  s.resources = "EMCCountryPickerController/EMCCountryPickerController.bundle"
  s.requires_arc = true
end
