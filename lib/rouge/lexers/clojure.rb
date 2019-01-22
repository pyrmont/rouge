# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Lexers
    class Clojure < RegexLexer
      title "Clojure"
      desc "The Clojure programming language (clojure.org)"

      tag 'clojure'
      aliases 'clj', 'cljs'

      filenames '*.clj', '*.cljs', '*.cljc', 'build.boot', '*.edn'

      mimetypes 'text/x-clojure', 'application/x-clojure'

      def self.builtin_conds
        @builtin_conds ||= Set.new %w(
          case cond cond-> cond->> condp if-let if-not if-some when when-first
          when-let when-not when-some
        )
      end

      def self.builtin_defs
        @builtin_defs ||= Set.new %w(
          definline definterface defmacro defmethod defmulti defn defn- defonce
          defprotocol defrecord defstruct deftype
        )
      end

      def self.builtin_excps
        @builtin_excps ||= Set.new %w(
          catch finally throw try
        )
      end

      def self.builtin_fns
        @builtin_fns ||= Set.new %w(
          * *' + +' - -' ->ArrayChunk ->Vec ->VecNode ->VecSeq
          -cache-protocol-fn -reset-methods / < <= = == > >= accessor aclone
          add-classpath add-watch agent agent-error agent-errors aget alength
          alias all-ns alter alter-meta! alter-var-root ancestors apply
          array-map aset aset-boolean aset-byte aset-char aset-double
          aset-float aset-int aset-long aset-short assoc assoc! assoc-in
          associative? atom await await-for await1 bases bean bigdec bigint
          biginteger bit-and bit-and-not bit-clear bit-flip bit-not bit-or
          bit-set bit-shift-left bit-shift-right bit-test bit-xor boolean
          boolean-array booleans bound-fn* bound? butlast byte byte-array
          bytes cast char char-array char? chars chunk chunk-append
          chunk-buffer chunk-cons chunk-first chunk-next chunk-rest
          chunked-seq? class class? clear-agent-errors clojure-version coll?
          commute comp comparator compare compare-and-set! compile complement
          concat conj conj! cons constantly construct-proxy contains? count
          counted? create-ns create-struct cycle dec dec' decimal? delay?
          deliver denominator deref derive descendants destructure disj disj!
          dissoc dissoc! distinct distinct? doall dorun double double-array
          doubles drop drop-last drop-while empty empty? ensure
          enumeration-seq error-handler error-mode eval even? every-pred
          every? ex-data ex-info extend extenders extends? false? ffirst
          file-seq filter filterv find find-keyword find-ns
          find-protocol-impl find-protocol-method find-var first flatten
          float float-array float? floats flush fn? fnext fnil force format
          frequencies future-call future-cancel future-cancelled?
          future-done? future? gensym get get-in get-method get-proxy-class
          get-thread-bindings get-validator group-by hash hash-combine
          hash-map hash-ordered-coll hash-set hash-unordered-coll identical?
          identity ifn? in-ns inc inc' init-proxy instance? int int-array
          integer? interleave intern interpose into into-array ints isa?
          iterate iterator-seq juxt keep keep-indexed key keys keyword
          keyword? last line-seq list list* list? load load-file load-reader
          load-string loaded-libs long long-array longs macroexpand
          macroexpand-1 make-array make-hierarchy map map-indexed map? mapcat
          mapv max max-key memoize merge merge-with meta method-sig methods
          min min-key mix-collection-hash mod munge name namespace
          namespace-munge neg? newline next nfirst nil? nnext not not-any?
          not-empty not-every? not= ns-aliases ns-imports ns-interns ns-map
          ns-name ns-publics ns-refers ns-resolve ns-unalias ns-unmap nth
          nthnext nthrest num number? numerator object-array odd? parents
          partial partition partition-all partition-by pcalls peek
          persistent! pmap pop pop! pop-thread-bindings pos? pr pr-str
          prefer-method prefers print print-ctor print-dup print-method
          print-simple print-str printf println println-str prn prn-str
          promise proxy-call-with-super proxy-mappings proxy-name
          push-thread-bindings quot rand rand-int rand-nth range ratio?
          rational? rationalize re-find re-groups re-matcher re-matches
          re-pattern re-seq read read-line read-string realized? record?
          reduce reduce-kv reduced reduced? reductions ref ref-history-count
          ref-max-history ref-min-history ref-set refer release-pending-sends
          rem remove remove-all-methods remove-method remove-ns remove-watch
          repeat repeatedly replace replicate require reset! reset-meta!
          resolve rest restart-agent resultset-seq reverse reversible? rseq
          rsubseq satisfies? second select-keys send send-off send-via seq
          seq? seque sequence sequential? set set-agent-send-executor!
          set-agent-send-off-executor! set-error-handler! set-error-mode!
          set-validator! set? short short-array shorts shuffle
          shutdown-agents slurp some some-fn some? sort sort-by sorted-map
          sorted-map-by sorted-set sorted-set-by sorted? special-symbol? spit
          split-at split-with str string? struct struct-map subs subseq
          subvec supers swap! symbol symbol? take take-last take-nth
          take-while test the-ns thread-bound? to-array to-array-2d
          trampoline transient tree-seq true? type unchecked-add
          unchecked-add-int unchecked-byte unchecked-char unchecked-dec
          unchecked-dec-int unchecked-divide-int unchecked-double
          unchecked-float unchecked-inc unchecked-inc-int unchecked-int
          unchecked-long unchecked-multiply unchecked-multiply-int
          unchecked-negate unchecked-negate-int unchecked-remainder-int
          unchecked-short unchecked-subtract unchecked-subtract-int underive
          unsigned-bit-shift-right update-in update-proxy use val vals
          var-get var-set var? vary-meta vec vector vector-of vector?
          with-bindings* with-meta with-redefs-fn xml-seq zero? zipmap
        )
      end

      def self.builtin_macros
        @builtin_macros ||= Set.new %w(
          -> ->> .. amap and areduce as-> assert binding bound-fn comment
          declare delay dosync doto extend-protocol extend-type for future
          gen-class gen-interface import io! lazy-cat lazy-seq letfn locking
          memfn ns or proxy proxy-super pvalues refer-clojure reify some->
          some->> sync time with-bindings with-in-str with-loading-context
          with-local-vars with-open with-out-str with-precision with-redefs
        )
      end

      def self.builtin_repeats
        @builtin_repeats ||= Set.new %w(
          doseq dotimes while
        )
      end

      def self.builtin_specials
        @builtin_specials ||= Set.new %w(
          . def do fn if let loop monitor-enter monitor-exit new quote recur
          set! var
        )
      end

      def self.builtin_vars
        @builtin_vars ||= Set.new %w(
          *1 *2 *3 *agent* *allow-unresolved-vars* *assert* *clojure-version*
          *command-line-args* *compile-files* *compile-path* *compiler-options*
          *data-readers* *default-data-reader-fn* *e *err* *file*
          *flush-on-newline* *fn-loader* *in* *math-context* *ns* *out*
          *print-dup* *print-length* *print-level* *print-meta*
          *print-readably* *read-eval* *source-path* *unchecked-math*
          *use-context-classloader* *verbose-defrecords* *warn-on-reflection*
          EMPTY-NODE char-escape-string char-name-string default-data-readers
          primitives-classnames unquote unquote-splicing
        )
      end

      identifier = %r([\w!$%*+,<=>?/.-]+)
      keyword = %r([\w!\#$%*+,<=>?/.-]+)

      def name_token(name)
        return Keyword if (self.class.builtin_conds.include?(name) ||
                           self.class.builtin_excps.include?(name) ||
                           self.class.builtin_macros.include?(name) ||
                           self.class.builtin_repeats.include?(name) ||
                           self.class.builtin_specials.include?(name))

        return Keyword::Declaration if (self.class.builtin_defs.include?(name))

        return Name::Variable if (self.class.builtin_vars.include?(name))

        return Name::Builtin if (self.class.builtin_fns.include?(name))

        nil
      end

      state :root do
        rule /;.*?$/, Comment::Single
        rule /\s+/m, Text::Whitespace

        rule /-?\d+\.\d+/, Num::Float
        rule /-?\d+/, Num::Integer
        rule /0x-?[0-9a-fA-F]+/, Num::Hex

        rule /"(\\.|[^"])*"/, Str
        rule /'#{keyword}/, Str::Symbol
        rule /::?#{keyword}/, Name::Constant
        rule /\\(.|[a-z]+)/i, Str::Char


        rule /~@|[`\'#^~&@]/, Operator

        rule /(\()(\s*)(#{identifier})/m do |m|
          token Punctuation, m[1]
          token Text::Whitespace, m[2]
          token(name_token(m[3]) || Name::Function, m[3])
        end

        rule identifier do |m|
          token name_token(m[0]) || Name
        end

        # vectors
        rule /[\[\]]/, Punctuation

        # maps
        rule /[{}]/, Punctuation

        # parentheses
        rule /[()]/, Punctuation
      end
    end
  end
end
