proxy=curl http://localhost:9000/api/status/nodes | grep Name | grep -o '"Name":"[^"]*' | awk -F'"' '{print $4}'

echo $proxy

read -p "Press Enter to exit..."