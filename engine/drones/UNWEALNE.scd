// @zebra
//f =
{
	arg hz=110, amp=0.1, dusthz=8.0, spring=0.553, damp=0.0088, decay=12.0, fbamt=0.88, crack=1.97;
	var fc = (hz * Array.geom(3, 4, 5/3));
	var sprng = Spring.ar(Crackle.ar((crack + LFNoise1.kr([0.07, 0.08], 0.21)).min(1.999)), spring, damp);
	var plck = RLPF.ar(
		Pulse.ar(hz * [0.5, 1],
			EnvGen.kr(Env.perc, Dust.kr(0.7), 0.2, 0.4, LFNoise1.kr([0.1, 0.1], 1.0, 2.0))
		),
		hz * EnvGen.kr(Env.perc, Dust.kr(0.7), 2.0, 3.0, LFNoise1.kr([0.1, 0.1], 1.0, 2.0)),
		EnvGen.kr(Env.perc, Dust.kr(0.7), 0.1, 0.8, LFNoise1.kr([0.1, 0.1], 1.0, 2.0))
	);
	var snd = Mix.new(((sprng *1.6) + (plck * 0.58)).flatten.clump(2));
	var shiftu = PitchShift.ar(snd, [11/7, 16/5] + LFNoise2.kr(0.1, 0.021), windowSize:0.18, timeDispersion:0.06);
	var shiftd = PitchShift.ar(snd, [4/11, 8/13] + LFNoise2.kr(0.1, 0.019), windowSize:0.18, timeDispersion:0.06);
	var lpf = RLPF.ar(Mix.new(shiftu, shiftd), fc, 0.4);
	var fb = DelayC.ar(LocalIn.ar(2), 0.2, (0.1 + LFNoise1.ar(0.038, 0.01)).min(0.19)) * fbamt;
	LocalOut.ar(Mix.new(lpf.flatten.clump(2)));
	Mix.new((amp * 0.3 * (snd + fb + lpf)).flatten.clump(2));
}
//;
//x = f.play(s);
//x.set(\hz, 200);