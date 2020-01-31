<CsoundSynthesizer> <CsOptions> ; Select audio/midi flags here according to platform ; Audio out   No messages -odac           -d     ;;;RT audio I/O ; For Non-realtime ouput leave only the line below:
; -o wterrain.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

instr 1
kdclk   linseg  0, 0.01, 1, p3-0.02, 1, 0.01, 0
kcx     line    0.1, p3, 005.2
krx     linseg  0.1, p3/2, 010.2, p3/2, 0.1
kpch    line    cpspch(p4), p3, p5 * cpspch(p4)

kthresh = 0
kloknee = 48
khiknee = 60
kmetro metro 32
kcauchy cauchy 1500
kstep samphold kcauchy, kmetro
kratio lfo 0.4,kstep,4
katt = 0.00
krel = 0.00

a1	wterrain    10000, kpch, kcx, -kcx, -krx, krx, p6, p7
a1	dcblock a1
a2      wterrain    10000, (kpch/2)+kmetro, kcx, kcx*2, krx, krx, p6, p7
a2      dcblock a2
a3	compress a1, a1, kthresh, kloknee, khiknee, kratio, katt, krel, 0.05
; a3 	multitap a3, 0.2, 0.7, 0.4, 0.4, 0.6, 0.8, 1, 0.8
a4	cross2 a2,a3,(2^10),4,1,1.0
a4	compress a4, a1, 0, 60, 48, 0.65, katt, krel, 0.05
a5	balance a4, a1
        outs     a5*kdclk, a5*kdclk
endin

</CsInstruments>
<CsScore>

f1      0       8192    10      1 0 0.33 0 0.2 0 0.14 0 0.11
f2      0       4096    10      1 0.5 0.75
f3      0       8192    10      1 0

i1      0       60       8 2 1 2


</CsScore>
</CsoundSynthesizer>
