# Управление
- wasd - передвижение
- space - перекат
- ПКМ - атака
- ЛКМ - парирование
- z - ульта 1
- x - ульта 2
- c - ульта 3
- v - ульта 4
- b - ульта 5

# ПВП
## Мана
- упрощенная энергия света, используется для заклинаний, ульт атак
- Пополняется со временем

## Ульта
- у каждого рыцаря свой набор ульт атак
- ульта тратит ману

## Оглушение
- действует только на врагов, кроме 
- с определённым шансом (в зависимости от оружия), игрок может оглушить врага
- при оглушении враг не может двигаться или атаковать от 2 до 4 секунд
- враг получает *критический* урон
## Критический урон
- имеет x2 от обычного урона
## Добивание
- если враг оглушён, и на критически малом значении здоровья, то при ударе по нему проигрывается анимация добивания

# Тиры персонажей

## Слаймы
- лёгкий слайм (1 тир)
	- поведение
		- идёт в сторону игрока и кусает его
	- размер
		- 1
- взрывной слайм (2 тир)
	- поведение
		- если игрок подошёл слишком близко, взрывается и оставляет после себя поле с *эффектом*
- средний слайм (3 тир)
	- поведение
		- идёт в сторону игрока
		- прыгает на игрока если он не сильно далеко
	- размер
		- 3
- тяжёлый слайм (4 тир)
	- поведение
		- держится подальше от игрока
		- призывает лёгких слаймов
		- если игрок подошёл достаточно близко, прыгает на него
	- размер
		- 5
- босс слайм (5 тир)
	- поведение
		- делает всё что делают остальные слаймы
		- при ударе даёт игроку *эффектом*
	- размер
		- 10
- король слаймов (6 тир)
	- поведение
		- призывает слаймов 1, 3 и 4 тира
		- раскидывает по арене слаймов
	- размер
		- 30
### Виды слаймов
- огненный 
	- даёт эффект горения
- обычный
	- даёт эффект отравления
- ледяной
	- даёт эффект заморозки
## Рыцари
- ближне-бойный
	- доступные оружия
		- дубина
		- меч
		- кинжалы
	- ульты
		- великий удар (один удар x2 урон)
		- ярость (2x к скорости атаки)
	- вместимость маны
		- 3 ед
- дальне-бойный
	- доступные оружия
		- лук
		- копья
		- арбалет
	- вместимость маны
		- 3 ед
- маг
	- доступные оружия
		- посох
	- вместимость маны
		- 10 ед
# Замок рыцарей
- в этом месте расположен *магазин* и нпс
- есть портал, через который игрок телепортируется на локацию
- игрок может восстановить своё хп и ману
