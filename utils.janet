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
