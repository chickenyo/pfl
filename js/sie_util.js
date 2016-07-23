var Util = function(window) {

  // com error message
  this.error = {
    http_status: {
      code_504: "通信に失敗しました。インターネットに接続できていない、あるいはローカルのネットワークに原因がある可能性があります。接続状況を確認してから再度試してみてください。",
      code_500: "データの処理にエラーが起きました。入力したデータに原因がある可能性があります。入力したデータが適切か確認して再度試してみてください。"
    }
  };

  //
  this.initRAjaxArgs();
  this.fv_activeFields = [];

  this.urlVars = this.getUrlVars(window);

};

Util.prototype.getGET = function() {
 return this.urlVars;
};

Util.prototype.disableEnterKeyOnInput = function($) {
  $('input').keypress(function(ev) {
    if ((ev.which && ev.which === 13) || (ev.keyCode && ev.keyCode === 13)) {
      return false;
    } else {
      return true;
    }
  });
};

Util.prototype.loading_html = "<div class='loading_block'><img  src='images/ajax-loader.gif'/></div>";

Util.prototype.rajax_url = "http://dev-stat.doscience.jp/index.php?sid=rajax";
//Util.prototype.rajax_url = "http://pfl.ubuntu.local/index.php?sid=rajax";

Util.prototype.initRAjaxArgs = function() {
  this.rajax_args = {
    "lib": [],
    "dfs": [],
    "runs": [],
    "objs": {},
    "response": {
      "type": "image",
      "objs": [],
      "width": 300, // default size for image
      "height": 300
    }
  };
  // 結果
  this.response = {};
}

//
// running R script
//

Util.prototype.addLibrary = function(lib_name) {
  this.rajax_args.lib.push(lib_name);
}

Util.prototype.addDataFrame = function(df_name, df_url) {
  this.rajax_args.dfs.push({
    "df_name": df_name,
    "df_url": df_url
  });
}

Util.prototype.setObj = function(obj_name, obj_data) {
  this.rajax_args.objs[obj_name] = obj_data;
};

Util.prototype.addResponseObj = function(obj_name) {
  // if string = single
  if(typeof(obj_name) == "string") {
    this.rajax_args.response.objs.push(obj_name);
  // if array
  } else if(Array.isArray(obj_name)) {
    for(var i=0, l=obj_name.length; i<l; i++) {
      this.rajax_args.response.objs.push(obj_name[i]);
    }
  }
};

Util.prototype.setImageSizeOptions = function($, selector, option, selected) {
  var html = "";
  html += "<option value='300,300' selected>300 x 300 </option>";
  html += "<option value='400,300' selected>400 x 300 </option>";
  html += "<option value='640,360' selected>640 x 360 </option>";
  html += "<option value='300,400' selected>300 x 400 </option>";
  html += "<option value='360,640' selected>360 x 640 </option>";

  selected = (typeof(selected) !== "undefined") ? Number(selected) : 0;
  //
  $(selector).append(html);
  //
  $(selector + ".selectpicker").selectpicker('val', selected);
  $(selector + ".selectpicker").selectpicker('refresh');
};

Util.prototype.loadSelectOption = function($, selector, option, selected) {
  //
  selected = (typeof(selected) !== "undefined") ? Number(selected) : -1;
  //
  var html = "";
  //
  $.each(option,function(index,elem) {
    //
    var str = (index === selected) ? "selected" : "";
    //
    html += "<option value='" + index + "' " + str + " >" + elem + "</option>";
  });
  //
  if(typeof(option) !== "undefined") {
    $(selector).empty();
    $(selector).append(html);
  } 
  //
  $(selector + ".selectpicker").selectpicker('refresh');
};

Util.prototype.bindDownloadDialog = function($, selector) {
  // console.log(selector);
  $(selector).on("click", function(event){

    var r = confirm("画像をダウンロードしますか？");
    //
    // console.log(r);
    if(r){
      // download
    } else {
      event.preventDefault();
    }
  });
};

Util.prototype.getArgs = function() {
  return this.rajax_args;
};

Util.prototype.addRun = function(func, args, value) {
  //
  var run = {};
  //
  run.func = func;
  run.args = args;

  if(typeof(value) !== "undefined") {
    run.value = value;
  }

  this.rajax_args.runs.push(run);
};

Util.prototype.addCustRun = function(func, args, value) {

  var run = {};
  //
  run.cust = func;
  run.args = args;

  if(typeof(value) !== "undefined") {
    run.value = value;
  }

  this.rajax_args.runs.push(run);
}

Util.prototype.setResponseFormat = function(type, width, height) {
  this.rajax_args.response.type = type;
  //
  if(typeof(width) !== "undefined" && typeof(height) !== "undefined") {
    this.rajax_args.response.width = (width > 0) ? width : this.rajax_args.response.width;
    this.rajax_args.response.height = (height > 0) ? height : this.rajax_args.response.height;
  }
  
};

