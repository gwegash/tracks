(defn unique-loop-name
  [base kind]
  (def loops (dyn *lloops*))
  (def stem (keyword base "-" kind))
  (if (nil? (get loops stem))
    stem
    (do
      (var n 2)
      (while (get loops (keyword stem "-" n)) (++ n))
      (keyword stem "-" n))))

(defn- utf8->int
  "Decodes a 3- or 4-byte UTF-8 sequence into its code point."
  [s]
  (def [a b c d] s)
  (case (length s)
    3 (+ (blshift (band a 0x0F) 12) (blshift (band b 0x3F) 6) (band c 0x3F))
    4 (+ (blshift (band a 0x07) 18) (blshift (band b 0x3F) 12)
         (blshift (band c 0x3F) 6) (band d 0x3F))))

(def emoji
  (peg/compile
    ~{:cont (range "\x80\xBF")
      :pictographic (+ (* "\xF0\x9F" (range "\x80\xAB") :cont) # U+1F000–1FAFF
                       (* "\xE2" (range "\x98\x9E") :cont))    # U+2600–27BF
      :variation-selector "\uFE0F"
      :whitespace (set " \t\r\n")
      :open (* "\U01FAF8" (? :variation-selector))
      :close (* "\U01FAF7" (? :variation-selector))
      :special (+ :open :close)
      :emo (* (/ (<- (if-not :special :pictographic)) ,utf8->int) (? :variation-selector))
      :group (* :open (group :seq) :close)
      :seq (any (+ :group :emo :variation-selector :whitespace))
      :main (* :seq -1)}))

(defn not-empty? [term] 
  (not (empty? term))
)


(defmacro moji [mojis inst &named len from to mapping] #TODO for now, we might want to put instrumentation inside the grammar
  (default from :c3)
  (default to :c7)
  (default len 4)

  (def from-note (note from))
  (def to-note (note to))

  (def lloops @[])
  (each line (filter not-empty? (map string/trim (string/split "\n" mojis)))
    (def pattern (assert (peg/match emoji line)
                       (string/format "emojis: can't read line %q" line)))
    (array/push lloops
      ~(live_loop (unique-loop-name :emoji :player)
          (sleep (til ,len))
          (each [n s] (P ,pattern ,len)
            (def range-note (+ ,from-note (mod n (- ,to-note ,from-note))))
            (def mapped (if ,mapping (,mapping range-note) range-note))
            (play mapped ,inst :dur s)
            (sleep s)
        )
      )
    )
  )
  ~(do ,;lloops)
)
