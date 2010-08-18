package messenger;
import processing.core.*;
import java.io.*;
import java.util.*;
import java.lang.reflect.*;

/**
 * A class to communicate with the Arduino Messenger Library.
 * <br>
 * <p>
 * <a href="http://www.arduino.cc/playground/Code/Messenger">http://www.arduino.cc/playground/Code/Messenger</a>
*/

public class Messenger {

    private char[] buffer;  // Incomming message buffer
    private int index; // Buffer index
    private String separator; // Separator char
    private Method callback;
    private String[] elements;
    private int elementIndex;
    private PApplet parent;
    
    private int messageState;
    private boolean dumped;
    
    public Messenger( PApplet parent, char separator) {
        init(parent,separator);
    }
    
    public Messenger( PApplet parent) {
        init(parent,' ');
    }
    
    private void init(PApplet parent,char separator) {
    	if (separator == 0 || separator == 13 || separator == 10) separator = ' ';
    	char[] temp = new char[1];
    	temp[0] = separator;
        this.separator = new String(temp);
        buffer = new char[1024];
        
        reset();
        this.parent = parent;
        callback = null;
	}
    
    public boolean attach(String name) {
    	 try 
    	{
    		System.out.println("Looking for callback function: "+name+"()");
    		callback = parent.getClass().getMethod(name,null);
           
   		 } catch (Exception e) {
   		 	System.out.println("Could not find the callback function: "+name+"()");
      		callback = null;
    	}
    	if (callback != null) return true;
    	return false;
	}
    
    
    private void reset() {
        index = 0;
        messageState = 0;
        dumped = false;
        elementIndex = 0;
    }
    
    public int readInt() {

   		 if (next()) {
   		 	dumped = true;
   		 	int value = 0;
   		 	
   		 	try { value = Integer.parseInt(elements[elementIndex]); }
   		 	catch (Exception e) { value=0; }
    		return value;
    	 }
  		return 0;

	}

	public char readChar() {

  		if (next()) {
  			dumped = true;
  			return (elements[elementIndex]).charAt(0);
 		}
 	    return 0;
	}
	
	boolean next() {
        
  	 	if (messageState == 2) {
  	 		if (dumped) elementIndex++;
  	 		if (elementIndex < elements.length) {
  	 			dumped = false;
  	 			return true;
			} else {
				reset();
				return false;
			}
			
		} else if (messageState == 1) {
			messageState = 2;
			return true;
		}
  		return false;
	}
    
   public boolean available() {
    	
    	return next();
	}
    
   
    public boolean process(char data) {
     messageState = 0;
     if (data != 10) {
 	 if ( data != 13 ) {
        buffer[index] = data;
        index = index + 1;
        if (index >= buffer.length) index = 0;
     } else {
       String message = new String(buffer,0,index);
          index = 0;
         if (message != null) {
               reset();
              elements = (message).split(separator);
              if ( elements.length > 0 ) messageState = 1;
              //System.err.println(message);
         } else {
         	reset();
		}
		
        
     }
      }
      if (messageState > 0 ) {
      	if (callback != null) {
      		try {
          		callback.invoke(parent,null);
        	} catch (Exception e) {
      			System.err.println("There was an error with the callback function");
      			callback = null;
      			e.printStackTrace();
			}
		}
      	if (messageState > 0 ) return true; 
	}
      return false;
 }
}


