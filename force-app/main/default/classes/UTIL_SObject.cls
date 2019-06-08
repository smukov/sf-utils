public without sharing class UTIL_SObject {

    /**
     * Get all fields that can be queried for a specific Object
     * 
     * @param  sObj     SObjectType to retrieve fields for
     * @param  options  which Security checks to perform when building a Query
     * @return          all fields that can be queried for the specified sObject
     */
    public static List<Schema.SObjectField> getQueriableFieldsForSObject(
        Schema.SObjectType sObj, QueryBuilderOptions options) 
    {
        return getQueriableFieldsForSObject(sObj, options.CheckObjectAccessibility, 
            options.StripNonAccessibleFields, options.StripNonUpdateableFields, 
            options.StripNonCreatableFields, options.StripSystemGeneratedFields);
    }
    
    /**
     * Get all fields that can be queried for a specific Object
     * 
     * @param  sObj                     SObjectType to retrieve fields for
     * @param  checkObjectAccessibility Check if SObject is accessible by current user
     * @param  stripNonAccessible       Ignore fields that are not accessible by current user
     * @param  stripNonUpdateable       Ignore fields that are not updateable by current user
     * @param  stripNonCreatable        Ignore fields that are not creatable by current user
     * @param  stripSystemGenerated     Ignore fields that are system generated (auto-numbers & formulas)
     * @return                          all fields that can be queried for the specified sObject
     */
    public static List<Schema.SObjectField> getQueriableFieldsForSObject(
        Schema.SObjectType sObj, Boolean checkObjectAccessibility, 
        Boolean stripNonAccessible, Boolean stripNonUpdateable,
        Boolean stripNonCreatable, Boolean stripSystemGenerated) 
    {
        List<Schema.SObjectField> retVal = new List<Schema.SObjectField>();

        if(checkObjectAccessibility == false || sObj.getDescribe().isAccessible()) {
            Map<String, Schema.SObjectField> fieldMap = sObj.getDescribe().fields.getMap();

            for(Schema.SObjectField f : fieldMap.values()) {
                DescribeFieldResult dfr = f.getDescribe();

                if(stripNonAccessible && dfr.isAccessible() == false) { continue; }
                if(stripNonUpdateable && dfr.isUpdateable() == false) { continue; }
                if(stripNonCreatable && dfr.isCreateable() == false) { continue; }
                if(stripSystemGenerated && (dfr.isAutoNumber() || dfr.isCalculated())) { continue; }

                retVal.add(f);       
            }
        }

        return retVal;
    }

     /**
     * Contains information which Security checks to perform when building a Query
     */
    public class QueryBuilderOptions {

        public Boolean CheckObjectAccessibility {get; set;}
        public Boolean StripNonAccessibleFields {get; set;}
        public Boolean StripNonUpdateableFields {get; set;}
        public Boolean StripNonCreatableFields {get; set;}
        public Boolean StripSystemGeneratedFields {get; set;}

        /**
         * Default constructor that ignores all checks by default
         */
        public QueryBuilderOptions(){
            this(false, false, false, false, false);
        }
        
        /**
         * @param  checkObjectAccessibility Check if SObject is accessible by current user
         * @param  stripNonAccessible       Ignore fields that are not accessible by current user
         * @param  stripNonUpdateable       Ignore fields that are not updateable by current user
         * @param  stripNonCreatable        Ignore fields that are not creatable by current user
         * @param  stripSystemGenerated     Ignore fields that are system generated (auto-numbers & formulas)
         */
        public QueryBuilderOptions(Boolean checkObjectAccessibility, Boolean stripNonAccessible, 
            Boolean stripNonUpdateable, Boolean stripNonCreatable, Boolean stripSystemGenerated){
            this.CheckObjectAccessibility = checkObjectAccessibility;
            this.StripNonAccessibleFields = stripNonAccessible;
            this.StripNonUpdateableFields = stripNonUpdateable;
            this.StripNonCreatableFields = stripNonCreatable;
            this.StripSystemGeneratedFields = stripSystemGenerated;
        }
    }
}