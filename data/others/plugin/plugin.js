//blur animation for background image
function blur(a,b){
    $({blurRadius: a}).animate({blurRadius: b}, {
        duration: 500,
        easing: 'swing', // or "linear"
                         // use jQuery UI or Easing plugin for more options
        step: function() {
//	            console.log(this.blurRadius);
            $('.base_fore').css({
                "-webkit-filter": "blur("+this.blurRadius+"px)",
                "filter": "blur("+this.blurRadius+"px)"
            });
        }
    });	
}

//initialize system, set assets, define button click and hover events, 
function init(){
	var f = tyrano.plugin.kag.stat.f;
	
/*add essential div	*/
	$('#tyrano_base').append('<div id="tyrano_wrapper"></div>');

	//add dif. btn div
	$('#tyrano_wrapper').append('<div id="dif-btn-wrapper"><div class="difficulty" id="easy"><span class="difficulty_name">EASY</span></div><div class="difficulty" id="normal"><span class="difficulty_name">NORMAL</span></div><div class="difficulty" id="hard"><span class="difficulty_name">HARD</span></div><div id="start-btn-wrapper"><button id="start-btn"><span>START</span></button><button id="back-btn"><span>BACK</span></button></div></div>');

	//add scenario title
	//load scenario title image and scenario title from simulation.js
	$('#tyrano_wrapper').append('<div id="scenario-title"><h1><img id="scenario-title-img" src="./data/image/'+f.sim.state.titleimage+'.png"/>'+f.sim.state.title+'</h1><div id="scenario-title-base"></div></div>');	
	
	//add choice and experiment buttons wrapper div
	$('#tyrano_wrapper').append('<div id="btn-wrapper"></div>');
	
	//add choice buttons wrapper div
	$('#btn-wrapper').append('<div id="choice-btn-wrapper">');
	
	//add choice buttons
	//load button image and choice sentences from simulation.js
	$('#choice-btn-wrapper').append('<button class="choice choice-a" value="0"><img src="./data/image/'+f.sim.state.image[0]+'.png"><span class="choice_name">'+f.sim.state.choice[0]+'</span></button><button class="choice choice-b" value="1"><img src="./data/image/'+f.sim.state.image[1]+'.png"><span class="choice_name">'+f.sim.state.choice[1]+'</span></button><button class="choice choice-c" value="2"><img src="./data/image/'+f.sim.state.image[2]+'.png"><span class="choice_name">'+f.sim.state.choice[2]+'</span></button>');
	
	//add experiment buttons wrapper div
	$('#btn-wrapper').append('<div id="exp-btn-wrapper"></div>');
	
	//add experiment buttons
	//load words of sequence("experiment" or "investigation") from simulation.js
	$('#exp-btn-wrapper').append('<button id="do-exp-btn" class="exp-btn force-hover pulse" value="*experiment"><img src="./data/image/buttons/do_exp_btn_on.png"><span>'+f.sim.state.name+'する</span></button><button id="exp-result-btn" class="exp-btn" value="*exp-result"><img src="./data/image/buttons/exp_result_btn_off.png"><span>'+f.sim.state.name+'結果</span></button>');	
	
	//add list of experiments div
	//load words of sequence("experiment" or "investigation") from simulation.js
	$('#tyrano_wrapper').append('<div id="exp-list-title"><h2>'+f.sim.state.name+'リスト</h2></div><div id="exp-list" ontouchmove="event.stopPropagation()"></div><div id="show_dialog" style="display:none;"></div>');
	
	//load list from simulation.js
	add_list_exp(f.sim.state);
	
	//add counting div
	$('#tyrano_wrapper').append('<div id="difficulty_base"></div>');
	
	//Add result of experiments div
	//load words of sequence("experiment" or "investigation") from simulation.js
	$('#tyrano_wrapper').append('<button id="exp-result-expand-btn" class="button sys-btn">全画面表示</button><button id="exp-result-expand-close" class="button sys-btn">戻る</button><div id="exp-result-title"><h2>'+f.sim.state.name+'結果</h2></div><div id="exp-result" ontouchmove="event.stopPropagation()"></div>');	

/* initialize start window */
	//for background blur
	blur(0,10);
	
	//initialize difficulty
	//set normal as default
	$(document).ready(function(){
		var difficulty = $('.difficulty').eq(1).attr('id');
		$('.difficulty').eq(1).addClass('pulse');
		$('.difficulty').eq(1).addClass('active');
		tyrano.plugin.kag.stat.f["difficulty"] = difficulty;
		tyrano.plugin.kag.stat.f["chance"] = 2;
		console.log('*difficulty init:'+ difficulty);
		return
	});
	
	//difficulty button click action
	$('#tyrano_wrapper').on('click', '.difficulty', function(){
		var difficulty = $(this).attr('id');
		tyrano.plugin.kag.stat.f["difficulty"] = difficulty;
		for(var i=0;i<3;i++){
			$('.difficulty').removeClass('pulse');
			$('.difficulty').removeClass('active');
		}
		$(this).addClass('pulse');
		$(this).addClass('active');	
		
//		console.log('clicked');
		console.log('*difficulty:'+ difficulty);
		return
	});

	//when start button is pressed, system starts scenario 
	$('#tyrano_wrapper').on('click', '#start-btn',function(){
		var chance = tyrano.plugin.kag.stat.f["chance"];
		var difficulty = tyrano.plugin.kag.stat.f["difficulty"];
		if(difficulty == "easy"){
			chance = 3;
		}else if(difficulty == "normal"){
			chance = 2;
		}else{
			chance = 1;
		}
		tyrano.plugin.kag.stat.f["chance"] = chance;
		$('#dif-btn-wrapper').addClass('fade-out');
		$('#dif-btn-wrapper').hide();
		console.log('*chance:'+chance);
		tyrano.plugin.kag.ftag.startTag("jump",{target:"*start"});
	});
	
	//when back button is pressed, back to title menu	
	$('#tyrano_wrapper').on('click', '#back-btn',function(){
		console.log('*back to title menu.');
		blur(10,0);
	//instead of using 'location.reload()', use jump(embedded in each scenario)
		tyrano.plugin.kag.ftag.startTag("jump",{target:"*backtitle-jump"});
//		location.reload();
	});

//start button hover action
	$(function(){
		$('#start-btn').hover(
			function(){
				$(this).addClass('pulse');
			},
			function(){
				$(this).removeClass('pulse');
			}
		);	
	});	

//exp-list click action
	$('#tyrano_wrapper').on('click', '.list', function(){
		var listval = $(this).text();
		var listnum = $(this).index();
		
		tyrano.plugin.kag.stat.f["listnum"] = listnum;
		tyrano.plugin.kag.stat.f["listname"] = listval;

//		console.log('list clicked');
		console.log('*listnum:'+listnum);

		var item = f.sim.state.experiment[$(this).index()];
		console.log(Object.assign(item.args,f.sim.state.param[$(this).index()]));

		$('#show_dialog').show();

		var strComment = "調査「"+listval+"」をしますか？";	
		// set dialog message
		$('#show_dialog').html( strComment );
		
		// create dialog
		$('#show_dialog').dialog({
			modal: true,
			title: "確認",
			buttons: {
				"はい": function() {
					$(this).dialog('close');
					
					//count up experiment challenge time and count down chance time
					count_exp();
					//add div for result
					add_result();
					//and then run generating image function(this arrangement is important for function to detect last class of .acdn-content. see simulation.js.)
					var scenario = tyrano.plugin.kag.stat.f["scenario"];
					if(scenario == "factory"){
						f.sim.runNorm(item.args);
						console.log("runNorm");						
					}else if(scenario == "store"){
						f.sim.runExp(item.args);					
						console.log("runExp");
					}else{
						f.sim.runBinom(item.args);						
						console.log("runBinom");
					}
					
					console.log("system:exp-time:"+tyrano.plugin.kag.stat.f["exptime"]);
					console.log("system:chance:"+tyrano.plugin.kag.stat.f["chance"]);
					console.log("system:added result div");
					
					$('#difficulty_base').animate({'right':'-1000px'},300);
					
					$('#exp-list-title').animate({'left':'-1000px'},300);
					$('#exp-list').animate({'left':'-1000px'},300);
					$('#exp-result-title').delay(300).animate({'left':'0px'},300);
					$('#exp-result').delay(300).animate({'left':'10px'},300,'easeInOutCubic');
					$('#exp-result-expand-btn').delay(1000).show();
					$('.list').eq(listnum).delay(1000).queue(function() {
						$(this).addClass('done').dequeue();
//						$(this).append('（'+tyrano.plugin.kag.stat.f["exptime"]+'回目に'+f.sim.state.name+'済）');
					});
				},
				"いいえ": function() {
					$(this).dialog('close');
					console.log('*cancelled.');
				}
			}
		});
	});

//exp-result
	// show experiment result
	$(function(){
		var acdnItem = $('#exp-result');
	//div open or close
		acdnItem.on('click', acdnItem.find('h3'), function(e){
//			console.log('click');
	//judge hit class
			$(e.target).toggleClass("active");
			var slideItem = $(e.target).next('div');
	//hit junction process
			if($(e.target).hasClass('active')){
				//open hit class
				slideItem.slideToggle();
				console.log('down');
			}else{
				//close hit class
				slideItem.slideToggle();
				console.log('up');
			}
		});
	});


//exp-result-expand-btn action
	$('#tyrano_wrapper').on('click', '#exp-result-expand-btn', function(){
		$('#exp-result').css('top','0')
						.css('left','0')
						.css('height','100%')
						.css('width','100%')
						.css('border-radius','0px')
						.css('background-color', 'rgba(0,0,0,0.5)');
		$('#exp-result-expand-close').show();
	}).on('click', '#exp-result-expand-close', function(){
		$('#exp-result').css('top','62px')
						.css('width','940px')
						.css('height','500px')
						.css('border-radius','10px')
						.css('background-color', 'rgba(255,255,255,0.5)');
		$('#exp-result-expand-close').hide();
	});
		
//choice button hover action	
	$(function(){
		var flag = false;
		$('.choice').hover(
			function(){
				flag = false;
				$('.choice').removeClass('active');
				$('.choice').removeClass('flip-top');
				$(this).addClass('pulse');
				$(this).addClass('active');
			},
			function(){
				if(!flag){
				    $(this).removeClass('pulse');
				    $(this).removeClass('active');
				}
			}
		);
		//選択肢クリック時動作
		$(document).on('mousedown', '.choice', function(){
			$(this).removeClass('pulse');			
			$(this).addClass('active');
		});
		$(document).on('mouseup', '.choice', function(){
			flag = true;
		});
	});
	
//exp-btn hover action
	$(function(){
		var flag = false;
		var src = '';
		$('.exp-btn').hover(
			function(){
				flag=false;
				$(this).addClass('pulse');
				$(this).addClass('active');
				src = $(this).find('img').attr('src');
				$(this).find('img').attr('src', src.replace(/_off/g, '_on'));
			},
			function(){
				src = $(this).find('img').attr('src');
				$(this).find('img').attr('src', src.replace(/_on/g, '_off'));
				$(this).removeClass('force-hover');
				if(!flag){
				    $(this).removeClass('pulse');
				    $(this).removeClass('active');
				}
			}
	  	);
		$(document).on('mousedown', '.exp-btn', function(){
			$(this).removeClass('pulse');		
			$(this).addClass('active');
		});
		$(document).on('mouseup', '.choice', function(){
			flag = true;
		});
	});		
}

