function Sim(scen) {
	var state = {};
	var data = {};
	// initialize state
	this.init(scen);
	this.randOrder(10);
}

// initialize state by scenario
Sim.prototype.init = function(scen) {
	switch(scen) {
		case "coin":
			this.initBinom();
		case "factory":
			this.initNorm();
		case "store":
			this.initExp();
	}
};

// randomize n-item order
Sim.prototype.randOrder = function(n) {
	// create n-item array
	var a = [];
	for (var i=0, l=n; i<n; i++){
  		a.push(i);
	}
	// shuffle array
	var j, x, i;
    for (i = a.length; i; i -= 1) {
        j = Math.floor(Math.random() * i);
        x = a[i - 1];
        a[i - 1] = a[j];
        a[j] = x;
    }
    this.state.order = a;
}

// initial settings for factory scenario
Sim.prototype.initNorm = function() {
	var precise = {
		"mean": 2,
		"sd": .05 // sd = 5ミリ
	};
	var sd_large = {
		"mean": 2,
		"sd": .1 // sd = 10ミリ
	};
	this.state = {
		"name": ["調査"],		
		"choice": ["ラインA", "ラインB", "ラインC"],
		"param": [sd_large, precise, precise],
		"answer": [true, false, false],
		"experiment": [
			{
				"text": "各ラインから飴を100個ずつ取り出して、大きさ（直径）の分布をグラフにする",
				"args": {
					"n": 100,
					// "func": "hist"
				}
			},
			{
				"text": "各ラインから飴を1000個ずつ取り出して、大きさ（直径）の分布をグラフにする",
				"args": {
					"n": 1000,
					// "func": "hist"
				}
			}
		]
	};
};

// initial settings for coin scenario
Sim.prototype.initBinom = function() {

};

// initial settings for store scenario
Sim.prototype.initExp = function() {

};

Sim.prototype.makeRandomNum = function(min, max) {
  return Math.random() * (max - min) + min;
}

Sim.prototype.runNorm = function(item) {
	var util = new Util();

	var l = this.state.param.length;
	for(var i=0; i<l; i++) {
		var args = {
			// "n": param.n,
			// "mean": param.mean,
			// "sd": param.sd,
			"main": this.state.choice[i],
			"xlab": "大きさ（直径）",
			"ylab": "個数"
		};

		Object.assign(args, item);
		Object.assign(args, this.state.param[i]);
		// console.log("params: %o", args);
		util.addCustRun("sampling_normal_hist_v1", args, "");
		//
		var size = {
	      "width": 300,
	      "height": 300
	    };	

//	    util.generateImage($,".acdn-content","平均の棒グラフ.png", size, function() {
    	
    	//added by ryo
	    util.generateImage($,".content-"+i+":eq(-1)","平均の棒グラフ.png", size, function() {
			console.log('image generated.');
    	}, function(){
	    	console.log('generating image failed.');
    	});	
	}
}

Sim.prototype.runBinom = function() {

};

Sim.prototype.runExp = function() {

};