Util.prototype.executeR = function(done,fail) {
  var self = this;
  //
  this.rajax_args.response.type = "json";
  //
  $.post(this.rajax_url, {
    "data": JSON.stringify(this.rajax_args)
  }, function(data) {

    // 結果をresponseに保存
    self.response = data.json;

    //
    if(typeof(done) === "function" ) {
      done.call();
    }
    
  }).fail(function() {

    //
    if(event.status === 504) {
      alert(self.error.http_status.code_504);
    } else if(event.status === 500) {
      alert(self.error.http_status.code_500);
    }

    //
    if(typeof(fail) === "function") {
      fail.call({}, event);
    }

  });

  self.initRAjaxArgs();
};

Util.prototype.getResponse = function() {
  return this.response;
}

Util.prototype.generateImage = function($, selector, file_name, size, done, fail) {
  //
  var self = this;
  //
  file_name = (typeof(file_name) !== "undefined") ? file_name : "";

  // loading image
  $(selector).empty();
  $(selector).append(this.loading_html);
  console.log("system:selector:"+selector);
  if(typeof(size) !== "undefined") {
    try {
      // var w = Number($(".container").width());  
      // self.rajax_args.response.width = (size.width > w) ? w : size.width;
      self.rajax_args.response.width = size.width;
      self.rajax_args.response.height = size.height;

    } catch(e) {
      // do something
    }
  }

  $.post(this.rajax_url, {
    //
    "data": JSON.stringify(this.rajax_args)

  }, function(data) {

    //
    var $img = $("<img width='" + self.rajax_args.response.width + "px' src='" + data.json.url + "'/>").on("load", function () {
      // remove loading img
      $(selector + " div.loading_block").remove();
    });

    $(selector).append("<a href='" + data.json.url + "' download='" + file_name + "'></a>");

    // $(selector + " a").append($img).append("<br/>（画像をクリックするダウンロードできます）");
    $(selector + " a").append($img);

    // self.bindDownloadDialog($, selector + " img");

    // run callback
    if(typeof(done) === "function") {
      done.call();
    }

    self.initRAjaxArgs();
    
  }).fail(function(event) {

    //
    if(event.status === 504) {
      alert(self.error.http_status.code_504);
    } else if(event.status === 500) {
      alert(self.error.http_status.code_500);
    }
    
    //
    if(typeof(fail) === "function") {
      fail.call({}, event);
    }

  });

};

Util.prototype.transposeArray = function(a) {

  if(typeof(a) === "object") {
    a = Object.keys(a).map(function (key) { return a[key]; });
  }

  var col_data = [];

  for(var i=0, ncol=a[0].length; i<ncol; i++) {
    var row_data = [];
    $.each(a, function(m,e) {
      row_data.push(a[m][i]);
    });
    //
    col_data.push(row_data);
  }

  return col_data;
};

Util.prototype.fv_set = function($, selector, fields) {
  //
  $(selector).formValidation({
    framework: 'bootstrap',
    excluded: [':hidden', ':not(:visible)'],
    locale: 'ja_JP',
    fields,
    icon: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    }
  });

};

Util.prototype.fv_validate = function($,selector) {
  //
  $(selector).formValidation("validate");
  //
  var fv = $(selector).data('formValidation');
  //
  return (fv.getInvalidFields().length > 0) ? false : true;

};

Util.prototype.fv_resetForm = function($, selector) {
  $(selector).data('formValidation').resetForm();
}

Util.prototype.fv_destroy = function($,selector) {
    //
  if(typeof( $(selector).data('formValidation') ) !== "undefined") {
    //
    try {
       $(selector).formValidation("destroy");
       console.log("destroyed");
    } catch(e) {
      // do nothing
    }
  }
}

Util.prototype.getUrlVars = function(window) {
  if(typeof(window) !== "undefined") {
    var vars = {};
    window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
        vars[key] = value;
    });
    return vars;    
  } else {
    return null;
  }
};

Util.prototype.localize = function($, lang_def) {
    var opts = {
        language : "en",
        // pathPrefix: "./language/",
        skipLanguage : "jp"
    };
    
    $("[data-localize]").localize(lang_def, opts);
}

Util.prototype.translate = function($) {
  var dom = $("[lang-en]");
  var i = 0, len = dom.length; 
  for(i; i < len ; i++) {
    $(dom[i]).html($(dom[i]).attr("lang-en"));
    if(typeof($(dom[i]).attr("placeholder")) !== "undefined") {
      $(dom[i]).attr("placeholder", $(dom[i]).attr("lang-en"));
    }
  }
}