//this must be called only once, because of jumping scenario codes written in this code. these jump codes shouldn't be called more than once by system.
function scenario_jump(){
	var f = tyrano.plugin.kag.stat.f;
//choice button click action	
	$(function(){
		$(document).on('mouseup', '.choice', function(){
			var val = $(this).val();
			tyrano.plugin.kag.stat.f["choice"] = val;
			tyrano.plugin.kag.ftag.startTag("jump",{target:"*choice"+val});
			console.log('*choice:'+val);
		});
	//exp button click action
		$(document).on('mouseup', '.exp-btn', function(){
			var val = $(this).val();
			console.log(val);
			tyrano.plugin.kag.ftag.startTag("jump",{target:val});
		});
	});
	
}

//when reaches at *choices
function choices_init(){
	tyrano.plugin.kag.stat.is_stop = false;
	var f = tyrano.plugin.kag.stat.f;
	
	//div animation
	$('#difficulty_base').animate({'right':'0px'}, 300);
	$('#btn-wrapper').animate({'right':'0px'}, 300,'easeInOutCubic');
	var chance = tyrano.plugin.kag.stat.f["chance"];
	var choice = tyrano.plugin.kag.stat.f["choice"];
	$('#difficulty_base').html('<p id="difficulty_count">残りあと <span class="chance_num">'+ chance +'</span> 回まで'+f.sim.state.name+'可能</p>');

	for(var i=0;i<3;i++){
		if(choice !== ''){
			if(i == choice){
				$('.choice').eq(i).removeClass('active');
			}else{
				$('.choice').eq(i).animate({'opacity':'1'},1000);
			}
		}
		$('.choice').eq(i).css('visibility','visible');		
		$('.choice').eq(i).removeClass('pulse');
	}

	//Judge whether this playing is first time or not
	if($('.exp-btn').hasClass('force-hover')){
	}else{
		$('.exp-btn').removeClass('pulse');
	}

	$('#exp-btn-wrapper').animate({'opacity':'show'},1000);
	$('#exp-btn-wrapper').css('visibility','visible');	
	
	
	//button show/hide according to chance time and exp time
	$(function(){
		if(tyrano.plugin.kag.stat.f["chance"]>0 && tyrano.plugin.kag.stat.f["exptime"]>0){
			$("#do-exp-btn").show();
			$("#exp-result-btn").show();
		}else if(tyrano.plugin.kag.stat.f["chance"]==0 && tyrano.plugin.kag.stat.f["exptime"]>0){
			$("#do-exp-btn").hide();
			$("#exp-result-btn").show();
		}else if(tyrano.plugin.kag.stat.f["chance"]>0 && tyrano.plugin.kag.stat.f["exptime"]==0){
			$("#do-exp-btn").show();
			$("#exp-result-btn").hide();
		}
	});
	console.log('*choice phase');
}

