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