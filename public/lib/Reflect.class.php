<?php

// Generated by Haxe 3.4.7
class Reflect {
	public function __construct(){}
	static function field($o, $field) {
		return _hx_field($o, $field);
	}
	static function fields($o) {
		if($o === null) {
			return new _hx_array(array());
		}
		if($o instanceof _hx_array) {
			return new _hx_array(array('concat','copy','insert','iterator','length','join','pop','push','remove','reverse','shift','slice','sort','splice','toString','unshift'));
		} else {
			if(is_string($o)) {
				return new _hx_array(array('charAt','charCodeAt','indexOf','lastIndexOf','length','split','substr','toLowerCase','toString','toUpperCase'));
			} else {
				return new _hx_array(_hx_get_object_vars($o));
			}
		}
	}
	static function isFunction($f) {
		if(!(is_array($f) && is_callable($f)) || _hx_is_lambda($f)) {
			$tmp = null;
			if(is_array($f)) {
				$o = $f[0];
				$field = $f[1];
				$tmp = _hx_has_field($o, $field);
			} else {
				$tmp = false;
			}
			if($tmp) {
				return $f[1] !== "length";
			} else {
				return false;
			}
		} else {
			return true;
		}
	}
	function __toString() { return 'Reflect'; }
}
