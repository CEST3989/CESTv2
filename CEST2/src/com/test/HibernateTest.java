package com.test;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;

import com.model.UserInfo;


public class HibernateTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		try{
		    Configuration cfg = new AnnotationConfiguration();  
		    cfg.configure("hibernate.cfg.xml");  
		      
		    //creating seession factory object  
		    SessionFactory factory=cfg.buildSessionFactory(); 
		      
		    //creating session object  
		    Session session=factory.openSession();  
		      
		    //creating transaction object  
		    Transaction t=session.beginTransaction();  
		    
		    Query query = session.createQuery("from com.model.UserInfo where id=2");
		    
		    List<UserInfo> list = query.list();
		      
		    t.commit();//transaction is commited  
		    session.close();  
		      
		    System.out.println("successfully saved");  
		      
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
