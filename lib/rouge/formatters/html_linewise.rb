# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Formatters
    class HTMLLinewise < Formatter
      def initialize(formatter, opts={})
        @formatter = formatter
        @tag_name = opts.fetch(:tag_name, 'div')
        @class_format = opts.fetch(:class, 'line-%i')
      end

      def stream(tokens, &b)
        first_line = true
        token_lines(tokens) do |line|
          first_line ? first_line = false : yield("\n")
          yield "<#{@tag_name} class=#{next_line_class}>"
          line.each do |tok, val|
            yield @formatter.span(tok, val)
          end
          yield "</#{@tag_name}>"
        end
      end

      def next_line_class
        @lineno ||= 0
        sprintf(@class_format, @lineno += 1).inspect
      end
    end
  end
end
