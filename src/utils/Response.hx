package utils;

@:enum abstract ResponseStatus(String) from String to String {
	var success = 'success';
	var error   = 'error';
}

typedef ResponseObject = {
	status :Int,
	message:String,
	result :String
}

class Response {

	private static var _action:String;

		/* =======================================================================
			Public - Create
		========================================================================== */
		public static function create(status:ResponseStatus,result:Dynamic):ResponseObject {

			var object:ResponseObject = { status:0, message:'test : ' + _action, result:result };

			if (status == success) {
				object.status  = 1;
				object.message = success + ' : ' + _action;
			}

			if (status == error) {
				object.status  = -1;
				object.message = error + ' : ' + _action;
			}

			return object;

		}

		/* =======================================================================
			Public - Set Action
		========================================================================== */
		public static function setAction(action:String):Void {

            _action = action;

        }

}
