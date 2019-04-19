package db;

import sys.db.Connection;
import php.db.PDO;

class DBManager {

	private static var _host    :String = 'localhost';
	private static var _user    :String = 'root';
	private static var _password:String = 'root';
	private static var _connection:Connection;

	/* =======================================================================
		Public - Init
	========================================================================== */
	public static function init():Void {

		var dbName:String = 'test_api-format';

		if (Main.isPublicServer()) {

			setup('xxxx','xxxx','xxxx');
			dbName = 'public';

		}

		_connection = createConnection(dbName,'utf8mb4');

	}

	/* =======================================================================
		Setup
	========================================================================== */
	private static function setup(host:String,user:String,password:String):Void {

		_host     = host;
		_user     = user;
		_password = password;

	}

	/* =======================================================================
		Create Connection
	========================================================================== */
	private static function createConnection(dbName:String,charset:String='utf8'):Connection {

		var dsn:String = 'mysql:host=$_host;dbname=$dbName;charset=$charset';
		return PDO.open(dsn,_user,_password);

	}

		/* =======================================================================
			Public - Request
		========================================================================== */
		public static function request(sql:String):Array<Dynamic> {

			var results   :List<Dynamic>  = _connection.request(sql).results();
			var resultList:Array<Dynamic> = [];

			for (info in results) {
				resultList.push(info);
			}

			return resultList;

		}

		/* =======================================================================
			Public - Select
		========================================================================== */
		public static function select(table:String,?columns:Array<String>,?where:Map<String,String>,?orderby:String):Array<Dynamic> {

			if (columns == null) columns = ['*'];

			var sql = 'select ${columns.join(',')} from $table';
			if (where != null) sql += ' where ' + getJoined(where);
			if (0 < orderby.length) sql += ' order by ' + orderby;

			return request(sql);

		}

		/* =======================================================================
			Public - Insert
		========================================================================== */
		public static function insert(table:String,data:Map<String,String>):Void {

			var keys  :Array<String> = [];
			var values:Array<String> = [];

			for (key in data.keys()) {

				keys.push(key);
				values.push('"${data[key]}"');

			}

			request('insert into $table (${keys.join(',')}) values (${values.join(',')})');

		}

		/* =======================================================================
			Public - Update
		========================================================================== */
		public static function update(table:String,data:Map<String,String>,where:Map<String,String>):Void {

			var now:String = Date.now().toString();
			data['updated_datetime'] = now;

			if (!exists(table,where)) {

				data['created_datetime'] = now;
				insert(table,data);
				return;

			}

			request('update $table set ' + getJoined(data,',') + ' where ' + getJoined(where));

		}

		/* =======================================================================
			Public - Exists
		========================================================================== */
		public static function exists(table:String,where:Map<String,String>):Bool {

			return 0 < select(table,['id'],where).length;

		}

	/* =======================================================================
		Public - Get Joined
	========================================================================== */
	private static function getJoined(map:Map<String,String>,separator:String=' and '):String {

		var array:Array<String> = [];

		for (key in map.keys()) {
			array.push(key + ' = "${map[key]}"');
		}

		return array.join(separator);

	}

}
