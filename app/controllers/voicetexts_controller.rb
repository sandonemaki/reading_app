class VoicetextsController < ApplicationController
  def new
    hash = OcrApi.call_ocr_api
    read_ja(hash)
  end

  # 欧文_改行なし
  def read_english(hash)
    en_lines = hash["analyzeResult"]["readResults"][0]["lines"]#[0]["text"]
    en_line_ary = []
    en_lines.each do |line|
      en_line_ary.push(line["text"])
    end
    # print
    en_line_ary.join(" ")
  end

  # 欧文_改行あり
  def read_english_line_break(hash)
    en_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    en_line_ary = []
    en_lines.each do |line|
      # puts
      en_line_ary.push(line["text"])
    end
    en_line_ary.join("\n")
  end

  # 日本語横組み_改行なし
  def read_ja(hash)
    ja_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    ja_line_ary = []
    ja_lines.each do |line|
      ja_line_ary.push(line["text"])
    end
    # print
    ja_line_ary.join("")
  end

  # 日本語横組み_改行あり
  def read_ja_line_break(hash)
    ja_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    ja_line_ary = []
    ja_lines.each do |line|
      # puts
      ja_line_ary.push(line["text"])
    end
    ja_line_ary.join("\n")
  end

  # 日本語縦組み_改行あり
  def read_ja_vertical_line_break(hash)
    ja_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    ja_line_ary = []
    ja_lines.each do |line|
      ja_line_ary.push(line["text"])
    end
    # puts
    ja_line_ary.reverse!.("\n")
  end

  # 日本語縦組み_改行なし
  def read_ja_vertical(hash)
    ja_lines = hash["analyzeResult"]["readResults"][0]["lines"]
    ja_line_ary = []
    ja_lines.each do |line|
      ja_line_ary.push(line["text"])
    end
    # print
    ja_line_ary.reverse!.join("")
  end
end
