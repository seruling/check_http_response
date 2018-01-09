# check_http_response
make a curl request from a list of domain/ip and check for a specific string in the http response.

-f Input file (Required)
-m Expected string in response (Required)
-a Suffix to append
-t Timeout in seconds
-p Port number
-h This help
-s Enable https switch. Default http

./request_check.sh -f list.txt -m "logged-in" -a "/login.aspx" -p 8080 -d "u=username&p=pass123"

i have a list of IP/domain in list2.txt. i want to check if there is any login form running on this domain/ip on port 7002. 
