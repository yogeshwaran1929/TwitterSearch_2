# TwitterSearch_2

   iOS application that allows the user to search twitter using keywords and geo location.

   When running in the simulator, Core Location assigns a fixed set of coordinate values to this property. You must    run your application on an iPhone OS–based device to get real location values(only in 3G).

<h1>prerequisites</h1>

   * MAC with OSx mavericks or later.
   * Xcode version 5.0 or later.
   * Twitter Account.

<h1>Compile and Run:</h1>

   * Open the file with extension .xcodeproj
   * The project will be opened in Xcode.
   * Press Cmd+B to compile the project.
   * Press Cmd+R to run the project.
   
<h1>Features</h1>
   
   * Social Integration.
   * Core Location.
   * Calling REST API.

   By authenticated :
    
    it loads user profile icons , Name and ScreenName(async, cached)
    
    it shows results in ScrollView (Using GCD method load images async mode)
   
  This project comes without .XIB file and the Controller object to support that already set up.  It is assumed that   the reader is familiar with those parts of Cocoa programming so the mechanics of putting those parts together are    not discussed in this readme.


 Add a Scripting Bridge build rule to the project.

  The first thing to do is to set up Xcode to automatically generate the Scripting Bridge source for the application   you would like to target.  
  
  
  


 
  
  


  

  
