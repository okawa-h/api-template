package ;

import haxe.Json;
import php.Web;
import php.Lib;
import db.*;
import db.table.*;
import utils.ErrorMessage;
import utils.Response;

class Main {

	/* =======================================================================
		Constructor
	========================================================================== */
	public static function main():Void {

		untyped __call__('date_default_timezone_set','Asia/Tokyo');

		var params:Map<String,String> = Web.getParams();

		var responseObject:ResponseObject = process(params);
		var data:String = Json.stringify(responseObject);

		Lib.print(data);

	}

	/* =======================================================================
		Process
	========================================================================== */
	private static function process(params:Map<String,String>):ResponseObject {

		if (!params.exists('action')) return Response.create(error,ErrorMessage.create(parameter,specify,'action'));

		var action:String = params['action'];
		Response.setAction(action);
		params.remove('action');

		DBManager.init();

		return switch (action) {

			/* =======================================================================
				User
			========================================================================== */
			case 'get_user_by_id':DBConnecter.getById(user,params);
			case 'get_user_list' :DBConnecter.getList(user,params);
			case 'set_user'      :DBConnecter.set(user,params,User.BASIC_COLUMNS);
			case 'disable_user'  :DBConnecter.disable(user,params);

			/* =======================================================================
				Post
			========================================================================== */
			case 'get_post_by_id':DBConnecter.getById(post,params);
			case 'get_post_list' :DBConnecter.getList(post,params);
			case 'set_post'      :DBConnecter.set(post,params,Post.BASIC_COLUMNS);
			case 'disable_post'  :DBConnecter.disable(post,params);

			default:Response.create(error,ErrorMessage.create(actions,found,action));

		}

	}

		/* =======================================================================
			Public - Is Public Server
		========================================================================== */
		public static function isPublicServer():Bool {

			var hostname:String = Web.getHostName();
			return (~/****/.match(hostname));

		}

}
