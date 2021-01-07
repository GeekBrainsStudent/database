d:\Program Files\Redis>REDIS-CLI

/* 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов. */

/* Использую хэш с ключом visit,
в качестве поля IP-адрес,
и значение поля - число посещений */ 
127.0.0.1:6379> HSET visit 10.16.0.1 0
(integer) 0
127.0.0.1:6379> HSET visit 10.16.0.2 1
(integer) 1
127.0.0.1:6379> HSET visit 10.16.0.3 0
(integer) 1
/* для увеличения значений поля используется HINCRBY 
указывается ключ хэша, поле (IP-адрес) и число на которое хотим увеличить (в данном случае 1) */ 
127.0.0.1:6379> HINCRBY visit 10.16.0.1 1
(integer) 1
127.0.0.1:6379> HINCRBY visit 10.16.0.3 1
(integer) 1
/* выводим все поля хэша */
127.0.0.1:6379> HGETALL visit
1) "10.16.0.1"
2) "1"
3) "10.16.0.2"
4) "1"
5) "10.16.0.3"
6) "1"


/* 2. При помощи базы данных Redis решите задачу 
поиска имени пользователя по электронному адресу и наоброт, 
поиск электронного адреса пользователя по его имени. */

/* Не смог ничего придумать, кроме как сделать два хэша и поменять местами field и value (прошу строго не судить) */
127.0.0.1:6379> HMSET name Trump trump@mail.ru Merkel merkel@mail.ru Putin putin@mail.ru
OK
127.0.0.1:6379> HMSET email trump@mail.ru Trump merkel@mail.ru Merkel putin@mail.ru Putin
OK
/* Находим email по имени */
127.0.0.1:6379> HGET name Putin
"putin@mail.ru"
/* Находим имя по email */
127.0.0.1:6379> HGET email merkel@mail.ru
"Merkel"


/* 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB. */

/* На оффсайте Mongo можно бесплатно развернуть удаленный сервер, подключаюсь к нему */
d:\Program Files\mongodb-win32-x86_64-windows-4.4.3\bin>mongo "mongodb+srv://cluster0.nvxw8.mongodb.net/shop" --username root
MongoDB shell version v4.4.3
Enter password:
connecting to: mongodb://cluster0-shard-00-00.nvxw8.mongodb.net:27017,cluster0-shard-00-01.nvxw8.mongodb.net:27017,cluster0-shard-00-02.nvxw8.mongodb.net:27017/shop?authSource=admin&compressors=disabled&gssapiServiceName=mongodb&replicaSet=atlas-13kv57-shard-0&ssl=true
{"t":{"$date":"2021-01-07T02:01:08.210Z"},"s":"W",  "c":"NETWORK",  "id":23019,   "ctx":"ReplicaSetMonitor-TaskExecutor","msg":"DNS resolution while connecting to peer was slow","attr":{"peer":"cluster0-shard-00-00.nvxw8.mongodb.net:27017","durationMillis":1355}}
{"t":{"$date":"2021-01-07T02:01:09.394Z"},"s":"W",  "c":"NETWORK",  "id":23019,   "ctx":"ReplicaSetMonitor-TaskExecutor","msg":"DNS resolution while connecting to peer was slow","attr":{"peer":"cluster0-shard-00-02.nvxw8.mongodb.net:27017","durationMillis":2538}}
{"t":{"$date":"2021-01-07T02:01:10.582Z"},"s":"W",  "c":"NETWORK",  "id":23019,   "ctx":"ReplicaSetMonitor-TaskExecutor","msg":"DNS resolution while connecting to peer was slow","attr":{"peer":"cluster0-shard-00-01.nvxw8.mongodb.net:27017","durationMillis":3726}}
Implicit session: session { "id" : UUID("d82c5406-2435-4655-97c1-205891559489") }
MongoDB server version: 4.2.11
WARNING: shell and server versions do not match
Error while trying to show server startup warnings: user is not allowed to do action [getLog] on [admin.]

