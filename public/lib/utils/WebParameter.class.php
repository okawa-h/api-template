<?php

// Generated by Haxe 3.4.7
class utils_WebParameter {
	public function __construct(){}
	static function parse($data, $requiredKeys) {
		$parseMap = new haxe_ds_StringMap();
		$specifyList = (new _hx_array(array()));
		{
			$_g = 0;
			while($_g < $requiredKeys->length) {
				$key = $requiredKeys[$_g];
				$_g = $_g + 1;
				if($data->exists($key)) {
					$parseMap->set($key, $data->get($key));
				} else {
					$specifyList->push($key);
				}
				unset($key);
			}
		}
		$parseData = _hx_anonymous(array("params" => $parseMap, "isOK" => $specifyList->length <= 0));
		if(0 < $specifyList->length) {
			$parseData->specifyList = $specifyList;
		}
		return $parseData;
	}
	function __toString() { return 'utils.WebParameter'; }
}