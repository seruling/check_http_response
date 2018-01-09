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
