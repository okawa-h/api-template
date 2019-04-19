package db;

import db.table.*;
import utils.ErrorMessage;
import utils.WebParameter;
import utils.Response;

@:enum abstract TableName(String) from String to String {
	var user = 'user';
	var post = 'post';
}

class DBConnecter {

	/* =======================================================================
		Common
	========================================================================== */

		/* =======================================================================
			Public - Get By Id
		========================================================================== */
		public static function getById(tableName:TableName,params:Map<String,String>):ResponseObject {

			if (!params.exists('id')) return Response.create(error,ErrorMessage.create(parameter,specify,'id'));

			var data:Dynamic = getTableInstanse(tableName).getById(params['id']);

			if (data == null) return Response.create(error,ErrorMessage.create(database,found,'data'));
			return Response.create(success,data);

		}

		/* =======================================================================
			Public - Get List
		========================================================================== */
		public static function getList(tableName:TableName,params:Map<String,String>):ResponseObject {

			var data:Array<Dynamic> = getTableInstanse(tableName).getList();

			if (data == null) return Response.create(error,ErrorMessage.create(database,found,'data'));
			return Response.create(success,data);

		}

		/* =======================================================================
			Public - Set
		========================================================================== */
		public static function set(tableName:TableName,params:Map<String,String>,requiredColumns:Array<String>):ResponseObject {

			var parseData:ParseData = WebParameter.parse(params,requiredColumns);
			if (!parseData.isOK) return Response.create(error,ErrorMessage.create(parameter,specify,parseData.specifyList));

			var table:Table = getTableInstanse(tableName);
			table.setRow(parseData.params);
			return Response.create(success,table.getLatestRowById());

		}

		/* =======================================================================
			Public - Enable
		========================================================================== */
		public static function enable(tableName:TableName,params:Map<String,String>):ResponseObject {

			if (!params.exists('id')) return Response.create(error,ErrorMessage.create(parameter,specify,'id'));

			var id   :String  = params['id'];
			var table:Table   = getTableInstanse(tableName);
			var data :Dynamic = table.getById(id);
			table.enable(id);

			if (data == null) return Response.create(error,ErrorMessage.create(database,found,'data'));
			return Response.create(success,data);

		}

		/* =======================================================================
			Public - Disable
		========================================================================== */
		public static function disable(tableName:TableName,params:Map<String,String>):ResponseObject {

			if (!params.exists('id')) return Response.create(error,ErrorMessage.create(parameter,specify,'id'));

			var id   :String  = params['id'];
			var table:Table   = getTableInstanse(tableName);
			var data :Dynamic = table.getById(id);
			table.disable(id);

			if (data == null) return Response.create(error,ErrorMessage.create(database,found,'data'));
			return Response.create(success,data);

		}

	/* =======================================================================
		Get Table Instanse
	========================================================================== */
	private static function getTableInstanse(tableName:TableName):Table {

		return switch(tableName) {
                case user: new User();
                case post: new Post();
            }

	}

	/* =======================================================================
		User
	========================================================================== */

	/* =======================================================================
		Post
	========================================================================== */

}
