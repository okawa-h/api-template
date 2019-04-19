package db.table;

import db.*;

class Table {

	private var _tableName:String;
	private var _columnMap:Map<String,String>;

	/* =======================================================================
		Public - Constractor
	========================================================================== */
	public function new(tableName:String,columnMap:Map<String,String>):Void {

		_tableName = tableName;
		_columnMap = columnMap;

	}

		/* =======================================================================
			Public - Get Table Name
		========================================================================== */
		public function getTableName():String {

			return _tableName;

		}

		/* =======================================================================
			Public - Get By Id
		========================================================================== */
		public function getById(id:String,?columns:Array<String>):Dynamic {

			return DBManager.select(_tableName,columns,['id'=>id])[0];

		}

		/* =======================================================================
			Public - Get Latest Row By Id
		========================================================================== */
		public function getLatestRowById(?columns:Array<String>):Dynamic {

			return DBManager.select(_tableName,columns,null,'id desc limit 1')[0];

		}

		/* =======================================================================
			Public - Get Filter List
		========================================================================== */
		public function getFilterList(columns:Array<String>,where:Map<String,String>,?orderby:String):Array<Dynamic> {

			return DBManager.select(_tableName,columns,where,orderby);

		}

		/* =======================================================================
			Public - Get List
		========================================================================== */
		public function getList(?columns:Array<String>,isIncludeActive:Bool=true,?orderby:String):Array<Dynamic> {

			var where:Map<String,String> = isIncludeActive ? ['is_active'=>'1'] : null;
			return DBManager.select(_tableName,columns,where,orderby);

		}

		/* =======================================================================
			Public - Set Row
		========================================================================== */
		public function setRow(row:Map<String,String>):Void {

			row = validateColumns(row);
			DBManager.insert(_tableName,row);

		}

		/* =======================================================================
			Public - Set Rows
		========================================================================== */
		public function setRows(rowList:Array<Map<String,String>>):Void {

			for (i in 0 ... rowList.length) {
				setRow(rowList[i]);
			}

		}

		/* =======================================================================
			Public - Enable
		========================================================================== */
		public function enable(id:String):Void {

			DBManager.update(_tableName,['is_active'=>'1'],['id'=>id]);

		}

		/* =======================================================================
			Public - Disable
		========================================================================== */
		public function disable(id:String):Void {

			DBManager.update(_tableName,['is_active'=>'0'],['id'=>id]);

		}

		/* =======================================================================
			Public - Is Disable
		========================================================================== */
		public function isDisable(id:String):Bool {

			return getById(id,['is_active']) == '0';

		}

	/* =======================================================================
		Validate
	========================================================================== */
	private function validateColumns(row:Map<String,String>):Map<String,String> {

		for (key in row.keys()) {

			if (!_columnMap.exists(key)) row.remove(key);

		}

		return row;

	}

}
