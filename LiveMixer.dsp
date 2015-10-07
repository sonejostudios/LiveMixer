declare name        "LiveMixer";
declare version     "0.1";
declare author      "Vincent Rateau";
declare license     "GPLv2";

//-----------------------------------------------
//              A 8-Tracks Stereo MIxer with 2 Sends
//-----------------------------------------------

import("music.lib");


//process = hgroup("LiveMixer", par(i,1, vgroup("%i", stereostrip : route))) ;

process = stereostrip : route;


//stereo and routing
route(a1,b1,c1,a2,b2,c2) = a1, a2, b1, b2,c1, c2;
stereostrip = mixerstrip, mixerstrip;

// one mixerstrip (mono)
mixerstrip= channel <: _, send;
send = _ <: _ * send1, _ * send2;
channel = _ * slider;

// gui
slider = vslider("[3]Volume", 0, -70, +0, 0.1) : db2linear : smooth(0.999);
send1 = vslider("[1]Send A[style:knob]", 0, -70, +0, 0.1) : db2linear : smooth(0.999);
send2 = vslider("[2]Send B[style:knob]", 0, -70, +0, 0.1) : db2linear : smooth(0.999);


//smooth
smooth(c)	= *(1-c) : +~*(c);
