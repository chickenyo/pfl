[_tb_system_call storage=system/_store.ks]

;[deffont face=mplus bold=false]
;[resetfont  ]

//load plugin
[loadjs storage="plugin/experiment.js"]
[loadjs storage="plugin/simulation.js"]

[iscript]
// added by HIROKI
//f.sim = new Sim("store");
f.sim = new Sim("store");
[endscript]

[cm  ]
[bg  time="300"  method="crossfade"  storage="title.jpg"  ]

;define variables Tyrano Scripts uses
[eval exp="f.difficulty=''"]
[eval exp="f.chance=0"]
[eval exp="f.exptime=0"]
[eval exp="f.answer=''"]
[eval exp="f.choice=''"]
[eval exp="f.listnum=''"]
[eval exp="f.listname=''"]
[eval exp="f.btnflag=''"]

[iscript]
//add dif. btn div
	$('#tyrano_base').append('<div id="dif-btn-wrapper"><div class="difficulty" id="easy"><span class="difficulty_name">EASY</span></div><div class="difficulty" id="normal"><span class="difficulty_name">NORMAL</span></div><div class="difficulty" id="hard"><span class="difficulty_name">HARD</span></div><div id="start-btn-wrapper"><button id="start-btn"><span>START</span></button><button id="back-btn"><span>BACK</span></button></div></div>');

//add button div
	$('#tyrano_base').append('<div id="btn-wrapper"></div>');
	
//add choice buttons wrapper div
	$('#btn-wrapper').append('<div id="choice-btn-wrapper">');
	
//add choice buttons		
	$('#choice-btn-wrapper').append('<button class="choice choice-a" value="0"><img src="./data/image/buttons/store_choice_btn.png"><span class="choice_name">'+f.sim.state.choice[0]+'</span></button><button class="choice choice-b" value="1"><img src="./data/image/buttons/store_choice_btn.png"><span class="choice_name">'+f.sim.state.choice[1]+'</span></button><button class="choice choice-c" value="2"><img src="./data/image/buttons/store_choice_btn.png"><span class="choice_name">'+f.sim.state.choice[2]+'</span></button>');

//add experiment buttons wrapper div
	$('#btn-wrapper').append('<div id="exp-btn-wrapper"></div>');

//add experiment buttons
	$('#exp-btn-wrapper').append('<button id="do-exp-btn" class="exp-btn force-hover pulse" value="*experiment"><img src="./data/image/buttons/do_exp_btn_on.png"><span>'+f.sim.state.name+'する</span></button><button id="exp-result-btn" class="exp-btn" value="*exp-result"><img src="./data/image/buttons/exp_result_btn_off.png"><span>'+f.sim.state.name+'結果</span></button>');	

//add Exp. list div（htmlタグでもいいかも）
	$('#tyrano_base').append('<div id="exp-list-title"><h2>'+f.sim.state.name+'リスト</h2></div><div id="exp-list" ontouchmove="event.stopPropagation()"></div><div id="show_dialog" style="display:none;"></div>');

	add_list_exp(f.sim.state);

//add counting div
	$('#tyrano_base').append('<div id="difficulty_base"></div>');

//Add Exp. result div（htmlタグでもいいかも）
	$('#tyrano_base').append('<button id="exp-result-expand-btn" class="button sys-btn">全画面表示</button><button id="exp-result-expand-close" class="button sys-btn">戻る</button><div id="exp-result-title"><h2>'+f.sim.state.name+'結果</h2></div><div id="exp-result" ontouchmove="event.stopPropagation()"></div>');

	
//Add scenario title
	$('#tyrano_base').append('<div id="scenario-title"><h1>お客さんが待たなくてよいレジの個数って？</h1></div><img id="scenario-title-img" src="./data/image/store.png"/>');	

[endscript]

[iscript]
//initialize difficulty
	$(document).ready(function(){
		var difficulty = $('.difficulty').eq(1).attr('id');
		$('.difficulty').eq(1).addClass('pulse');
		$('.difficulty').eq(1).addClass('active');
		TG.kag.stat.f["difficulty"] = difficulty;
		TG.kag.stat.f["chance"] = 2;
		console.log('difficultyinit:'+ difficulty);
		return
	});
