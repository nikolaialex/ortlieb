<%-- 
    Document   : index
    Created on : 08.10.2014, 19:22:53
    Author     : Uschi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Autovermietung</title>
    </head>
    <body>
        <a rel="allCars" href="folder2">alle Autos</a>
        <a rel="makeOrderView" href="makeOrder">Bestellen</a>
        <a rel="availableCars" href="http://www.autovermietung.de/cars/?status=available"></a>
    
        <form data-rel="searchCar" method="GET" action="cars">
            <input type="text" name="car"/>
            <input type="submit" value="Suchen"/>
        </form>
         
        <a rel="accteptedOffers" href="http://www.autovermietung.de/offers/?status=accepted">alle Ausleihen ansehen</a>
        <a rel="allOrders" href="orders">alle Bestellungen</a>
        
        <form data-rel="searchOrder" method="GET" action="orders">
            <input type="text" name="customer"/>
            <input type="submit" value="anzeigen"/>
        </form>
    </body>
</html>