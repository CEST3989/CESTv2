package com.util;

import org.apache.log4j.Level;
import org.apache.log4j.xml.DOMConfigurator;

public class Log {

    private static boolean isConfigured = false;
    public static String UDR_CATEGORY = "UDR";
    public static String ADDSUBREQUEST_CATEGORY = "ADDSUBREQUEST";
    public static String TACNOTFOUND_CATEGORY = "TACNOTFOUND";
    public static String SELFCAREREQUEST_CATEGORY = "SELFCAREREQUEST";
    public static String SELFCAREREQUEST_INFO_CATEGORY = "SELFCAREREQUESTINFO";
    public static String SELFCARE_DOWNLOAD_INFO = "SELFCAREDOWNLOADINFO";
    private static String ROOT_CATEGORY = "ROOT";
    private String category;
    
	protected Log(String category){
		this.category  = category;
    }

    public static Log getInstance(Class c) {
        return getInstance(c.getName());
    }

    public static Log getInstance(String category){
    	return new Log(category);
    }
 
    public static void setConfig(String configFileName) {
        try {
            DOMConfigurator.configure(configFileName);   
            isConfigured = true;
        } catch (Exception ex) {
            System.err.println("ERROR: Can't load logging configuration from " +
                                configFileName);
            ex.printStackTrace();
        }
    }
    
    public static boolean isConfigured() {
        return isConfigured;
    }


    /**
     * Will messages logged at the TRACE level currently be written?
     */
    public boolean isTraceLevelEffective() {
        return isLevelEffective(category, Level.TRACE);
    }

    /**
     * Will messages logged at the DEBUG level currently be written?
     */
    public boolean isDebugLevelEffective() {
        return isLevelEffective(category, Level.DEBUG);
    }

    /**
     * Will messages logged at the INFO level currently be written?
     */
    public boolean isInfoLevelEffective() {
        return isLevelEffective(category, Level.INFO);
    }

    /**
     * Will messages logged at the WARN level currently be written?
     */
    public boolean isWarnLevelEffective() {
        return isLevelEffective(category, Level.WARN);
    }

    /**
     * Will messages logged at the ERROR level currently be written?
     */
    public boolean isErrorLevelEffective() {
        return isLevelEffective(category, Level.ERROR);
    }

    /**
     * Will messages logged at the FATAL level currently be written?
     */
    public boolean isFatalLevelEffective() {
        return isLevelEffective(category, Level.FATAL);
    }

    /**
     * Test whether messages logged with the given group and level will get
     * logged.
     * @param group The log group.
     * @param level The level to test.
     * @return true if messages with this group and level will get logged.
     */
    public boolean isLevelEffective(String category, Level level) {
        return level.isGreaterOrEqual(getLogger(category).getEffectiveLevel());
    }

    public void fatal(String msg) {
    	fatal(msg, null);
	}
    
    public void fatal(String msg, Throwable t) {
		log(Level.FATAL, msg, t);
	}

   
    public void error(String msg) {
		log(Level.ERROR, msg, null);
	}
    
    public void error(String msg, Throwable t) {
		log(Level.ERROR, msg, t);
	}
    public void warn(String msg) {
		log(Level.WARN, msg, null);
	}
    
    public void warn(String msg, Throwable t) {
		log(Level.WARN, msg, t);
	}

    public void info(String msg) {
        info(msg, null);
    }

    public void info(String msg, Throwable t) {
    	log(Level.INFO, msg, t);
    }
    
    public void debug(String message) {
        debug(message, null);
    }

    public void debug(String message, Throwable t) {
            log(Level.DEBUG, message, t);
    }
    
    public void trace(String message) {
    	trace(message, null);
    }

    public void trace(String message, Throwable t) {
    	log(Level.TRACE, message, t);
    }
    
    public void traceLog(String message) {
    	traceLog(message, null);
    }
    public void traceLog(String message, Throwable t) {
    	log(Level.OFF, message, t);
    }


    /**
     * All method calls to log a message end up here.  This determines
     * whether and how to log the event.
     */
    public void log(Level level, String message, Throwable t) {
		org.apache.log4j.Logger logger = getLogger(this.category);
		Level  eff    = logger.getEffectiveLevel();

		if (level.isGreaterOrEqual(eff)) {
			if (!isConfigured()) {
				// Logger was called before it's configured 
				System.err.println("Logger was called before it's configured");
				if (t != null)
					t.printStackTrace(System.err);
			} else {
				logger.log(level, message, t);
			}
		}
    }
    
    //Currently Not used, but can be used to change the log level on the fly 
    public static void setLevel(String category, String logLevel) {
        Level level = Level.toLevel(logLevel, null);
        //Set the level for this logger 
        org.apache.log4j.Logger logger = getLogger(category);
        logger.setLevel(level);
    }
    
    private static org.apache.log4j.Logger getLogger(String category) {
        org.apache.log4j.Logger logger;
        if(category == null || category.equalsIgnoreCase(ROOT_CATEGORY)){
            logger = org.apache.log4j.Logger.getRootLogger();
        }else{
            logger = org.apache.log4j.Logger.getLogger(category);
        }
        return logger;
    }
}
