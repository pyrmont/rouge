# -*- coding: utf-8 -*- #

describe Rouge::Lexers::Gherkin do
  let(:subject) { Rouge::Lexers::Gherkin.new }

  describe 'guessing' do
    include Support::Guessing

    it 'guesses by filename' do
      assert_guess :filename => 'foo.feature'
    end

    it 'guesses by mimetype' do
      assert_guess :mimetype => 'text/x-gherkin'
    end

    it 'guesses by source' do
      assert_guess :source => '#!/usr/bin/env cucumber'
    end
  end

  describe 'lexing' do
    it 'highlights placeholders correctly' do
      subject.push :has_examples
      tokens = subject.lex('When <foo> (<bar>, <baz>)< garbage', continue: true).to_a

      assert { tokens.size == 7 }
      assert { tokens[0][0] == Token['Name.Function'] }
      assert { tokens[1][0] == Token['Name.Variable'] }
      assert { tokens[2][0] == Token['Text'] }
      assert { tokens[3][0] == Token['Name.Variable'] }
      assert { tokens[4][0] == Token['Text'] }
      assert { tokens[5][0] == Token['Name.Variable'] }
      assert { tokens[6][0] == Token['Text'] }
    end
  end
end
