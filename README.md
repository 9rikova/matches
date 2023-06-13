Эндпоинты:

- `GET /players` - список всех игроков

    параметры: 
  - `page`
  - `per_page`
  - `team_id` (`id` команды игроков)
  - `sort` (принимается только `indicator`)
  - `indicator_id` (`id` показателя, по которому необходимо сделать сортировку)
  - `direction` (направление сортировки, по умолчанию `DESC`)

  `/players?per_page=5&sort=indicator&indicator_id=:indicator_id` - топ 5 игроков по конкретному показателю

  `/players?per_page=5&team_id=:team_id&sort=indicator&indicator_id=:indicator_id` - топ 5 игроков внутри конкретной команды

- `GET /players/:player_id/check_indicator` - проверка выполнил ли игрок показатель
  
    параметры:
  - `indicator_id` (`id` показателя)
  - `times` (минимальное необходимое число раз, по умолчанию 1)
  - `match_number` (количество последних матчей, по умолчанию 5)

  `/players/:player_id/check_indicator?indicator_id=:indicator_id` - проверить выполнил ли игрок конкретный показатель хотя бы 1 раз за предыдущие 5 матчей команды

- `POST /matches/:match_id/players/:player_id/indicator_performances` - создание сущности выполнения показателя
  
  параметры:
  - `indicator_id` (`id` показателя)

  `/matches/:match_id/players/:player_id/indicator_performances?indicator_id=:indicator_id` отметить, что игрок выполнил такой-то показатель в матче

