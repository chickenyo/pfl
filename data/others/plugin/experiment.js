//シナリオ毎の実験リストを表示

// added by HIROKI
function add_list_mod(state){
	$.each(state.choice, function() {
		var html = "<ul>";
//		html += "<li class='list coin'>" + this + "</li>";
		html += "<li class='list factory'>" + this + "</li>";
	});
	html += "</ul>";
	$('#exp-list').append(html);
}

function add_list_exp(state){
	var html = "<ul>";
	$.each(state.experiment, function() {
//		html += "<li class='list coin'>" + this.text + "</li>";
		html += "<li class='list factory'>" + this.text + "</li>";
	});
	html += "</ul>";
//	$('#exp-list').append(html);
	$('#exp-list').html(html);
}

//実験結果を<div id="exp-result">に追加
function add_result(func){
	var resultTitle = tyrano.plugin.kag.stat.f["listname"];
	var exptime = tyrano.plugin.kag.stat.f["exptime"];

	$('#exp-result').append('<h3 class="acdn-title active">'+exptime+'回目：「'+resultTitle+'」の結果<svg id="arrow" width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#ffffff"><g><path d="M 8.341,9.837c 0.005-0.006, 0.007-0.014, 0.012-0.020l 3.491-3.857c 0.195-0.217, 0.195-0.569,0-0.786 c-0.002-0.002-0.004-0.003-0.006-0.004C 11.748,5.065, 11.622,5, 11.482,5L 4.499,5 c-0.143,0-0.27,0.069-0.361,0.176L 4.136,5.174 c-0.195,0.217-0.195,0.569,0,0.786l 3.499,3.877C 7.83,10.054, 8.146,10.054, 8.341,9.837z"></path></g></svg></h3>')
					.append('<div class="acdn-content"><div class="content-0"></div><div class="content-1"></div><div class="content-2"></div></div>');

	// added by HIROKI
	if(typeof(func) !== "undefined") {
		func.call();
	}
	
	var pos = $('.acdn-title').eq(-1).position();
	$('#exp-result').scrollTop(pos.top);
}

function count_exp(){
	var chance = tyrano.plugin.kag.stat.f["chance"];
	var exptime = tyrano.plugin.kag.stat.f["exptime"];
	if (chance>0){
		chance--;
		exptime++;
	}
	tyrano.plugin.kag.stat.f["chance"] = chance;
	tyrano.plugin.kag.stat.f["exptime"] = exptime;
}