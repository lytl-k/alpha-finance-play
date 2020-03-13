class SectorsController < ApplicationController
  include AlphaApiHelper
  include SectorsHelper

  def index
    @sector = call(function: 'SECTOR')
    if @sector['Note']&.include?('frequency')
      @sector = []
      (flash[:notice] << 'Please wait another minute before polling the service again.').uniq!
    end
  end
end
