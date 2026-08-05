(bpm 160)


(defmacro steps
  ````Runs `body` `n` times, sleeping `dur` beats after each one.

  The `(for i 0 n ... (sleep dur))` idiom, minus the `i` nobody uses. The sleep is
  still visible -- it is the second argument.

  **Example**
  ```
  (steps 4 1 (play 0 :kick :dur 1)) # four kicks, one per beat
  ```
  ````
  [n dur & body]
  ~(repeat ,n ,;body (sleep ,dur)))


(defn unique-loop-name
  ````Builds a live-loop name of the form `base`-`kind`, with a counter appended if
  that name is already taken.

  Uniqueness is read from the live-loop table, which is rebuilt from scratch on every
  compile, so the same script always produces the same names -- generated loops keep
  their identity, and their phase, while you edit. Reordering two generators for the
  same instrument does renumber them, and so reschedules them.

  **Example**
  ```
  (unique-loop-name :pad-gate :gate) # -> :pad-gate-gate
  (unique-loop-name :pad-gate :gate) # -> :pad-gate-gate-2, the first one having been made
  ```
  ````
  [base kind]
  (def loops (dyn *lloops*))
  (def stem (keyword base "-" kind))
  (if (nil? (get loops stem))
    stem
    (do
      (var n 2)
      (while (get loops (keyword stem "-" n)) (++ n))
      (keyword stem "-" n))))

(defn wpick
  ````Picks a value randomly from `value weight` pairs, using the live-loop's seed.

  The written-out form of repeating an option to make it likelier: `(pick :a :b :b :b)`
  is `(wpick :a 1 :b 3)`. Weights need not be whole numbers.

  **Example**
  ```
  (wpick :d3 1 :d2 3 :eb3 1)
  ```
  ````
  [& pairs]
  (def entries (partition 2 pairs))
  (var remaining (rand 0 (sum (map last entries))))
  (label chosen
    (each [value weight] entries
      (-= remaining weight)
      (when (<= remaining 0) (return chosen value)))
    # only reached if the draw lands exactly on the total
    (first (last entries))))

(defmacro gate
  ````Makes a live-loop that chops the `:gain` of `instName` on and off.

  * `:rate` -- beats per open or closed step (default 0.125)
  * `:beats` -- length of the generated loop (default 1). The gate's phase comes from
    absolute time, so this does not change the sound, only how soon an edit lands.
  * `:low` / `:high` -- the closed and open levels (default 0.001 and 1)

  The loop is named after the instrument, see `unique-loop-name`.

  **Example**
  ```
  (gate :pad-gate)              # -> live-loop :pad-gate-gate, gating every 1/8 beat
  (gate :pad-gate :rate 0.25 :low 0.2)
  ```
  ````
  [instName &named rate beats low high]
  (default rate 0.125)
  (default beats 1)
  (default low 0.001)
  (default high 1)
  ~(live_loop (unique-loop-name ,instName :gate)
     (steps (math/floor (/ ,beats ,rate)) ,rate
       (change ,instName :gain (timesel [,high ,low] ,rate)))))

(defmacro sweep
  ````Makes a live-loop that ping-pongs `param` on `instName` between the two values
  of `between`, exponentially, taking `over` beats each way.

  The loop sleeps first and then sets the target, which is what gives the ramp its
  whole `over` beats to travel.

  **Example**
  ```
  (sweep :teeb :cutoff [40 4000] 32) # -> live-loop :teeb-sweep
  ```
  ````
  [instName param between over]
  ~(live_loop (unique-loop-name ,instName :sweep)
     (sleep ,over)
     (exp ,instName ,param (timesel ,between ,over))))

(defmacro linsweep
  ````Makes a live-loop that ping-pongs `param` on `instName` between the two values
  of `between`, exponentially, taking `over` beats each way.

  The loop sleeps first and then sets the target, which is what gives the ramp its
  whole `over` beats to travel.

  **Example**
  ```
  (sweep :teeb :cutoff [40 4000] 32) # -> live-loop :teeb-sweep
  ```
  ````
  [instName param between over]
  ~(live_loop (unique-loop-name ,instName :sweep)
     (sleep ,over)
     (lin ,instName ,param (timesel ,between ,over))))

(chain 
  (tb303 :teeb :gain 0.8002 :cutoff 40 :resonance 0.1783 :envMod 0.06324 :decay 0.3189 :attack 0.00307 :slide 0.03593)
  (distortion :teeb-stort :amount 750 )
  (gain :teeb-level :gain 1.738)
  (scope :teeb-scope)
  (reverb :teeb-verb)
  :out
)

(chain 
  (drums :808 :hits ["tracks/samples/hedonics/808BD3.flac"])
  (compressor :808-comp :threshold -53 :knee 0 :ratio 19.43 :attack 0.003 :release 0.075)
  (distortion :808-stort :amount 100)
  (gain :drum-vol :gain 2.399)
  (scope :drum-scope)
  :out
)

(live_loop :teeb-player
  (seed 45)
#  (seed 100)
  (for i 0 24
    (play (pick :d3 :d2 :d2 :d2 :eb3 :d4) :teeb :dur (pick 0.1 0.1 0.1 -0.1))
    (change :teeb :envMod (+ 0.01 (pick 0.01 0.01 0.01 0.05)) 0.01)
    (sleep 0.25)
  )
)

(chain 
  (sample :pad :url "tracks/samples/pad_c.wav" :pitch :c3)
  (gain :pad-gate)
  (reverb :pad-verb)
  (biquad :pad-shimmer :filter_type "peaking")
  (gain :pad-level)
  (scope :pad-scope)
  :out
)

(live_loop :pads
  (play :d3 :pad :dur 5)
  (play :c3 :pad :dur 5)
  (play :a2 :pad :dur 5)
  (sleep 4)
)

(gate :pad-gate :rate 0.125)
(sweep :pad-shimmer :frequency [4000 100] 32)
(sweep :teeb :cutoff [40 4000] 32)
(sweep :teeb :resonance [0.7 0.99] 32)

(live_loop :bd
  (for i 0 4
    (play 0 :808 :dur 1)
    (sleep 1)
  )
)

(chain 
  (breakbeat :warrior :url "tracks/samples/loops/warrior.flac" :slices 8 :length_beats 4 :transpose 4 :gain 3)
  (distortion :warrior-stort :amount 10)
  (compressor :warrior-comp :threshold -31 :knee 30 :ratio 14.19 :attack 0.003 :release 0.015)
  (gain :warrior-level :gain 3.802)
  (scope :warrior-scope)
  :out
)

(chain 
  (breakbeat :amen :url "tracks/samples/breaks/amen.wav" :slices 8 :length_beats 16 :transpose 2 :gain 4.1)
  :warrior-comp
)

(live_loop :warrior_loop
  (each [n s] (P 
    [
      0
      0
      0
      (pick (uclid 2 3 8) (uclid 1 3 8))
      0 
      2
      0
      (pick (uclid 4 3 8) [0 1 2 (rep (pick 0 1 2 3 4) (pick 16 8))])
    ] 32
  ) 
    (play n (pick :amen) :dur s)
    (sleep s)
  )
)