//after choice animation
function choice(){
	var choicenum = tyrano.plugin.kag.stat.f["choice"];
	for(var i=0;i<3;i++){
		if(i == choicenum){
			$('.choice').eq(i).addClass('active');
		}else{
			$('.choice').eq(i).animate({'opacity':'0.1'}, 500);
			$('.choice').eq(i).delay(300).css('visibility', 'hidden');
		}
	}
	$('#exp-btn-wrapper').animate({'opacity':'hide'}, 500);
	$('#exp-btn-wrapper').delay(300).css('visibility', 'hidden');
	console.log('*choicenum:'+choicenum);
}

//initialize game
function clear_class(){
	//remove some classes used in last time.
	$('#dif-btn-wrapper').removeClass('fade-out');
	$('.list').removeClass('done');
	$('#exp-result').empty();
	//for background blur
	blur(0,10);
	console.log('*clear_class');
}

//animation for start window before start game
function difficulty_anim(){
	$('#scenario-title').css('visibility','visible');
	$('#scenario-title').animate({'opacity':'1.0'}, 1000);

	$('#dif-btn-wrapper').delay(500).animate({'opacity':'show'}, 500);	
	console.log('*difficulty_anim');
}

//animation for start window after pressing start button
function scenario_start_anim(){
	$('#scenario-title').animate({'opacity':'0.1'}, 1000);
	$('#scenario-title').delay(1000).css('visibility', 'hidden');

	//remove background blur
	blur(10,0);
	console.log('*scenario-start');
}

