package db.table;

import db.table.Table;

@:enum abstract UserColumn(String) from String to String {
	var id               = 'id';
	var name             = 'name';
	var created_datetime = 'created_datetime';
	var updated_datetime = 'updated_datetime';
	var is_active        = 'is_active';
}

class User extends Table {

	public static var BASIC_COLUMNS:Array<String> = [id,name];

	/* =======================================================================
		Public - Constractor
	========================================================================== */
	public function new():Void {

		super('user',[
			id               => id,
			name             => name,
			created_datetime => created_datetime,
			updated_datetime => updated_datetime,
			is_active        => is_active
		]);

	}

}