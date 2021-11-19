require "rspec"
require_relative "../app/methods"

describe rl_str_gen do

  it "should return a string" do
    1000.times do
      expect(rl_str_gen).to be_an_instance_of(String)
    end
  end


  it "should not only valid symbols" do
    1000.times do
      expect(rl_str_gen.match?(/[^ а-яё,\.:\-!\?\'\";]/i)).to be false
    end
  end


  it "should not be over 300 symbols" do
    100_000.times do
      expect(rl_str_gen.size).to be <= 300
    end
  end


  it "should contain from 2 to 15 words" do
    1000.times do
      str = rl_str_gen
      expect(str.size).to be <= 300
      expect(str.gsub("- ", "").match?(/\A(?:[^ ]+ ){1,14}[^ ]+\z/)).to be true
    end
  end


  it "should not contain words ower 15 letters" do
    1000.times do
      words = rl_str_gen.scan(/[а-яё]+(?:-[а-яё]+)?/i)
      expect(words.count { |el| el.size > 15 }).to eq(0)
    end
  end


  it "should allow only particular signs after words with in sentence" do
    1000.times do
      with_in = rl_str_gen.split.reject { |el| el == "-" }[0..-2]
      expect(with_in.reject { |el| el.match? /[а-яё][\'\"]?[,:;]?\z/i }
                    .size)
                    .to eq(0)
    end
  end


  it "should allow only particular signs in the end of this sentence" do
    1000.times do
      expect(rl_str_gen.match? (/.*[а-яё]+[\'\"]?(\.|!|\?|!\?|\.\.\.)\z/))
                       .to be true
    end
  end


  it "should not allow unwanted symbols inside words" do
    1000.times do
      expect(rl_str_gen.match? (/[а-яё-][^а-яё -]+[а-яё-]/)).to be false
    end
  end


  it "should not allow multiple dashes" do

  end


  it "should exclude unwanted simbols before words" do
    1000.times do
      expect(rl_str_gen.match? (/(?<![а-яё])[^ \'\"а-яё]+\b[а-яё]/i))
                       .to be false
    end
  end

end
