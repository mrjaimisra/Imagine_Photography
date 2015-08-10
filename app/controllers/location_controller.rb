require 'net/http'
class LocationController < ApplicationController
  def check_zipcode
    uri = URI("https://www.zipcodeapi.com/rest/q4wC4x8EnBskPuMTz2qrSYKvOG64nnaNsGpwexaB9CWY7JSGLi7EgS95zf9WDkJ5/distance.json/80304/#{params[:location][:ZipCode]}/mile")
    distance = Net::HTTP.get(uri)
    if Location.success_or_fail(distance)
      flash[:success] = "We deliver in your area!"
    else
      flash[:warning] = "We unfortunately do not deliver in your area."
    end
    redirect_to :back
  end
end