[endscript]

[iscript]
//choose difficulty
	$('#tyrano_base').on('click', '.difficulty', function(){
//	$(document).on('click', '.difficulty', function(){
		var difficulty = $(this).attr('id');
		TG.kag.stat.f["difficulty"] = difficulty;
		for(var i=0;i<3;i++){
			$('.difficulty').removeClass('pulse');
			$('.difficulty').removeClass('active');
		}
		$(this).addClass('pulse');
		$(this).addClass('active');	
		
		console.log('clicked');
		console.log('difficulty:'+ difficulty);
		return
	});
[endscript]

[iscript]
//when start button is pressed, system starts scenario 
	$('#tyrano_base').on('click', '#start-btn',function(){
//	$(document).on('click', '#start-btn',function(){
		var chance = TG.kag.stat.f["chance"];
		var difficulty = TG.kag.stat.f["difficulty"];
		if(difficulty == "easy"){
			chance = 3;
		}else if(difficulty == "normal"){
			chance = 2;
		}else{
			chance = 1;
		}
		TG.kag.stat.f["chance"] = chance;
		$('#dif-btn-wrapper').addClass('fade-out');
		$('#dif-btn-wrapper').hide();
		console.log('chance:'+chance);
		TG.kag.ftag.startTag("jump",{target:"*start"});
	});
//when back button is pressed, back to title menu	
	$('#tyrano_base').on('click', '#back-btn',function(){
		console.log('back to title menu.');
		$('#dif-btn-wrapper').addClass('fade-out');
		$('#dif-btn-wrapper').hide();		
//		TG.kag.ftag.startTag("jump",{target:"*backtitle", storage:"factory.ks"});
//		tyrano.plugin.kag.tag.button["title"];
		location.reload();
	});
[endscript]

