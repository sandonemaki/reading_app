class VoicetextsController < ApplicationController
  def new
    hash = OcrApi.call_ocr_api
  end
end
