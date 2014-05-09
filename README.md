CIS Check Backend
=========

This Repo provides the Backend for the CIS Check website. The scripts here will kind of provide a API for the CIS, since there is none as of right now. This document shall specify the functions anda database structure needed.

##Script Concept##

###login_check(user, password)###
login_check should check the validity of the parameter-data. Therefor the script should login into the CIS and return a true if the login was successful. If the data was wrong, it should return a false. This function will be called by the frontend for the registration.

###check_new_mark(user, password, previous[])###
check_new_mark should check if there is a new mark in the CIS for a provided user. The previous array knows all the previous marks (Use the marks table for that) and therefor the script can compare the array to the data in the CIS. If there is a new mark, the new mark, the date and the is_informed flag should be written into the database and the send_mark(user) should be triggered. This function is supposed to be called as a cron-script that runs with all users in the database. 

###send_mark(user)###
The send mark script checks the database for the a mark with the not_informed flag and sends the user an email. It therefor collects the marks and calculates the average with weigth.


##Database Concept##

| users         | marks         | curriculum |
| ------------- |:-------------:|------------|
| name          | subject       | subject    |
| password      | value         |creditpoints|
| email         | data          |
                | is_informed   |