[iscript]
// show experiment result
$(function(){
	var acdnItem = $('#exp-result');
//div open or close
	acdnItem.on('click', acdnItem.find('h3'), function(e){
		console.log('click');
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
[endscript]

[iscript]
//リストクリック時動作
	$('#tyrano_base').on('click', '.list', function(){
//	$(document).on('click', '.list',function(){
		var listval = $(this).text();
		var listnum = $(this).index();
		
		TG.kag.stat.f["listnum"] = listnum;
		TG.kag.stat.f["listname"] = listval;

		console.log('list clicked');
		console.log('listnum:'+listnum);

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
				"OK": function() {
					$(this).dialog('close');
					
					//count up experiment challenge time and count down chance time
					count_exp();
					//add div for result
					add_result();
					//and then run generating image function(this arrangement is important for function to detect last class of .acdn-content. see simulation.js.)
					f.sim.runExp(item.args);
					
					console.log("system:exp-time:"+TG.kag.stat.f["exptime"]);
					console.log("system:chance:"+TG.kag.stat.f["chance"]);
					console.log("system:added result div");
					
					$('#difficulty_base').animate({'right':'-1000px'},300);
					
					$('#exp-list-title').animate({'left':'-1000px'},300);
					$('#exp-list').animate({'left':'-1000px'},300);
					$('#exp-result-title').delay(300).animate({'left':'0px'},300);
					
					$('#exp-result').delay(300).animate({'left':'10px'},300,'easeInOutCubic');
					$('#exp-result-expand-btn').delay(1000).show();

//					$('.list').delay(1000).eq(listnum).addClass('done');
					$('.list').eq(listnum).delay(1000).queue(function() {
						$(this).addClass('done').dequeue();
						$(this).append('（'+TG.kag.stat.f["exptime"]+'回目に'+f.sim.state.name+'済）');
					});
				},
				"Cancel": function() {
					$(this).dialog('close');
				}
			}
		});
	});
[endscript]

[iscript]
	$('#tyrano_base').on('click', '#exp-result-expand-btn', function(){
		$('#exp-result').css('top','0')
						.css('height','100%')
						.css('background-color', 'rgba(0,0,0,0.5)');
		$('#exp-result-expand-close').show();
	}).on('click', '#exp-result-expand-close', function(){
		$('#exp-result').css('top','62px')
						.css('height','500px')
						.css('background-color', 'rgba(255,255,255,0.5)');
		$('#exp-result-expand-close').hide();
	});
[endscript]

[iscript]
$(function(){
//choice button click action
	$(document).on('mouseup', '.choice', function(){
		var val = $(this).val();
		TG.kag.stat.f["choice"] = val;
		TG.kag.ftag.startTag("jump",{target:"*choice"+val});
		console.log('choice:'+val);
	});
//exp button click action
	$(document).on('mouseup', '.exp-btn', function(){
		var val = $(this).val();
		TG.kag.ftag.startTag("jump",{target:val});
	});
});
[endscript]

[iscript]
$(function(){
//choice button hover action
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
[endscript]

[iscript]
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

[endscript]

[iscript]
//yes-no etc button hover action
$(function(){
//	$('.sys-btn, .button, #start-btn, .black').hover(
	$('#start-btn').hover(
		function(){
			$(this).addClass('pulse');
		},
		function(){
			$(this).removeClass('pulse');
		}
	);	
});
[endscript]


*difficulty
[clearstack]
;If clearfix is active, role buttons will be hidden.
;[clearfix]
[cm]
[if eval exp="f.splaytime>0"]
	[cm  ]
	[bg  time="300"  method="crossfade"  storage="title.jpg"  ]
	;[tb_image_show  time="1000"  storage="default/logo2_dummy.png"  x="160"  y="180"  width="640"  height="85"  _clickable_img=""  name="img_15"  ]
	[iscript]
		$('#dif-btn-wrapper').removeClass('fade-out');
		$('.list').removeClass('done');
		add_list_exp(f.sim.state);
		$('#exp-result').empty();
	[endscript]
[endif]

[tb_ptext_hide  time="0"  ]
[tb_hide_message_window  ]
[iscript]
	$('#scenario-title').animate({'left':'160px'},300);
	$('#scenario-title-img').animate({'left':'168px'},300);
	$('#dif-btn-wrapper').delay(500).animate({'opacity':'show'}, 500);
[endscript]
[s]


*start

[cm]
[tb_hide_message_window  ]
[iscript]
	$('#scenario-title').animate({'left':'1000px'},500);
	$('#scenario-title-img').animate({'left':'-1000px'},500);
[endscript]
;[tb_image_hide  time="1000"  ]
[eval exp="f.splaytime = f.splaytime + 1"]
[jump  storage="store.ks"  target="*scenario-store"  ]


*scenario-store

[wait  time="300"  ]
[bg  time="500"  method="crossfade"  storage="store_bg1.png"  ]

[layopt layer=0 visible=true]
[mtext name="mtext" text="スーパーマーケット" x=320 y=240 size=36 time=500 in_effect="fadeInLeft" in_sync="true" out_effect="fadeOutRight" out_sync="true"]

[chara_show  name="ceo" width=640 time="500" top="120" left="160" wait="true"  ]
[tb_show_message_window  ]
[anim name=role_button opacity=255 time=300 ]

#社長
おお、よく来てくれたな。[r]
頼みというのは他でもない、うちの店に関わる問題なんだ。[p]

#社長
君も知っての通り、うちはこの一体に3店舗、スーパーを構えている。[r]
君たちの頑張りもあって、売上げは上々だ。[p]


#社長
だがなこの前、レジの列が長すぎるとクレームがあってね。[r]
今も見ての通り、夕方でもないのにこのレジ待ちの列だ。[r]
これではそのうちお客様も愛想を尽かしていってしまう[p]

#社長
そこでだ。君にはどの店に問題があるのか調べて欲しいんだ。[r]
どこのお店にレジを増やせばよいのかが分かれば、効率的に改善できるだろう。[r]
期待しているよ。[p]

[tb_hide_message_window  ]
[chara_hide  name="ceo"  time="500"  wait="true"  ]
[bg  time="500"  method="crossfade"  storage="store_bg2.png" wait="true" ]
[mtext name="mtext" text="待ち時間の長い店を当てろ！" x=240 y=240 size=36 time=500 in_effect="fadeInLeft" in_delay=10 in_sync="false" out_effect="fadeOutRight" out_delay=10 out_sync="false"]
[jump  storage="store.ks"  target="*choice-exp"  ]
[s  ]


*choice-exp

[iscript]
	$('.choice').css('opacity','1');
[endscript]
[tb_show_message_window  ]


*choices

[clearstack]
[cancelskip]
[iscript]
	TG.kag.stat.is_stop = false;
//OK
	$('#difficulty_base').animate({'right':'0px'}, 300);
	$('#btn-wrapper').animate({'right':'0px'}, 300,'easeInOutCubic');
	var chance = this.kag.stat.f["chance"];
	var choice = this.kag.stat.f["choice"];
	$('#difficulty_base').html('<p id="difficulty_count">残りあと <span class="chance_num">'+ chance +'</span> 回まで調査可能</p>');

//	$('.choice').css('visibility','visible');
	for(var i=0;i<3;i++){
		if(choice !== ''){
			if(i == choice){
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
	
[endscript]



[iscript]
//OK
	$(function(){
		if(TG.kag.stat.f["chance"]>0 && TG.kag.stat.f["exptime"]>0){
			$("#do-exp-btn").show();
			$("#exp-result-btn").show();
		}else if(TG.kag.stat.f["chance"]==0 && TG.kag.stat.f["exptime"]>0){
			$("#do-exp-btn").hide();
			$("#exp-result-btn").show();
		}else if(TG.kag.stat.f["chance"]>0 && TG.kag.stat.f["exptime"]==0){
			$("#do-exp-btn").show();
			$("#exp-result-btn").hide();
		}
	});
	console.log('*choices');
[endscript]

#問題
次のA、B、Cのうち、レジに問題のある店舗はどれ？

[s  ]


*choice0
[cm]
[iscript]
	var choicenum = TG.kag.stat.f["choice"];
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
	console.log('choicenum:'+choicenum);
[endscript]
[emb exp="f.sim.state.choice[0]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="store.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=0" ]
[glink name="sys-btn" storage="store.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*choice1
[cm]
[iscript]
	var choicenum = TG.kag.stat.f["choice"];
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
	console.log('choicenum:'+choicenum);
[endscript]
[emb exp="f.sim.state.choice[1]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="store.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=1" ]
[glink name="sys-btn" storage="store.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*choice2
[cm]
[iscript]
	var choicenum = TG.kag.stat.f["choice"];
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
	console.log('choicenum:'+choicenum);
[endscript]
[emb exp="f.sim.state.choice[2]"]でいいですか？[r]
[glink name="sys-btn, sys-btn-yes" storage="store.ks" size="20" x="320" y="300" target="*judgement" text="はい" exp="f.selected=2" ]
[glink name="sys-btn" storage="store.ks" size="20" x="480" y="300" target="*choices" text="いいえ"  ]
[s ]


*experiment

[cm  ]
[message_window_to_right]
[anim name=role_button left="+=500" time=300 ]

[iscript]
	TG.kag.stat.is_stop = false;
	$('#btn-wrapper').animate({'right':'-1000px'}, 300);
//	$('#exp-list').addClass('flip-left');
	$('#exp-list-title').animate({'left':'0px'},300);
	$('#exp-list').animate({'left':'10px'},300,'easeInOutCubic');
	console.log('*experiment');
[endscript]
[eval exp="f.btnflag='true'"]
[glink  name="sys-btn" storage="store.ks"  size="20"  text="戻る"  target="*exp-back"  x="824"  y="578"  ]
[s  ]


*exp-result

[cm]
;[anim name=role_button opacity=0 time=300 ]
[if exp="f.btnflag=='false'"]
	[message_window_to_right]
	[anim name=role_button left="+=500" time=300 ]
[endif]
[eval exp="f.btnflag='true'"]
[iscript]
	TG.kag.stat.is_stop = false;
	$('#btn-wrapper').animate({'right':'-1000px'},300);
	$('#exp-list-title').animate({'left':'-1000px'},300);
	$('#exp-list').animate({'left':'-1000px'},300);
	$('#exp-result-title').animate({'left':'0px'},300);
	$('#exp-result').animate({'left':'10px'},300,'easeInOutCubic');
	$('#difficulty_base').animate({'right':'-1000px'},300);
//	$('#exp-result-expand-btn').animate({'right':'140px'}, 300);
	$('#exp-result-expand-btn').show();
	console.log('*exp-result');
[endscript]

[glink  name="sys-btn" storage="store.ks"  size="20" text="戻る" target="*exp-back"  x="824"  y="578"  ]
[s  ]


*exp-back

[cm]
[iscript]
//	$('#exp-list').removeClass('flip-left');
	$('#exp-list-title').animate({'left':'-1000px'},300);
	$('#exp-list').animate({'left':'-1000px'},300);
	$('#exp-result-title').animate({'left':'-1000px'},300);
	$('#exp-result').animate({'left':'-1000px'},300);
	$('#difficulty_base').animate({'right':'0px'},300);
	$('#btn-wrapper').animate({'right':'0px'},300,'easeInOutCubic');
	$('#exp-result-expand-btn').hide();	
	console.log('*exp-back');
[endscript]
;[anim name=role_button opacity=255 time=300 ]
[anim name=role_button left="-=500" time=300 ]
[eval exp="f.btnflag='false'"]
[message_window_to_left]
[wait time=300]
[jump  storage="store.ks"  target="*choices"  ]
[s  ]


*judgement

[cm]
[tb_hide_message_window  time="100"  ]
[iscript]
	$('#difficulty_base').animate({'right':'-1000px'},300);

//	for(var i=0;i<3;i++){
//		$('.choice').eq(i).animate({'opacity':'0.1'},1000);
//		$('.choice').eq(i).css('visibility','hidden');	
//		$('.choice').eq(i).removeClass('pulse');
//	}

	$('#btn-wrapper').animate({'opacity':'0'},300);
	$('#btn-wrapper').delay(300).animate({'right':'-1000px'},300);
	$('#btn-wrapper').delay(300).animate({'opacity':'1'},1);
//	$('.choice').animate({'opacity':'0.1'},1000);
//	$('.choice').css('visibility','hidden');		
//	$('.choice').removeClass('pulse');
	console.log(f.selected);
[endscript]

[wait time=1500]

[if exp="f.sim.state.answer[f.selected]==true"]
	correct
	[bg  time="500"  method="crossfade"  storage="store_bg1.png"  ]
	[image layer=2 page=fore storage=correct.png time="500"]

	[glink  name="sys-btn"  storage="store.ks"  size="20" width="100px" text="もう1回"  x="271"  y="480"  target="*back-top"  ]
	[glink  name="sys-btn" storage="store.ks"  size="20"  width="100px" text="タイトルヘ"  x="555"  y="480"  target="*backtitle"  ]

[else]
	incorrect
	[image layer=2 page=fore storage=incorrect.png time="500"]

	[glink name="sys-btn" storage="store.ks"  size="20" width="100px" text="もう1回"  x="271"  y="480"  target="*back-top"  ]
	[glink name="sys-btn"  storage="store.ks"  size="20" width="100px" text="タイトルヘ"  x="555"  y="480"  target="*backtitle"  ]

[endif]
[s]

*back-top
[cm]

[eval exp="f.chance=0"]
[eval exp="f.exptime=0"]
[freeimage layer=2 page=fore]

[jump  storage="store.ks"  target="*difficulty"  ]
[s]

*backtitle

[cm]
[iscript]
	location.reload();
[endscript]
;[freeimage layer=2 page=fore]
;[bg  time="300"  method="crossfade"  storage="title.jpg"  ]
;[jump  storage="title_screen.ks"  target="*scenario-index"  ]
[s]