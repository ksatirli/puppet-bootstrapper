<?php
/*
	          __                      __             __    _
	   _____ / /_ _____ __  __ _____ / /_ ___   ____/ /   (_)____
	  / ___// __// ___// / / // ___// __// _ \ / __  /   / // __ \
	 (__  )/ /_ / /   / /_/ // /__ / /_ /  __// /_/ /_  / // /_/ /
	/____/ \__//_/    \__,_/ \___/ \__/ \___/ \__,_/(_)/_/ \____/

	con.structed.io - masterless Puppet bootstraper

	This file checks the client's user agent and decides on which view to serve.
*/

$userAgent = $_SERVER['HTTP_USER_AGENT'];
$shellView = './assets/shell/bootstrap.sh';
$browserView = './assets/views/browser.php';

if (preg_match('/curl/', $userAgent) || (preg_match('/wget/', $userAgent)) {
	header('Content-type: application/x-sh');
	require($curlView);
} else {
	header('Content-type: text/html');
	require($browserView);
}