
# Projekt na zaliczenie 
## Martin Zelek

Projekt został napisany w Ruby

## Kroki które należy wykonać:

## KROK 1. Postawienie replica set

```
mkdir -p carbon
cd carbon
mkdir -p data-{1,2,3}

mongod --port 27001 --replSet carbon --dbpath data-1 --bind_ip localhost --oplogSize 128 
mongod --port 27002 --replSet carbon --dbpath data-2 --bind_ip localhost --oplogSize 128
mongod --port 27003 --replSet carbon --dbpath data-3 --bind_ip localhost --oplogSize 128

mongo --host localhost:27001

rsconf = {
  _id: "carbon",
  members: [
    { _id: 0, host: "localhost:27001" },
    { _id: 1, host: "localhost:27002" },
    { _id: 2, host: "localhost:27003" }
   ]
}

rs.initiate(rsconf)

```

## KROK 2

Zaimportowanie do replica set bazy, która znajduję się w pliku "data". Jest to obcięta baza, zawiera 20 tysięcy rekordów, przekonwertowana z csv to json
```
mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 --db test --collection baza --file ../data/baza.json --drop
```


## KROK 3

Uruchomić w folderze projektu:
```
rspec
```

Aby sprawdzić czy połączenie z bazą jest poprawne

Po wykonaniu tych kroków można przejść do agregacji.

# Skrypty

## agg1.rb

Skrypt ten zlicza najcześciej występujące nazwiska w bazie
```
ruby agg1.rb -l 10
```
<table>
  <tr>
    <th>_id</th>
    <th>count</th>
  </tr>
  <tr>
    <td>MILLER</td>
    <td>211</td>
  </tr>
  <tr>
    <td>JOHNSON</td>
    <td>183</td>
  </tr>
  <tr>
    <td>SMITH</td>
    <td>177</td>
  </tr>
  <tr>
    <td>ANDERSON</td>
    <td>144</td>
  </tr>
  <tr>
    <td>BROWN</td>
    <td>130</td>
  </tr>
  <tr>
    <td>MOORE</td>
    <td>111</td>
  </tr>
  <tr>
    <td>JONES</td>
    <td>110</td>
  </tr>
  <tr>
    <td>NELSON</td>
    <td>89</td>
  </tr>
  <tr>
    <td>JACKSON</td>
    <td>88</td>
  </tr>
  <tr>
    <td>OLSON</td>
    <td>83</td>
  </tr>
</table>
<to_s/>



## agg2.rb


```
ruby agg2.rb
```

Skrypt ten tworzy diagram i zapisuje go do formatu pdf z ilością wystąpień typu licecji. Rozwiązanie znajduje się https://github.com/martin123154/zal_nosql/blob/master/martin_zal/bin/license_type.pdf


## insert_one

Dzięki temu skryptowi można dodać do bazy jeden rekord

