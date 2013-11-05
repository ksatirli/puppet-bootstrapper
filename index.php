<?php
$userAgent = $_SERVER['HTTP_USER_AGENT'];
$curlView = './assets/shell/bootstrap.sh';
$browserView = './assets/views/browser.php';

if (preg_match('/curl/', $userAgent)) {
	header('Content-type: application/x-sh');
	require($curlView);
} else {
	header('Content-type: text/html');
	require($browserView);
}