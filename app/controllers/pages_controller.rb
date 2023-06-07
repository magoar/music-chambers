class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    input_text = "I can pass this argument to python now!"
    @hello_world = `python3 lib/assets/python/hello_world.py "#{input_text}"`
  end
end
