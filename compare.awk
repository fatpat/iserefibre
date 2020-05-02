#!/usr/bin/env -S awk -f
BEGIN{
  FS=","
  OFS=","
}

# ignore first line
FNR <= 1 { next }

# ignore last line

NR == FNR {
  if ($1 ~ "Total") {
    t1=$0
  } else {
    c1[$1]=$1","$2","$3","$5","$6
  }
  next
}

NR != FNR {
  if ($1 ~ "Total") {
    t2=$0
  } else {
    c2[$1]=$1","$2","$3","$5","$6
  }
  next
}

END {
  for (ville in c1) {
    if (ville in c2) {
      if (c1[ville] != c2[ville]) {
        diff[ville]=c1[ville]","c2[ville]
        ndiff++
      }
    } else {
      deleted[ville]=c1[ville]
      ndeleted++
    }
  }
  for (ville in c2) {
    if (! (ville in c1)) {
      new[ville]=c2[ville]
      nnew++
    }
  }

  if ( ndeleted > 0 ) {
    print ""
    print "Villes supprimmées:"
    print "ville", "nombre d'adresses anciennement référencées", "Ancien % adresses commercialisables"
    n=asorti(deleted, sorted)
    for (i=1;i<=n;i++) {
      ville=sorted[i]
      split(deleted[ville],a,FS)
      print ville,a[2],a[5]
    }
  }

  if ( nnew > 0 ) {
    print ""
    print "Villes ajoutées:"
    print "ville", "nombre d'adresses référencées", "nombre d'adresses non commercialisables", "nombre d'adresses commercialisables", "% lignes commercialisables"
    n=asorti(new, sorted)
    for (i=1;i<=n;i++) {
      ville=sorted[i]
      print new[ville]
    }
  }

  if ( ndiff > 0 ) {
    print ""
    print "Villes modifiées:"
    print "ville", "diff nombre d'adresses référencées", "diff nombre d'adresses non commercialisables", "diff nombre d'adresses commercialisables", "diff % lignes commercialisables"
    n=asorti(diff, sorted)
    for (i=1;i<=n;i++) {
      ville=sorted[i]
      split(diff[ville],a,FS)
      n1=sprintf("%d->%d (%+d)", a[2], a[7], a[7]-a[2])
      n2=sprintf("%d->%d (%+d)", a[3], a[8], a[8]-a[3])
      n3=sprintf("%d->%d (%+d)", a[4], a[9], a[9]-a[4])
      n4=sprintf("%s->%s (%+.2f%%)", a[5], a[10], a[10]-a[5])
      print ville,n1,n2,n3,n4
    }
  }

  print ""
  print "Différences globales:"
  printf("%d villes supprimmées\n", ndeleted)
  printf("%d villes ajoutées\n", nnew)
  printf("%d villes modifiées\n", ndiff)
  split(t1,a,FS)
  split(t2,b,FS)
  printf("Evolution du nb d'adresses référencées: %s -> %s (%+d)\n", a[2], b[2], b[2]-a[2])
  printf("Evolution du nb d'adresses non commercialisables: %s -> %s (%+d)\n", a[3], b[3], b[3]-a[3])
  printf("Evolution du nb d'adresses commercialisables: %s -> %s (%+d)\n", a[5], b[5], b[5]-a[5])
  printf("Evolution du %% d'adresses commercialisables: %s -> %s (%+.2f%%)\n", a[6], b[6], b[6]-a[6])
}
