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
      expect(rl_str_gen.match(/[^ а-яё,\.:\-!\?\";]/i)).to be_nil
    end
  end


  it "should not be over 300 symbols" do
    10_000.times do
      expect(rl_str_gen.size).to be <= 300
    end
  end


  it "should contain from 2 to 15 words" do
    1000.times do
      str = rl_str_gen
      expect(str.size).to be <= 300
      expect(str.gsub("- ", "").match?(/\A *(?:[^ ]+ +){1,14}[^ ]+ *\z/)).to be true
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
      expect(with_in.reject { |el| el.match? /[а-яё]\"?[,:;]?\z/i }
                    .size)
                    .to eq(0)
    end
  end


  it "should allow only particular signs in the end of this sentence" do
    1000.times do
      expect(rl_str_gen.match?(/.*[а-яё]+\"?(\.|!|\?|!\?|\.\.\.)\z/))
                       .to be true
    end
  end


  it "should not allow unwanted symbols inside words" do
    1000.times do
      expect(rl_str_gen.match(/[а-яё-][^а-яё -]+[а-яё-]/i)).to be_nil
    end
  end


  it "should exclude unwanted simbols before words" do
    1000.times do
      expect(rl_str_gen.match(/(?<![а-яё])[^ \"а-яё]+\b[а-яё]/i))
                       .to be_nil
    end
  end

  it "should not allow multiple punctuation mark" do
    1000.times do
      expect(rl_str_gen.match(/([^а-яё\.]) *\1/i)).to be_nil
    end
  end


  it "should correctly use quotation marks" do
    1000.times do
      str = rl_str_gen
      expect(str.scan(/\"/).size.even?).to be true
      expect(str.scan(/\".+?\"/)
                .reject { |el| el.match? (/\"[а-яё].+[а-яё]\"/i)}
                .size).to eq(0)
    end
  end


  it "should not allow words starting with ъ, ь, ы" do
    1000.times do
      expect(rl_str_gen.match(/\b[ьъы]/i)).to be_nil
    end
  end


  it "should not contain capital letter inside words if not an acronym" do
    1000.times do
      words = rl_str_gen.gsub(/[^а-яё ]/i, "").split
      words.each do |el|
        unless el.match?(/\A[А-ЯЁ]{2,}\z/)
          expect(el.match(/\A.+[А-ЯЁ]/)).to be_nil
        end
      end
    end
  end


  it "should allow acronyms only to 5 letters long" do
    1000.times do
      acr = rl_str_gen.gsub(/[^а-яё ]/i, "").scan(/[А-ЯЁ]{2,}/)
      expect(acr.count{ |a| a.size > 5 }).to eq(0)
    end
  end


  it "should allow one-letter words with a capital letter" do
    1000.times do
      expect(rl_str_gen.match(/ \"?[А-ЯЁ]\b/)).to be_nil
    end
  end


  it "should always have a vowel after й at the beginning of the word" do
    1000.times do
      expect(rl_str_gen.match(/\bй[^ео]/i)).to be_nil
    end
  end


  it "should allow only particular letters after й inside words" do
    1000.times do
       expect(rl_str_gen.match(/\Bй[ъьыёуиаэюжй]/i)).to be_nil
    end
  end

  it "should always be vowel in 2- end 3- letter words" do
    1000.times do
    rl_str_gen.gsub(/[^а-яё ]/i, "")
              .split
              .select { |el| el.size == 2 or el.size == 3}
              .reject { |el| el.match?(/\A[А-ЯЁ]+\z/) }
      .each do |word|
        expect(word).to match(/[аоуэыияеёю]/i)
      end
    end
  end

  it "shoud allow only particular one-letter words" do
    1000.times do
    end
  end


  it "should not allow more than 4 consonant letters in a row" do
    1000.times do
    end
  end


  it "should not allow moden 2 vowel letters in a row " do
    1000.times do
    end
  end


  it "should not allow more than 2 same consonant letters in a row" do
    1000.times do
    end
  end


  it "should contain vowels if more than one letter and not an acronym" do
    1000.times do
    end
  end


  it "should start with a capital letter" do
    1000.times do
    end
  end

end
