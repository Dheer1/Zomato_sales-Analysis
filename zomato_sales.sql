create database  zomato_sales_analysis;
use zomato_sales_analysis;
show tables;
select * from main;
select * from country;
select * from currency;



# Find the Numbers of Resturants based on City and Country
select city ,count(RestaurantID) from main
group by city;
select countryname, count(RestaurantID) from main m
left join  country c on m.countrycode = c.countryid
group by countryname;

#----------2. Number of Restaurants based on year,month,quarter-----#


#--TOtal Restarant open Yearwise--

select distinct year(year)as year,count(*)
from main
group by year(year);

#---Total Restaurant open monthwise

Select distinct monthname(year) as month_name, count(*)
from main
group by monthname(year);



#---Total Restaurant open quarterwise
select quarter ,count(*) as RestaurantCount
from main
group by quarter
order by quarter;

# 3---- Percentage of Resturants based on "Has_Table_booking------
select Has_Table_booking,
count(*) as totalrestaurants,
Round((count(*) / (select count(*) from main )) * 100,2) as percentage
from main
group by  Has_Table_booking;

#4--------.Percentage of Resturants based on "Has_Online_delivery"
 
 select
 Has_Online_delivery,
 count(*) as Totalrestaurants,
 round((count(*) / (select count(*) from main )) *100,2) as percentage
 from main
 group by 
 Has_Online_delivery;
 
 # 5------Count of Resturants based on Average Ratings--

select rating as Individualrating,
count(*) as Restaurantcount
from
main
where rating is not null
group by 
Rating 
order by Rating asc;


#6--- find total cuisines--
select cuisines, count(cuisines) from main
group by cuisines;


# 7-------Find buckets based on Average Price of reasonable size and find out how many resturants---
select cost_range,
count(*) as TotalRestaurants
from ( select
case 
when Average_cost_for_two between 0 and 300 then '0 - 300'
when Average_cost_for_two between 301 and 600 then '301 - 600'
when Average_cost_for_two between 601 and 1000 then '601 - 1000'
when Average_cost_for_two between 10001 and 430000 then '10001 - 430000'
else 'other'
end as cost_range 
from main 
) as subquerry 
group by  cost_range;

