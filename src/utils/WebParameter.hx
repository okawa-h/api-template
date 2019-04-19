package utils;

typedef ParseData = {
    params:Map<String,String>,
    isOK  :Bool,
    ?specifyList:Array<String>
}

class WebParameter {

        /* =======================================================================
            Public - Validate
        ========================================================================== */
        public static function parse(data:Map<String,String>,requiredKeys:Array<String>):ParseData {

            var parseMap   :Map<String,String> = new Map();
            var specifyList:Array<String> = [];

            for (key in requiredKeys) {

                if (data.exists(key)) {
                    parseMap.set(key,data[key]);
                } else {
                    specifyList.push(key);
                }

            }

            var parseData:ParseData = {
                params:parseMap,
                isOK  :specifyList.length <= 0,
            }

            if (0 < specifyList.length) parseData.specifyList = specifyList;

            return parseData;

        }

}
