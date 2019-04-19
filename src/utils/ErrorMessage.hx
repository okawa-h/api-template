package utils;

import haxe.Json;

@:enum abstract Who(String) from String to String {
	var parameter = 'parameter';
	var database  = 'database';
	var actions   = 'actions';
}

@:enum abstract Became(String) from String to String {
	var specify = 'specify';
	var found   = 'found';
}

class ErrorMessage {

	/* =======================================================================
		Public - Create
	========================================================================== */
    public static function create(who:Who,became:Became,target:Dynamic):String {

		var value:String = Json.stringify(target);

        return switch(became) {

            case found  :'Not found $value in $who.';
            case specify:'Please specify $value in $who.';

        }

    }

}
