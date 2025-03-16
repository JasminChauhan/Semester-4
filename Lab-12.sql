1. Display distinct city.
db.students.distinct("CITY")
2. Display city wise count of number of students.
db.students.aggregate([{$group : {_id : "$CITY" , count : {$sum : 1}}}])
3. Display sum of fees in your collection.
db.students.aggregate([{$group : {_id : null , TotalFees : {$sum : "$FEES"}}}])
4. Display average of fees in your document.
db.students.aggregate([{$group : {_id : null , AverageFees : {$avg : "$FEES"}}}])
5. Display maximum and minimum fees of your document.
db.students.aggregate([{$group : {_id : null , MinimumFees : {$min : "$FEES"} , MaximumFees : {$max : "$FEES"}}}])
6. Display city wise total fees in your collection.
db.students.aggregate([{$group : {_id : "$CITY" , TotalFees : {$sum : "$FEES"}}}])
7. Display gender wise maximum fees in your collection.
db.students.aggregate([{$group : {_id : "$GENDER" , MaximumFees : {$max : "$FEES"}}}])
8. Display city wise maximum and minimum fees.
db.students.aggregate([{$group : {_id : "$CITY" , MaximumFees : {$max : "$FEES"} , MinimumFees : {$min : "$FEES"}}}])
9. Display count of persons lives in Baroda city in your collection.
db.students.aggregate([{$match : {CITY : "Baroda"}},{$group : {_id : null , PersonCount : {$sum : 1}}}])
10. Display average fees of Rajkot city.
db.students.aggregate([{$match : {CITY : "Rajkot"}},{$group : {_id : null , AverageFees : {$avg : "$FEES"}}}])
11. Count the number of male and female students in each Department.
db.students.aggregate([{$group : {_id : {Department : "$DEPARTMENT" , Gender : "$GENDER"} , PersonCount  : {$sum : 1}}}])
12. Find the total Fees collected from each Department.
db.students.aggregate([{$group : {_id : {Department : "$DEPARTMENT"} , TotalFees  : {$sum : "$FEES"}}}])
13. Find the minimum Fees paid by male and female students in each City.
db.students.aggregate([{$group : {_id : {Department : "$DEPARTMENT" , Gender : "$GENDER"} , MinimumFees  : {$min : "$FEES"}}}])
14. Sort students by Fees in descending order and return the top 5.
db.students.aggregate([{$group : {_id : null , TotalFees  : {$sum : "$FEES"}}} , {$sort : {TotalFees : -1}} , {$limit : 5}])
15. Group students by City and calculate the average Fees for each city, only including cities with more than 1 student.
db.students.aggregate([{$group : {_id : {City : "$CITY"} , TotalCount  : {$sum : 1} , AverageFees : {$avg : "$FEES"}}} , {$match : {TotalCount : {$gt : 1}}}])
16. Filter students from CE or Mechanical department, then calculate the total Fees.
db.students.aggregate([
{$match : {DEPARTMENT:{$in : ["CE" , "Mechanical"]}}},
 {$group : {_id : {Department : "$DEPARTMENT" } , count  : {$sum : 1}}}
])
17. Count the number of male and female students in each Department.

18. Filter students from Rajkot, then group by Department and find the average Fees for each department.
19. Group by Sem and calculate both the total and average Fees, then sort by total fees in descending order.

20. Find the top 3 cities with the highest total Fees collected by summing up all students' fees in those cities.
