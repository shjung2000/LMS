# LJPS app


1. Run your WAMP/MAMP environment

2. Load the SQL Script
-> Run “Is212g8t6 - script - Version 6.sql” script in mySQL workbench or in phpMyAdmin

3. Run Back-End Springboot on VSCode:
   - Download the following extension packs:
     1. Project Manager for Java
     2. Maven for Java
     3. Extension Pack for Java
     4. Debugger for Java
     5. XML
     6. Spring Boot Extension Pack
   - Also Make sure your Java is at least version 18
     - Download from here if you haven’t -> openJDK 18 https://jdk.java.net/18/

   - Open the project folder is212-g8-t6

   - Next, click on the SpringBoot icon
   
   - Then click “run” button to run the SpringBoot/Backend

9. Run Back-End SpringBoot on Intellij
   - Download Intellij from https://www.jetbrains.com/idea/download/#section=windows
   - Open the project folder is212-g8-t6 in Intellij 
   - Click on the “run” button to run the backend. Make sure you are running G8T6Applicaton

10. Run Front-End Vue Js on VScode

    - Download the following extension pack if you haven’t:
      1. Vue Language Features (Volar)
      2. Vetur
    - Run the following commands in your terminal / command-prompt / power-shell
    ```
    Windows
    .\mvnw.cmd spring-boot:run
    
    Mac
    ./mvnw spring-boot:run

    ```

11. Navigate to the following directory:
<Your Root>\is212-g8-t6\frontend\vue-app

    Enter the following command to run the frontend app:
    ```
    npm run serve
    ```

### IMPORTANT TO TAKE NOTE
Please run the backend first before running the frontend. Both backend and frontend run in port 8080 by default but frontend application auto changes its port number when port 8080 is already in use while backend is not. Running frontend application first will stop backend application from running successfully due to conflict in port usage

Link to our BitBucket: https://bitbucket.org/is212-g8-t6/is212-g8-t6/src/main/


### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
