class OcrApi
  require 'net/http'
  require 'uri'
  require 'json'

secret_ary = []
File.open("app/api/secret_read.rb") do |f|
  f.each do |line|
    secret_ary.push(line)
  end
end
KEY = JSON.parse(secret_ary[0])["Ocp-Apim-Subscription-Key"]
ENDPOINT_URI_PATH = JSON.parse(secret_ary[1])["ENDPOINT_URI_PATH"]

  def self.call_ocr_api(image_url)
    @image_url = image_url
    uri = URI(ENDPOINT_URI_PATH)
    uri.query = URI.encode_www_form({
      # Request parameters
      'language' => 'ja',
      'pages' => '1',
      'readingOrder' => 'natural',
      'model-version' => 'latest'
    })

    request = Net::HTTP::Post.new(uri.request_uri)
    # Request headers
    request['Content-Type'] = 'application/json'
    # Request headers
    request['Ocp-Apim-Subscription-Key'] = KEY
    # Request body
    request.body = "{\"url\":\"#{@image_url}\"}"
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    if response.code == '202'
      operation_location = response['Operation-Location']
      # puts '1秒待機は必須...'
      sleep(1.0)
      get_result(operation_location)
    else
      return 'OCRの呼び出しに失敗しました'
    end
  end

  def self.get_result(operation_location)
    uri = URI(operation_location)
    uri.query = URI.encode_www_form({
    })
    request = Net::HTTP::Get.new(uri.request_uri)
    # Request headers
    request['Ocp-Apim-Subscription-Key'] = KEY
    # Request body
    request.body = "{\"url\":\"#{@image_url}\"}"

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    if response.code == '200'
      hash = JSON.parse(response.body)
      return read_ja(hash)
    else
      return "テキストデータへの変換に失敗しました #{response.code}"
    end
  end

  ## テキストへの整形処理
  # 欧文_改行なし
  def self.read_english(hash)
    en_lines = hash["analyzeResult"]["readResults"][0]["lines"]#[0]["text"]
    en_line_ary = []
    en_lines.each do |line|
      en_line_ary.push(line["text"])
    end
    # print
    en_line_ary.join(" ")
  end

  # 欧文_改行あり
  def self.read_english_line_break(hash)
    en_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    en_line_ary = []
    en_lines.each do |line|
      # puts
      en_line_ary.push(line["text"])
    end
    en_line_ary.join("\n")
  end

  # 日本語横組み_改行なし
  def self.read_ja(hash)
    ja_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    ja_line_ary = []
    ja_lines.each do |line|
      ja_line_ary.push(line["text"])
    end
    # print
    ja_line_ary.join("")
  end

  # 日本語横組み_改行あり
  def self.read_ja_line_break(hash)
    ja_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    ja_line_ary = []
    ja_lines.each do |line|
      # puts
      ja_line_ary.push(line["text"])
    end
    ja_line_ary.join("\n")
  end

  # 日本語縦組み_改行あり
  def self.read_ja_vertical_line_break(hash)
    ja_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    ja_line_ary = []
    ja_lines.each do |line|
      ja_line_ary.push(line["text"])
    end
    # puts
    ja_line_ary.reverse!.("\n")
  end

  # 日本語縦組み_改行なし
  def self.read_ja_vertical(hash)
    ja_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    ja_line_ary = []
    ja_lines.each do |line|
      ja_line_ary.push(line["text"])
    end
    # print
    ja_line_ary.reverse!.join("")
  end
end
