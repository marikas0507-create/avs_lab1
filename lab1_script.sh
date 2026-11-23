#!/bin/bash

rm -rf ~/lab0

mkdir -p ~/lab0
cd ~/lab0

mkdir -p claude_monet/pastry_station/oven
mkdir -p claude_monet/pastry_station/cold_room
mkdir -p claude_monet/hall
mkdir -p claude_monet/office
mkdir -p louis_room
mkdir -p empty_boxes

echo -e "Луи замешивает тесто ранним утром\nКруассаны должны быть готовы к открытию\nВ первую партию добавить миндальный крем\nБаринов проверит выпечку лично" > claude_monet/pastry_station/oven/croissant_plan

echo -e "Коржи для мильфея выпекаются отдельно\nЛуи готовит ванильный крем\nДесерт украсят свежими ягодами\nПервую порцию подадут Виктору Петровичу" > claude_monet/pastry_station/oven/millefeuille_plan

echo -e "Сливочный крем хранится в холодной комнате\nШоколадный крем нужен для банкета\nЛуи подписывает каждую ёмкость\nОстатки проверяет Лёва после смены" > claude_monet/pastry_station/cold_room/cream_note

echo -e "Классический круассан с миндалём\nМильфей с ванильным кремом\nШоколадный торт от Луи\nФирменный десерт Claude Monet" > claude_monet/pastry_station/dessert_menu

echo -e "Для банкета приготовить двадцать круассанов\nНа главный стол подать шоколадный десерт\nГости ждут торт к девятнадцати часам\nВика просит проверить каждый заказ" > claude_monet/hall/banquet_orders

echo -e "Постоянный гость просит десерт без орехов\nЗа седьмым столиком ждут мильфей\nДетям приготовить небольшие круассаны\nОдин гость хочет познакомиться с Луи" > claude_monet/hall/guest_wishes

echo -e "Баринов требует уменьшить количество сахара\nКрем должен быть приготовлен перед подачей\nЛуи отвечает за оформление десертов\nНовое меню показать шефу до обеда" > claude_monet/office/barinov_comment

echo -e "Луи пришёл в кондитерский цех первым\nУтром он приготовил любимый десерт Нагиева\nПосле банкета Луи позвонил маме\nВечером весь зал похвалил его торт" > louis_room/louis_diary

echo -e "Луи начинает работу в семь часов\nДо открытия нужно проверить печь\nПосле обеда начинается подготовка банкета\nЗакрывает кондитерский цех Лёва" > louis_room/work_schedule

echo -e "К открытию подготовить свежую выпечку\nВика ждёт список готовых десертов\nБаринов проводит проверку в десять часов\nЛуи передаёт первый заказ официантам" > morning_order

cp louis_room/louis_diary claude_monet/office/confectioner_report
cp -r claude_monet/hall claude_monet/pastry_station/hall_backup

cd louis_room
ln -s ../claude_monet/pastry_station/dessert_menu today_menu
cd ..

ln -s claude_monet/pastry_station dessert_counter
ln morning_order claude_monet/pastry_station/urgent_order

cat claude_monet/pastry_station/oven/croissant_plan claude_monet/pastry_station/oven/millefeuille_plan > claude_monet/pastry_station/baking_plan
cat claude_monet/office/barinov_comment >> claude_monet/pastry_station/dessert_menu
mv claude_monet/hall/guest_wishes claude_monet/office/special_wishes

chmod 755 claude_monet
chmod u+rwx,g+rx,o-rwx claude_monet/pastry_station
chmod 750 claude_monet/pastry_station/oven
chmod u+rw,g+r,g-w,o-rwx claude_monet/pastry_station/oven/croissant_plan
chmod 640 claude_monet/pastry_station/oven/millefeuille_plan
chmod u+rwx,g+rx,g-w,o-rwx claude_monet/pastry_station/cold_room
chmod 600 claude_monet/pastry_station/cold_room/cream_note
chmod u+rw,g+r,o+r claude_monet/pastry_station/dessert_menu
chmod 755 claude_monet/hall
chmod u+rw,g+rw,o+r,o-w claude_monet/hall/banquet_orders
chmod 644 claude_monet/office/special_wishes
chmod u+rwx,g+rx,o-rwx claude_monet/office
chmod 640 claude_monet/office/barinov_comment
chmod 750 louis_room
chmod u+r,g+r,u-wx,g-w,o-rwx louis_room/louis_diary
chmod 644 louis_room/work_schedule
chmod u+rwx,g-rwx,o-rwx empty_boxes
chmod 644 morning_order

chmod 640 claude_monet/office/confectioner_report
chmod 755 claude_monet/pastry_station/hall_backup
chmod 644 claude_monet/pastry_station/baking_plan

echo -e "\n Результаты Раздела 4 "
echo "Пункт 1:"
ls -lR | grep "^-" | grep -v "report" | sort -k5 -n | tail -n 5

echo -e "\nПункт 2:"
grep -rih -e "луи" -e "десерт" claude_monet louis_room | grep -vi "гост" | sort -r | head -n 5

echo -e "\nПункт 3:"
grep -ril "десерт" claude_monet/hall claude_monet/pastry_station/hall_backup | wc -l

echo -e "\nПункт 4:"
tail -n 2 -q claude_monet/pastry_station/oven/croissant_plan claude_monet/pastry_station/oven/millefeuille_plan | grep -ri -e "десерт" -e "порц" | sort

echo -e "\nПункт 5:"
grep -v "Луи" claude_monet/pastry_station/baking_plan | sort -r | head -n 4 | wc -w

echo -e "\nПункт 6:"
ls -lR | grep "^-[^ ]* 2 " | sort -t' ' -k9 -r

echo -e "\nПункт 7:"
ls -lR | grep "^l" | sort -t' ' -k9 | tail -n 1

rm -f louis_room/louis_diary
rm -f louis_room/today_menu
rm -f dessert_counter
rm -f morning_order
rm -f claude_monet/pastry_station/urgent_order
rm -f claude_monet/pastry_station/cold_room/cream_note
rmdir empty_boxes
rm -rf claude_monet/pastry_station/hall_backup

echo -e "\n ЛАБОРАТОРНАЯ РАБОТА ВЫПОЛНЕНА"
