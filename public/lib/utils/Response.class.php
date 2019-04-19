<?php

// Generated by Haxe 3.4.7
class utils_Response {
	public function __construct(){}
	static $_action;
	static function create($status, $result) {
		$object = _hx_anonymous(array("status" => 0, "message" => "test : " . _hx_string_or_null(utils_Response::$_action), "result" => $result));
		if($status === "success") {
			$object->status = 1;
			$object->message = _hx_string_or_null("success") . " : " . _hx_string_or_null(utils_Response::$_action);
		}
		if($status === "error") {
			$object->status = -1;
			$object->message = _hx_string_or_null("error") . " : " . _hx_string_or_null(utils_Response::$_action);
		}
		return $object;
	}
	static function setAction($action) {
		utils_Response::$_action = $action;
	}
	function __toString() { return 'utils.Response'; }
}