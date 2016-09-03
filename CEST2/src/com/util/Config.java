package com.util;


import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;

/**
 * The class to get configuration data.
 */

public class Config{

	private static String APP_CONFIG_FILE = "AppConfig.properties";
	private static Log log = LogFactory.getLog(Config.class);
	private static Config configInstance;

	private static PropertiesConfiguration props = null;
	public static String resourcesDirectoryPath = null;
	public static String contextDirPath = null;
	
	//Used to set config for getBean() method
	public static String appContextFileName = "applicationContext-resources.xml";
	
	public static WebApplicationContext webApplicationContext = null;
	
	
    /**
     * Creates an empty configuration.
     */
    private Config() {
    	try{
    		props = new PropertiesConfiguration();
    		//Do not parse comma as a token list
    		props.setDelimiterParsingDisabled(true);
    		props.load(APP_CONFIG_FILE);
    		resourcesDirectoryPath = props.getFile().getParent();
    		
    		if(resourcesDirectoryPath.indexOf("/WEB-INF/") > 0){
    			contextDirPath = resourcesDirectoryPath.substring(0, resourcesDirectoryPath.indexOf("/WEB-INF/"));
    		}else if(resourcesDirectoryPath.indexOf("\\WEB-INF\\") > 0){
    			contextDirPath = resourcesDirectoryPath.substring(0, resourcesDirectoryPath.indexOf("\\WEB-INF\\"));
    		}
    		log.info("Successfully intialized Config using file : " + APP_CONFIG_FILE);
    	}catch(ConfigurationException e){
    		log.fatal("######################################");
    		log.fatal("ERROR: Unable to load properties from file : " + APP_CONFIG_FILE);
    		log.error(e);
    	}
    }

    /**
     * Creates a configuration repository encapsulating the given
     * properties.
     *
     * @param repository The Repository class which contains actual
     * configuration data.
     */
    public static Config getConfig() {
        if (configInstance == null) {
        	synchronized(Config.class) {
        		if (configInstance == null){
        			configInstance = new Config();
        		}
        	}
        }
        return configInstance;
    }


    public static String getResourcesDirectoryPath() {
    	return resourcesDirectoryPath;
    }
    
    public static String getContextDirectoryPath() {
    	return contextDirPath;
    }
    
    public static String getString(String key){
    	return props.getString(key);

    }

    public static int getInt(String key){
    	return props.getInt(key);
    }

    public static long getLong(String key){
    	return props.getLong(key);
    }

    public static float getFloat(String key){
    	return props.getFloat(key);
    }

    public static boolean getBoolean(String key){
    	return props.getBoolean(key);
    }

	public static void setWebApplicationContext(
			WebApplicationContext webApplicationContext) {
		Config.webApplicationContext = webApplicationContext;
	}
	
	//Set the appContextFileName, the file should be in classpath
	public static void setAppContextFileName(
			String appContextFileName) {
		Config.appContextFileName = appContextFileName;
	}
	
	
	//Use this method to get the bean object for the passed bean name defined in applicationContext.xml
	public static Object getBean(String beanName){
		if(webApplicationContext != null ){
			return webApplicationContext.getBean(beanName);
		}else{
			ApplicationContext context = new ClassPathXmlApplicationContext(appContextFileName);
			if(context != null){
				return context.getBean(beanName);
			}
			log.warn("No bean found for the passed beanName = "+beanName);
		}
		return null;
	}
}
