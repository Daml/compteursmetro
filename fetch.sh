PDC=$1
PRATIQUE=$2

curl 'http://data.eco-counter.com/ParcPublic/CounterData' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'Accept: text/plain, */*; q=0.01' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Origin: http://data.eco-counter.com' \
  -H 'Referer: http://data.eco-counter.com/ParcPublic/?id=120' \
  -H 'Accept-Language: en-US,en;q=0.9,fr;q=0.8' \
  --data "idOrganisme=120&idPdc=$PDC&fin=19%2F05%2F2020&debut=01%2F01%2F2000&interval=4&pratiques=$PRATIQUE" \
  --compressed \
  --insecure
