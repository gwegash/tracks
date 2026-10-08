(use-lib "tracks/utils.janet")
(use-lib "tracks/libs/emojis.janet")

(chain 
  (synth :hi :wave "sine")
  (delay :delay :delay_time 1.50)
  (reverb :verb :decay-time 3.0)
  (compressor :comp)
  (biquad :filter :filter_type "peaking")
  :out
)

(live_loop :hi_loop
#  (play :d4 :hi :dur 1.0)
  (sleep 0.5)
)

(live_loop :hi_bass
#  (play (timesel [:d2 :e2 :a2] 16) :hi :dur 1)
 # (play (timesel [:d3 :e3 :a3] 16) :hi :dur 1)
  (sleep 0.5)
)

(chain 
  (synth :hi-2 :wave "square" :gain 0.001)
  (delay :hi-2-lay :delay_time 0.75)
  (scope :hi-2-s)
  (reverb :hi-2_ :decay-time 3.0 :wet-dry -0.42)
  :out
)
