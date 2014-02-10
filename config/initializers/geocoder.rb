Geocoder.configure(
  # geocoding service (see below for supported options):
  :lookup => :google, # Free, 2500 requests/day
  # :lookup => :nominatim, # To use OpenstreetMap Free, 1 request/s

  # Language
  :langage => :fr,

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,
)