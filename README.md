###  Ticket Service : A neat application to find and reserve hard to get tickets

###  Technical Components
     Backend   : Spring Boot
     Database  : H2 (using file based option to persist data between app re-runs)
     DAO       : Spring JDBCTemplate
     Testing   : JUnit, Mockito, Hamcrest
     Migration : Flyway
     NOTE : pom.xml has dependencies for all required technical components and are downloaded during "package" step.

### Rest API(s)
     /seats    : returns number of available seats. 
                 
                 Example : curl localhost:5000/seats
                 
     /hold     : holds a given number of seats(numSeats) for a particular customer (customerEmail). 
                 Returns object containing unique SeatHoldId and seats on hold.
                 Customer has 15 mins to reserve the seats once they are held. 
                 After 15 mins, these seats are returned to available status.
                 
                 Example : curl -X PUT -d numSeats=2 -d customerEmail="@gmail.com" http://localhost:5000/hold

     /reserve  : reserves seats for seatHoldId and customerEmail
          
                 Example : curl -X PUT -d seatHoldId=10 -d customerEmail="nyy@gmail.com" http://localhost:5000/reserve

###  How to start the application
     From command prompt run the following commands
     1. git clone https://github.com/dghadge/ticketservice.git
     2. mvn package 
     3. mvn spring-boot:run  (this command will start the application)
     4. Alternate to setp-3 above; you can run bash script "service.sh" 
        which will start both app and web on ports 5000 and 5001 resp.
     
     NOTE : if jnuit fails after multiple re-runs, its because there are no more avaibale seats. 
     Running the following command will recreate new seats in the DB. 
    
     flyway -url=jdbc:h2:file:~/tickets clean    (username=sa, password is blank)
     
     Next time you run the application you will not encounter junit failures. 
     
###  How to use Rest API(s) 
     From command prompt run the following commands
     1. /seats   : curl localhost:5000/seats
     2. /hold    : curl -X PUT -d numSeats=2    -d customerEmail="sbc@gmail.com" http://localhost:5000/hold
     3. /reserve : curl -X PUT -d seatHoldId=10 -d customerEmail="sbc@gmail.com" http://localhost:5000/reserve
     
###  Documentation for Actuator endpoints 
     http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#production-ready-endpoints/

###  Docker related commands(optional)
     $~ docker build -t dghadge/ticketservice . ###  Note "." at the end
     $~ docker run -p 5000:5000 -ti ticketingservice
