public without sharing class UTIL_Domain {

    /**
     * Get the domain from which Visualforce Pages are served
     */
    public static String getVisualforceDomain(){
        return getMyDomain() + '--c.' + getInstance() + '.visual.force.com';
    }

    /**
     * Get the domain from which Lightning Components are served
     */
    public static String getLightningDomain(){
        return getMyDomain() + '.lightning.force.com';
    }

    /**
     * Get org's "My Domain"
     */
    public static String getMyDomain(){
        return URL.getOrgDomainUrl().getHost().split('\\.')[0].toLowerCase();
    }
    
    /**
     * Get org's "Instance Name"
     */
    public static String getInstance(){
        if(String.isBlank(instance)){
            instance = [SELECT InstanceName FROM Organization LIMIT 1].InstanceName.toLowerCase();
        }
        return instance;
    }
    private static String instance = '';
}