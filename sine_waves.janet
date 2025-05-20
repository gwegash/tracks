(chain 
  (synth :hi)
  (Dlay :delay :delay_time 1.50)
  (reverb :verb :decay_time 3.0)
  (compressor :comp)
  (biquad :filter :filter_type "peaking")
  :out
)

(live_loop :hi_loop
  #(play :d4 :hi :dur 1.0)
#  (play :e4 :hi :dur 1.0)
  (sleep 0.5)
)

#(live_loop :hi_bass
#  (play (timesel [:d2 :e2 :a2] 16) :hi :dur 1)
# # (play (timesel [:d3 :e3 :a3] 16) :hi :dur 1)
#  (sleep 0.5)
#)
##
(chain 
  (synth :hi-2 :wave "square")
  (Dlay :hi-2-lay :delay_time 0.75)
  (scope :hi-2-s)
  (reverb :hi-2_ 3.0)
  :out
)
