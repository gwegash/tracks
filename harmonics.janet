(bpm 120)

(chain 
  (oscillator :osc :wave "square")
  (gain :osc-g :gain 0.2)
  (biquad :osc-f :type "lowpass" :frequency 10)
  (scope :s)
  (panner :pan)
  (reverb :s-verb :decay-time 2.0)
  (Dlay :s-lay :delay_time .75)
  :out
)

(wire (lfo :osci-m :wave "sawtooth") :osc :frequency)

(live_loop :bleepss
  (sleep (til (rand 4 12)))
  (itarget :osc-g :gain 0.25)
  (sleep 5)
  (exp :osc-g :gain 0.5)
  (sleep 2)
  (exp :osc-g :gain 0.35)
  (sleep 4)
  (exp :osc-g :gain 0.25)
  (sleep 3)
)

(wire (lfo :osci-p :wave "sine" :magnitude 0.5) :pan :pan)

(live_loop :changer-2
  (sleep 32)
  (exp :osc-f :frequency 4000)
  (exp :osci-m :frequency (rand 200 800))
  (exp :osci-m :magnitude (rand 200 800))
  (lin :pan :pan (rand -0.5 0.5))
)

(live_loop :harmonic_series
  (sleep 2)
  (change :osc :frequency (* 100 (timesel (range 1 8) 2)))
)
