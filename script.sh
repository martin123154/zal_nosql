dane=baza.zip










#Replica Set {w:1, wtimeout:0}
mkdir -p replica1

for ((i=1; $i<= 5;i++)) ; do
	(time unzip -c $dane \
| mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 \
      --drop -d test -c baza --type csv --headerline) > replica1/"$i.txt" 2>&1
	tail -3 replica1/"$i.txt" > replica1/"czas_$i.txt"
	rm replica1/"$i.txt"
done

exec ./avg.sh "$PWD/replica1" &
exec ./tabelka.sh "$PWD/replica1" "Replica Set {w:1, wtimeout:0}" &


#Replica Set {w:1, j:false}
mkdir -p replica2
for ((i=1; $i<= 5;i++)) ; do
	(time unzip -c $dane \
| mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 \
      --drop -d test -c baza  --type csv --headerline --writeConcern '{w:1, j:false}') > replica2/"$i.txt" 2>&1
	tail -3 replica2/"$i.txt" > replica2/"czas_$i.txt"
	rm replica2/"$i.txt"
done

exec ./avg.sh "$PWD/replica2" &
exec ./tabelka.sh "$PWD/replica2" "Replica Set {w:1, j:false}" &

#Replica Set {w:1, j:true}
mkdir -p replica3
for ((i=1; $i<= 5;i++)) ; do
	(time unzip -c $dane \
| mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 \
      --drop -d test -c baza  --type csv --headerline --writeConcern '{w:1, j:true}') > replica3/"$i.txt" 2>&1
	tail -3 replica3/"$i.txt" > replica3/"czas_$i.txt"
	rm replica3/"$i.txt"
done

exec ./avg.sh "$PWD/replica3" &
exec ./tabelka.sh "$PWD/replica3" "Replica Set {w:1, j:true}" &

#Replica Set {w:2, j:false}
mkdir -p replica4
for ((i=1; $i<= 5;i++)) ; do
	(time unzip -c $dane \
| mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 \
      --drop -d test -c baza  --type csv --headerline --writeConcern '{w:2, j:false}') > replica4/"$i.txt" 2>&1
	tail -3 replica4/"$i.txt" > replica4/"czas_$i.txt"
	rm replica4/"$i.txt"
done

exec ./avg.sh "$PWD/replica4" &
exec ./tabelka.sh "$PWD/replica4" "Replica Set {w:2, j:false}" &

#Replica Set {w:2, j:true}
mkdir -p replica5
for ((i=1; $i<= 5;i++)) ; do
	(time unzip -c $dane \
| mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 \
      --drop -d test -c baza  --type csv --headerline --writeConcern '{w:2, j:true}') > replica5/"$i.txt" 2>&1
	tail -3 replica5/"$i.txt" > replica5/"czas_$i.txt"
	rm replica5/"$i.txt"
done

exec ./avg.sh "$PWD/replica5" &
exec ./tabelka.sh "$PWD/replica5" "Replica Set {w:2, j:true}" &