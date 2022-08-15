class VoicetextsController < ApplicationController
  def new
    if params[:image_url]
      image_url = params[:image_url]
      voicetext = OcrApi.call_ocr_api(image_url)
      new_view_model = VoicetextViewModel::NewViewModel.new(voicetext: voicetext)
      render("new", locals:{voicetext: new_view_model})
    else
      redirect_to("/")
    end
  end
end
