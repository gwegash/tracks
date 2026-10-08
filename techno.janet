 (chain 
  (keyboard :keys)
  (drums :dram :hits [
    "local://PLAT1.flac"
    "local://PLAT2.flac"
    "local://PLAT3.flac"
    "local://PLAT4.flac"
    "local://PLAT5.flac"
    "local://PLAT6.flac"
    "local://PLAT7.flac"
    "local://PLAT8.flac"
    "local://PLAT9.flac"
    "local://PLAT10.flac"
    "local://PLAT11.flac"
    "local://PLAT12.flac"
    "local://PLAT13.flac"
    "local://PLAT14.flac"
    "local://PLAT15.flac"
    "local://PLAT16.flac"
    "local://PLAT17.flac"
    "local://PLAT18.flac"
    "local://PLAT19.flac"
    "local://PLAT20.flac"
    "local://PLAT21.flac"
    "local://PLAT22.flac"
    "local://PLAT23.flac"
  ])
  (distortion :dist :amount 100)
  (panner :pan)
  (biquad :dist-f :filter_type "highpass")
  (reverb :mad-verb)
  :out
)

'(live_loop :dram 
  (seed 3)
  (for i 0 7
    (play (pick ;(range 0 15)) :dram)
    (sleep (pick 0.25 0.75))
  )
)

(live_loop :change 
  (lin :pan :pan (rand -0.3 0.3))
  (sleep 0.5)
)

(chain
  (drums :808 :hits [
  "local://808BD1.flac"
  "local://808BD10.flac"
  "local://808CH4.flac"
  "local://808CH7.flac"
  "local://808OH7.flac"
  "local://808OH9.flac"
  "local://808OH27.flac"
  "local://808SD1.flac"
  "local://808SD2.flac"
  "local://808SD8.flac"
  "local://808SD9.flac"
  "local://808SD19.flac"
  "local://808SD20.flac"])
  #(distortion :808-dist :amount 1)
  (gain :drum-gains)
  (delay :lol-lay-2 :delay_time 0.02)
  (delay :lol-lay :delay_time 0.75)
  (distortion :drum-storsh :amount 1000)
  :out
)


#(live_loop :hh
#  (seed 8)
#  (for i 0 8
#    (play (pick 2 3 4) :808 :dur 0.02)
#    (sleep (pick 0.25 0.25 0.5))
#  )
#)
#
#(live_loop :bdsn
#  (seed 19)
#  (for i 0 9
#    (play (pick 0 1) :808)
#    (sleep (pick 0.25 0.75))
#  )
#)
#
'(chain 
  (breakbeat :yo :url "local://07076030.wav" :length_beats 300 :slices 30)
  (distortion :yo-stort)
  (reverb :yo-verb)
  (delay :yo-lay)
  :out
)
#
#'(live_loop :sfc
#  (play (pick ;(range 0 30)) :yo :dur 4)
#  (sleep (pick 16 20))
#)