/* Создаю коллекцию товаров, при этом вместо catalog_id просто указываю к какому каталогу принадлежит товар */
MongoDB Enterprise atlas-13kv57-shard-0:PRIMARY> db.shop.insertMany([
... {
... name: "AMD Atlhon X4 840 OEM",
... description: "Модель с достойными техническими характеристиками",
... price: 1650.00,
... catalog: "Процессоры",
... created_at: new Date(),
... updated_at: new Date()
... },
... {
... name: "Intel Celeron G5905 OEM",
... description: "Чип со сбалансированной производительностью",
... price: 3250.00,
... catalog: "Процессоры",
... created_at: new Date(),
... updated_at: new Date()
... },
... {
... name: "ASRock H110M-DGS R3.0",
... description: "Обладающая совместимостью с процессорами Intel LGA 1151",
... price: 3799.00,
... catalog: "Мат. платы",
... created_at: new Date(),
... updated_at: new Date()
... },
... {
... name: "ASUS A68HM-K",
... description: "ASUS A68HM-K с сокетом FM2+",
... price: 3999.00,
... catalog: "Мат. платы",
... created_at: new Date(),
... updated_at: new Date()
... },
... {
... name: "INNO3D GeForce GT 710 Silent LP",
... description: "Устройство имеет производительные характеристики",
... price: 3099.00,
... catalog: "Видеокарты",
... created_at: new Date(),
... updated_at: new Date()
... }
... ]);
{
        "acknowledged" : true,
        "insertedIds" : [
                ObjectId("5ff66ed214d91797685e703e"),
                ObjectId("5ff66ed214d91797685e703f"),
                ObjectId("5ff66ed214d91797685e7040"),
                ObjectId("5ff66ed214d91797685e7041"),
                ObjectId("5ff66ed214d91797685e7042")
        ]
}

/* Вывожу все товары */
MongoDB Enterprise atlas-13kv57-shard-0:PRIMARY> db.shop.find();
{ "_id" : ObjectId("5ff66ed214d91797685e703e"), "name" : "AMD Atlhon X4 840 OEM", "description" : "Модель с достойными техническими характеристиками", "price" : 1650, "catalog" : "Процессоры", "created_at" : ISODate("2021-01-07T02:15:46.967Z"), "updated_at" : ISODate("2021-01-07T02:15:46.967Z") }
{ "_id" : ObjectId("5ff66ed214d91797685e703f"), "name" : "Intel Celeron G5905 OEM", "description" : "Чип со сбалансированной производительностью", "price" : 3250, "catalog" : "Процессоры", "created_at" : ISODate("2021-01-07T02:15:46.967Z"), "updated_at" : ISODate("2021-01-07T02:15:46.967Z") }
{ "_id" : ObjectId("5ff66ed214d91797685e7040"), "name" : "ASRock H110M-DGS R3.0", "description" : "Обладающая совместимостью с процессорами Intel LGA 1151", "price" : 3799, "catalog" : "Мат. платы", "created_at" : ISODate("2021-01-07T02:15:46.967Z"), "updated_at" : ISODate("2021-01-07T02:15:46.967Z") }
{ "_id" : ObjectId("5ff66ed214d91797685e7041"), "name" : "ASUS A68HM-K", "description" : "ASUS A68HM-K с сокетом FM2+", "price" : 3999, "catalog" : "Мат. платы", "created_at" : ISODate("2021-01-07T02:15:46.967Z"), "updated_at" : ISODate("2021-01-07T02:15:46.967Z") }
{ "_id" : ObjectId("5ff66ed214d91797685e7042"), "name" : "INNO3D GeForce GT 710 Silent LP", "description" : "Устройство имеет производительные характеристики", "price" : 3099, "catalog" : "Видеокарты", "created_at" : ISODate("2021-01-07T02:15:46.967Z"), "updated_at" : ISODate("2021-01-07T02:15:46.967Z") }
MongoDB Enterprise atlas-13kv57-shard-0:PRIMARY>


