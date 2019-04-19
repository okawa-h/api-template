package db.table;

import db.table.Table;

@:enum abstract PostColumn(String) from String to String {
	var id                = 'id';
	var user_id           = 'user_id';
	var text              = 'text';
    var schedule_datetime = 'schedule_datetime';
	var created_datetime  = 'created_datetime';
	var updated_datetime  = 'updated_datetime';
	var is_active         = 'is_active';
}

class Post extends Table {

	public static var BASIC_COLUMNS:Array<String> = [id,user_id,text,schedule_datetime];

	/* =======================================================================
		Public - Constractor
	========================================================================== */
	public function new():Void {

		super('post',[
			id                => id,
			user_id           => user_id,
            text              => text,
            schedule_datetime => schedule_datetime,
			created_datetime  => created_datetime,
			updated_datetime  => updated_datetime,
			is_active         => is_active
		]);

	}

}