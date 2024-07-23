use airlines;
-- kpi1
with t as(select date(concat(year,"-",month,"-",day,"-")) dates from maindata) 
select *,year(dates) years,month(dates) months,date_format(dates,"%M") monthname,quarter(dates) 'quarter',date_format(dates,"%Y-%m") 'yyyy-mm',weekday(dates)+1 weekdayno,dayname(dates) days,((YEAR(dates) - YEAR(DATE_ADD(dates, INTERVAL -4 MONTH))) * 12 + MONTH(dates) + 8) % 12 + 1 fm,(QUARTER(DATE_ADD(dates, INTERVAL 3 MONTH)) + 3 -2) % 4 + 1 AS fiscal_quarter from t;

--- kpi2
select year,month,quarter(date(concat(year,"-",month,"-",day))) quarters,concat(round(sum(transported_passengers)/sum(available_seats)*100,2),"%") load_factor from maindata group by 1,2,3 order by 1,2,3;

--- kpi3
select carrier_name,concat(round(sum(transported_passengers)/sum(available_seats)*100,2),"%") load_factor from maindata group by 1 order by 2 desc;


-- kpi4
select carrier_name,concat(round(sum(transported_passengers)/1000000,2),"M") passengers from maindata group by 1 order by 2 desc limit 10;

--- kpi5
select `From - To City`,count(airline_id) no_of_flights from maindata group by 1 order by 2 desc limit 10;


--- kpi6
with t as(with t as(with t as(select date(concat(year,"-",month,"-",day,"-")) dates,Available_Seats,Transported_Passengers from maindata) select *,weekday(dates)+1 weekdayno from t)select available_seats,transported_passengers,case when weekdayno=6 || weekdayno=7 then "weekend" else "weekday" end as weekclass from t) select weekclass,round(sum(transported_passengers)/sum(available_seats)*100,2) load_factor from t group by 1;


--- kpi7

select distance_group_id,count(airline_id) no_of_flights from maindata group by 1 order by 1 asc;







