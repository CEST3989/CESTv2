package com.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;


/**
 * Implementation of <strong>ActionSupport</strong> that contains 
 * convenience methods for subclasses.  For example, getting the current
 * user and saving messages/errors. This class is intended to
 * be a base class for all Action classes.
 * 
 * @author MSC
 */
public class BaseAction extends ActionSupport {
    private static final long serialVersionUID = 3525445612504421307L;

    /**
     * Constant for cancel result String
     */
    public static final String CANCEL = "cancel";

    /**
     * Constant for list result String
     */
    public static final String LIST = "list";

    /**
     * Constant for view result String
     */
    public static final String VIEW = "view";
    
    /**
     * Transient log to prevent session synchronization issues - children can use instance for logging.
     */
    protected transient final Log log = LogFactory.getLog(getClass());
    
    /**
     * Indicator if the user clicked cancel
     */
    protected String cancel;

    /**
     * Indicator if the user clicked list
     */
    protected String list;

    /**
     * Indicator if the user clicked view
     */
    protected String view;

    
    /**
     * Indicator for the page the user came from.
     */
    protected String from;

    /**
     * Set to "delete" when a "delete" request parameter is passed in
     */
    protected String delete;

    /**
     * Set to "save" when a "save" request parameter is passed in
     */
    protected String save;


    /**
     * Velocity template to use for e-mailing
     */
    protected String templateName;

    /**
     * Simple method that returns "cancel" result
     * @return "cancel"
     */
    public String cancel() {
        return CANCEL;
    }

    /**
     * Simple method that returns "list" result
     * @return "list"
     */
    public String list() {
        return LIST;
    }
    
    /**
     * Simple method that returns "view" result
     * @return "list"
     */
    public String view() {
        return VIEW;
    }
    
    /**
     * Save the message in the session, appending if messages already exist
     * @param msg the message to put in the session
     */
    @SuppressWarnings("unchecked")
    protected void saveMessage(String msg) {
        List messages = (List) getRequest().getSession().getAttribute("messages");
        if (messages == null) {
            messages = new ArrayList();
        }
        messages.add(msg);
        getRequest().getSession().setAttribute("messages", messages);
    }

    /**
     * Convenience method to get the Configuration HashMap
     * from the servlet context.
     *
     * @return the user's populated form from the session
     */
  
    /**
     * Convenience method to get the request
     * @return current request
     */
    protected HttpServletRequest getRequest() {
        return ServletActionContext.getRequest();
    }

    /**
     * Convenience method to get the response
     * @return current response
     */
    protected HttpServletResponse getResponse() {
        return ServletActionContext.getResponse();
    }

    /**
     * Convenience method to get the session. This will create a session if one doesn't exist.
     * @return the session from the request (request.getSession()).
     */
    protected HttpSession getSession() {
        return getRequest().getSession();
    }

   


    /**
     * Convenience method for setting a "from" parameter to indicate the previous page.
     * @param from indicator for the originating page
     */
    public void setFrom(String from) {
        this.from = from;
    }

    public void setDelete(String delete) {
        this.delete = delete;
    }

    public void setSave(String save) {
        this.save = save;
    }
}