//exp-list animation
function exp_list_anim(){
	tyrano.plugin.kag.stat.is_stop = false;
	$('#btn-wrapper').animate({'right':'-1000px'}, 300);
//	$('#exp-list').addClass('flip-left');
	$('#exp-list-title').animate({'left':'0px'},300);
	$('#exp-list').animate({'left':'10px'},300,'easeInOutCubic');
	console.log('*experiment_anim');
}

//exp-result animation
function exp_result_anim(){
	tyrano.plugin.kag.stat.is_stop = false;
	$('#btn-wrapper').animate({'right':'-1000px'},300);
	$('#exp-list-title').animate({'left':'-1000px'},300);
	$('#exp-list').animate({'left':'-1000px'},300);
	$('#exp-result-title').animate({'left':'0px'},300);
	$('#exp-result').animate({'left':'10px'},300,'easeInOutCubic');
	$('#difficulty_base').animate({'right':'-1000px'},300);
	$('#exp-result-expand-btn').show();
	console.log('*exp-result');
}

//exp-back animation
function exp_back_anim(){
//	$('#exp-list').removeClass('flip-left');
	$('#exp-list-title').animate({'left':'-1000px'},300);
	$('#exp-list').animate({'left':'-1000px'},300);
	$('#exp-result-title').animate({'left':'-1000px'},300);
	$('#exp-result').animate({'left':'-1000px'},300);
	$('#difficulty_base').animate({'right':'0px'},300);
	$('#btn-wrapper').animate({'right':'0px'},300,'easeInOutCubic');
	$('#exp-result-expand-btn').hide();
	console.log('*exp-back');
}

//judgement animation
function judge_anim(){
	$('#difficulty_base').animate({'right':'-1000px'},300);
	$('#btn-wrapper').animate({'opacity':'0'},300);
	$('#btn-wrapper').delay(300).animate({'right':'-1000px'},300);
	$('#btn-wrapper').delay(300).animate({'opacity':'1'},1);
	console.log(tyrano.plugin.kag.stat.f.selected);
}

//function for changing scenario
function back_title(){
	$('#tyrano_wrapper').remove();
}