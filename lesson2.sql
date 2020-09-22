/*
1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf,
задав в нем логин и пароль, который указывался при установке.
*/

            /*
                Запускаем mysql      mysql -u root -p
                по умолчанию пароль не требуется
                создаем конфигурационный файл ~/.my.cnf и добавляем в него конфиг
                [mysql] [client] - чтобы все команды работали без пароля
                user=user
                password=password
                чтение его только хозяину файла sudo chmod 0600 .my.cnf
                Теперь запуск будет через mysql
            */



 /*
 2 Создайте базу данных example, разместите в ней таблицу users,
 состоящую из двух столбцов, числового id и строкового name.
 */


                CREATE DATABASE example DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

                CREATE TABLE `example`.`users` ( `id` INT NOT NULL AUTO_INCREMENT ,
                `name` CHAR(50) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;



 /*
 3 Создайте дамп базы данных example из предыдущего задания,
 разверните содержимое дампа в новую базу данных sample.
 */

            /*
                Создаём файл dump_example.sql и настраиваем права
                В терминале набираем
                sudo mysqldump -uroot -p example > dump_example.sql
                Заходим в терминал mysql
            */
                CREATE DATABASE sample;
            /*
                и далее в bash
                mysql sample < /usr/local/mysql-8.0.20-macos10.15-x86_64/bin/dump_example.sql
            */


/*
 4 (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump.
 Создайте дамп единственной таблицы help_keyword базы данных mysql.
 Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
 */

            /*
                в bash
                mysqldump -w "true limit 100" mysql help_keyword > ~/dump_mysql.sql
            */
