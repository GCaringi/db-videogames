-- Query su Singola Tabella
-- 1- Selezionare tutti i passeggeri (1000)
SELECT *
FROM passengers
-- 2- Selezionare tutti i nomi degli aeroporti, ordinati per nome (100)
SELECT *
from airports
ORDER BY airports.name ASC
-- 3- Selezionare tutti i passeggeri che hanno come cognome 'Bartell' (2)
SELECT *
FROM passengers
WHERE passengers.lastname = 'Bartell'
-- 4- Selezionare tutti i passeggeri minorenni (considerando solo l'anno di nascita) (115 - nel 2022)
SELECT *
FROM passengers
WHERE (YEAR(GETDATE()) - YEAR(passengers.date_of_birth)) < 18;
-- 5- Selezionare tutti gli aerei che hanno piu' di 200 posti (84)
SELECT *
FROM airplanes
WHERE airplanes.seating_capacity > 200
-- 6- Selezionare tutti gli aerei che hanno un numero di posti compreso tra 350 e 700 (30)
SELECT *
FROM airplanes
WHERE airplanes.seating_capacity BETWEEN 350 AND 700
-- 7- Selezionare tutti gli ID dei dipendenti che hanno lasciato almeno una compagnia aerea (31077)
SELECT airline_employee.id
FROM airline_employee
WHERE airline_employee.layoff_date IS NOT NULL
-- 8- Selezionare tutti gli ID dei dipendenti che hanno lasciato almeno una compagnia aerea prima del 2006 (493)
SELECT airline_employee.id
FROM airline_employee
WHERE YEAR(airline_employee.layoff_date) < 2006
-- 9- Selezionare tutti i passeggeri il cui nome inizia con 'Al' (26)
SELECT *
FROM passengers
WHERE passengers.name LIKE 'Al%'
-- 10- Selezionare tutti i passeggeri nati nel 1960 (11)
SELECT *
FROM passengers
WHERE YEAR(passengers.date_of_birth) = 1960;

-- *********** BONUS ***********

-- 11- contare tutti gli aeroporti la cui città inizia per 'East' (7)
SELECT *
FROM airports
WHERE airports.city LIKE 'East%';
-- 12- Contare quanti voli sono partiti il 4 luglio 2019 (3)
SELECT COUNT(*) AS "Flights"
FROM flights
WHERE CAST(flights.departure_datetime AS DATE) = '2019-07-04'

-- Query con GROUP BY
-- 1- Contare quanti lavori di manutenzione ha eseguito ogni impiegato (dell'impiegato vogliamo solo l'ID) (1136)
SELECT employee_maintenance_work.employee_id AS "Employee", COUNT(*) AS "Number of Works"
FROM employee_maintenance_work
GROUP BY employee_maintenance_work.employee_id
-- 2- Contare quante volte ogni impiegato ha lasciato una compagnia aerea (non mostrare quelli che non hanno mai lasciato; dell'impiegato vogliamo solo l'ID) (8939)
SELECT airline_employee.employee_id AS "Employee", Count(*) AS "Num of Layoffs"
FROM airline_employee
WHERE airline_employee.layoff_date IS NOT NULL
GROUP BY airline_employee.employee_id
-- 3- Contare per ogni volo il numero di passeggeri (del volo vogliamo solo l'ID) (1000)
SELECT flight_passenger.flight_id, COUNT(*)
FROM flight_passenger
GROUP BY flight_passenger.flight_id
-- 4- Ordinare gli aerei per numero di manutenzioni ricevute (da quello che ne ha di piu'; dell'aereo vogliamo solo l'ID) (100)
SELECT maintenance_works.airplane_id
FROM maintenance_works
GROUP BY maintenance_works.airplane_id
ORDER BY COUNT(maintenance_works.airplane_id) DESC
-- 5- Contare quanti passeggeri sono nati nello stesso anno (61)
SELECT YEAR(passengers.date_of_birth),COUNT(*)
FROM passengers
GROUP BY YEAR(passengers.date_of_birth)
ORDER BY YEAR(passengers.date_of_birth) ASC
-- 6- Contare quanti voli ci sono stati ogni anno (tenendo conto della data di partenza) (11)
SELECT YEAR(flights.departure_datetime), COUNT(*)
FROM flights
GROUP BY YEAR(flights.departure_datetime)

-- *********** BONUS ***********

-- 7- Per ogni manufacturer, trovare l'aereo con maggior numero di posti a sedere (8)
SELECT airplanes.manufacturer, MAX(airplanes.seating_capacity)
FROM airplanes
GROUP BY airplanes.manufacturer
-- 8- Contare quante manutenzioni ha ricevuto ciascun aereo nel 2021 (dell'aereo vogliamo solo l'ID) (36)
SELECT maintenance_works.airplane_id, COUNT(*)
FROM maintenance_works
WHERE YEAR(maintenance_works.datetime) = 2021
GROUP BY maintenance_works.airplane_id
-- 9- Selezionare gli impiegati che non hanno mai cambiato compagnia aerea per cui lavorano (1061)
SELECT airline_employee.employee_id
FROM airline_employee
GROUP BY airline_employee.employee_id
HAVING COUNT(airline_employee.employee_id) = 1;

-- Query con JOIN
-- 1- Selezionare tutti i passeggeri del volo 70021493-2 (85)
SELECT passengers.*
FROM passengers
JOIN flight_passenger ON passengers.id = flight_passenger.passenger_id
JOIN flights ON flight_passenger.flight_id = flights.id
WHERE flights.number = '70021493-2'
-- 2- Selezionare i voli presi da 'Shirley Stokes' (61)
SELECT flights.*
FROM flights
JOIN flight_passenger ON flights.id = flight_passenger.flight_id
JOIN passengers ON flight_passenger.passenger_id = passengers.id
WHERE passengers.name = 'Shirley' AND passengers.lastname = 'Stokes'
-- 3- Selezionare tutti i passeggeri che hanno usato come documento 'Passport'(775)
SELECT DISTINCT passengers.*
FROM passengers
JOIN document_type_passenger ON passengers.id = document_type_passenger.passenger_id
JOIN document_types ON document_type_passenger.document_type_id = document_types.id
WHERE document_types.name = 'Passport'
-- 4- Selezionare tutti i voli con i relativi passeggeri (65296)
SELECT passengers.name AS "Passengers", flights.id AS "Flight"
FROM passengers
JOIN flight_passenger ON passengers.id = flight_passenger.passenger_id
JOIN flights ON flight_passenger.flight_id = flights.id
ORDER BY flights.id ASC
-- 5- Selezionare tutti i voli che partono da 'Charleneland' e arrivano a 'Mauricestad' (3)
SELECT flights.*
FROM flights
JOIN airports dep ON flights.departure_airport_id = dep.id
JOIN airports arr ON flights.arrival_airport_id = arr.id
WHERE dep.city = 'Charleneland'AND arr.city = 'Mauricestad'
-- 6- Selezionare tutti gli id dei voli che hanno almeno un passeggero il cui cognome inizia con 'L' (966) => (935)
SELECT DISTINCT flights.id
FROM flights
JOIN flight_passenger ON flights.id = flight_passenger.flight_id
JOIN passengers ON flight_passenger.passenger_id = passengers.idS
WHERE passengers.lastname LIKE 'L%'
-- 7- Selezionare i dati delle compagnie dove almeno un impiegato si è stato licenziato (286)
SELECT DISTINCT airlines.*
FROM employees
JOIN airline_employee ON employees.id = airline_employee.employee_id
JOIN airlines ON airline_employee.airline_id = airlines.id
WHERE airline_employee.layoff_date IS NULL
-- 8- Selezionare tutti gli aerei che sono partiti almeno una volta dalla città di 'Domingochester' (12) => (14)
SELECT DISTINCT flights.*
FROM flights
JOIN airports ON flights.arrival_airport_id = airports.id
WHERE airports.city = 'Domingochester'
-- 9- Selezionare i dati dei tecnici e gli aerei ai quali questi hanno fatto almeno un intervento di manutenzione (1506)
SELECT employees.*
FROM employees
JOIN employee_maintenance_work ON employees.id = employee_maintenance_work.employee_id
-- 10- Selezionare tutti i piloti che hanno viaggiato nel 2021 verso l'aeroporto di 'Abshireland' (5) => SBAGLIATA LA RICHIESTA
SELECT employees.*, flights.*
FROM employees
JOIN roles on employees.role_id = roles.id
JOIN employee_flight ON employees.id = employee_flight.employee_id
JOIN flights ON employee_flight.flight_id = flights.id
JOIN airports ON flights.arrival_airport_id = airports.id
WHERE airports.city = 'Abshireland' AND YEAR(flights.departure_datetime) = 2021

-- *********** BONUS ***********

-- 11- Selezionare i dati di tutti i passeggeri che hanno volato su un qualche aereo riparato da 'Aaliyah Leannon' (590)

-- 12- Contare quanti piloti ha la compagnia 'Maldivian (Q2)' (10)

-- 13- Contare quanti dipendenti ha ogni compagnia aerea (286)