// @taubaland
// Nautilus.
// Dusty waves, chaotic undercurrent
//
// voicing adapted from Supersaw by @cfdrake

{
	arg hz=55.1, amp=0.02, amplag=0.02, hzlag=0.01;
	var amp_ = amp.lag(amplag);
	var hz_ = hz.lag(hzlag);
	var lorenz = LorenzL.ar(hz_, 10, 28, 8.0/3.0, 0.05, 0.1);

	Splay.ar(Array.fill(6, { |i|
		DFM1.ar(
			SinGrain.ar(
				Pulse.ar(10),
				2 * i + lorenz,
				hz_ + (i * lorenz),
				EnvGen.kr(Env([0, 0.5, 0], [SinOsc.kr(0.1 * i + lorenz, 0, 1), SinOsc.kr(0.1 * i + lorenz, 0, 1)], \sin, 1, 2))),
			hz_ + (10 * i * lorenz) * 0.5,
			0.05,
			0.5,
			0.0,
			0.08 + (0.02 * SinOsc.kr(lorenz, 0, 0.1)),
			1.0,
			0.0
		)
	}), 1) * amp_;
}
