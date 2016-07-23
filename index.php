<?php 

// rajax location
$rajax_url = "http://localhost/rajax-dev";

// page id
$pid = NULL;
if (isset($_GET["pid"])) {
	$pid = filter_var($_GET["pid"], FILTER_SANITIZE_URL);
} else {
	$pid = "index";
}

// service id
$sid = NULL;
if(isset($_GET["sid"])) {
	$sid = filter_var($_GET["sid"], FILTER_SANITIZE_URL);
}

// post data for rajax
$post = NULL;
if(isset($_POST["data"])) {
	// TODO: add some filter or validation code (So far post data is checked in the R side)
	$post = $_POST;
}

// for request to rajax
if( !is_null($sid) && $sid === "rajax" ) {

	// TODO: check if rajax request is from itls app; it should be noted that it is not necessarily true as referer could be edited.
	$ref_host = isset($_SERVER["HTTP_REFERER"]) ? parse_url($_SERVER["HTTP_REFERER"])["host"] : NULL;
	
	// if request is valid, forward rajax request to rajax or rapache
	if( !is_null($post) && $ref_host === $_SERVER["HTTP_HOST"] ) {
		// header
		$options = array(
		    'http' => array(
		        'header'  => "Content-type: application/x-www-form-urlencoded",
		        'method'  => 'POST',
		        'content' => http_build_query($post)
		    ),
		);
		// make a fowarding request
		$context  = stream_context_create($options);
		// send the request and receive the result
		$result = file_get_contents($rajax_url, false, $context);
		// when failed
		if ($result === FALSE) { 
			//
			preg_match('/HTTP\/1\.[0|1|x] ([0-9]{3})/', $http_response_header[0], $matches);
			$status_code = $matches[1];
			//
			switch ($status_code) {
				case "500": {
					echo http_response_code(500);
				}	
			}
			//
			error_log("Error: No response from rajax or rapache", 0);

		// when succeeded
		} else {
			header('Content-Type: application/json');
			echo $result;
		}	
	// otherwise invalid or someone tried to access rajax directly
	} else {
		error_log("Warning: Someone tried to access rajax directly", 0);
	}
	// finish the script
	exit;
}

?>