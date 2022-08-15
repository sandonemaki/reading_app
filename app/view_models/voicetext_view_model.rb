class VoicetextViewModel

  class NewViewModel
    attr_reader :voicetext

    def initialize(voicetext:)
      @voicetext = voicetext
    end
  end
end

