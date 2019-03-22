public without sharing class UTIL_String {

    /**
     * Use this token to identify a Fake Id.
     */
    public static final String FAKE_ID_TOKEN = '000FTF';
    public static final Integer FAKE_ID_TOKEN_LENGTH = 6;

    /**
     * Number of generated IDs. Kept for uniqueness
     */
    static Integer id_num = 1;

    /**
     * Charset for randomly generated Strings
     */
    static Integer[] charset;
    static {
        charset = new Integer[0];
        for(Integer i = 48; i < 58; i++) charset.add(i);
        for(Integer i = 65; i < 91; i++) charset.add(i);
        for(Integer i = 97; i < 123; i++) charset.add(i);
    }


    /**
     * Generates a random string with specified length
     *
     * @param  len length of the generated string
     * @return     return randomly generated string
     */
    public static String generateRandomString(Integer len) {
        Integer[] chars = new Integer[len];
        Integer key, size = charset.size();

        for(Integer idx = 0; idx < len; idx++) {
            chars[idx] = charset[Math.mod(Math.abs(Crypto.getRandomInteger()), size)];
        }

        return String.fromCharArray(chars);
    }


    /**
     * Get fake Id for provided sObject
     *
     * @param  sot SObjectType to generate fake Id for
     * @return     return randomly generated Id
     */
    public static String getFakeId(Schema.SObjectType sot)
    {
        String result = String.valueOf(id_num++);
        return sot.getDescribe().getKeyPrefix() + FAKE_ID_TOKEN +
            '0'.repeat(12 - FAKE_ID_TOKEN_LENGTH - result.length()) + result;
    }

    /**
     * Test if provided ID is fake
     * 
     * @param  idToTest ID to test
     * @return          return TRUE - is fake, FALSE - it's not fake
     */
    public static Boolean isFakeId(String idToTest){
        return idToTest.mid(3, FAKE_ID_TOKEN_LENGTH).startsWith(FAKE_ID_TOKEN);
    }

    /**
     * Converts a single raw <code>Object</code> value into the corresponding <code>String</code> value.
     *
     * @param rawObject the raw value
     *
     * @return the corresponding string value
     */
    public static String toString(Object rawObject) {
        if (rawObject == null) { 
            throw new UTIL_Exceptions.IllegalArgumentException('Provided value is null.');
        } else if (rawObject instanceof String) {
            return (String) rawObject;
        } else {
            return String.valueOf(rawObject);
        }
    }
}