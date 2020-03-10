#!/usr/bin/env -S awk -f
BEGIN{
  FS="|"
  OFS=","
}

{
  count[$1]++
  if ($NF ~ "OUVERTURE EN COURS DE PROGRAMMATION") {
    count_programmation[$1]++
  } else {
    count_with_date[$1]++
  }
}

END{
  print "ville", "nombre de lignes référencées", "nombre de ligne en cours de programmation", "nombre de lignes avec une date"

  i=0
  for (v in count) {
    villes[i++] = v
  }
  asort(villes)

  for (v in villes) {
    v = villes[v]

    if (!count_programmation[v]) {
      count_programmation[v] = 0
    }

    if (!count_with_date[v]) {
      count_with_date[v] = 0
    }

    programmation_percent = sprintf("%.2f%%", count_programmation[v]*100/count[v])
    with_date_percent = sprintf("%.2f%%", count_with_date[v]*100/count[v])
      
    print tolower(v), count[v], count_programmation[v], programmation_percent, count_with_date[v], with_date_percent

    total += count[v]
    total_programmation += count_programmation[v]
    total_with_date += count_with_date[v]
  }

  programmation_percent = sprintf("%.2f%%", total_programmation*100/total)
  with_date_percent = sprintf("%.2f%%", total_with_date*100/total)
  print "Total département", total, total_programmation, programmation_percent, total_with_date, with_date_percent
}
