<?php

// Generated by Haxe 3.4.7
class Main {
	public function __construct(){}
	static function main() {
		date_default_timezone_set("Asia/Tokyo");
		$params = php_Web::getParams();
		$responseObject = Main::process($params);
		$data = haxe_Json::phpJsonEncode($responseObject, null, null);
		php_Lib::hprint($data);
	}
	static function process($params) {
		if(!$params->exists("action")) {
			return utils_Response::create("error", utils_ErrorMessage::create("parameter", "specify", "action"));
		}
		$action = $params->get("action");
		utils_Response::setAction($action);
		$params->remove("action");
		db_DBManager::init();
		switch($action) {
		case "disable_post":{
			return db_DBConnecter::disable("post", $params);
		}break;
		case "disable_user":{
			return db_DBConnecter::disable("user", $params);
		}break;
		case "get_post_by_id":{
			return db_DBConnecter::getById("post", $params);
		}break;
		case "get_post_list":{
			return db_DBConnecter::getList("post", $params);
		}break;
		case "get_user_by_id":{
			return db_DBConnecter::getById("user", $params);
		}break;
		case "get_user_list":{
			return db_DBConnecter::getList("user", $params);
		}break;
		case "set_post":{
			return db_DBConnecter::set("post", $params, db_table_Post::$BASIC_COLUMNS);
		}break;
		case "set_user":{
			return db_DBConnecter::set("user", $params, db_table_User::$BASIC_COLUMNS);
		}break;
		default:{
			return utils_Response::create("error", utils_ErrorMessage::create("actions", "found", $action));
		}break;
		}
	}
	static function isPublicServer() {
		$hostname = $_SERVER['SERVER_NAME'];
		return _hx_deref(new EReg("****", ""))->match($hostname);
	}
	function __toString() { return 'Main'; }
}