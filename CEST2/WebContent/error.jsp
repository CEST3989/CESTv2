<%@ page isErrorPage="true" %>  
  
<h3>Sorry an exception occured!</h3>  
  
Exception is: <%= exception %>  



<jsp:scriptlet>
  exception.printStackTrace(new java.io.PrintWriter(out));
</jsp:scriptlet>