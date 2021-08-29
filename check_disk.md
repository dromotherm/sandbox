# fsck

sans erreur :
```
sudo fsck -y /dev/mmcblk0p1
fsck de util-linux 2.31.1
fsck.fat 4.1 (2017-01-24)
/dev/mmcblk0p1: 276 files, 98343/516190 clusters

sudo fsck -y /dev/mmcblk0p3
fsck de util-linux 2.31.1
e2fsck 1.44.1 (24-Mar-2018)
/dev/mmcblk0p3 : propre, 16/655360 fichiers, 170875/10485760 blocs
```
avec erreurs, disque corrompu

```
sudo fsck -y /dev/mmcblk0p2
fsck de util-linux 2.31.1
e2fsck 1.44.1 (24-Mar-2018)
rootfs contient un système de fichiers comportant des erreurs, vérification forcée.
L'i-noeud de changement de taille n'est pas valide.  Recréer ? oui

Passe 1 : vérification des i-noeuds, des blocs et des tailles
Passe 2 : vérification de la structure des répertoires
L'entrée « mmal_parameters_video.h » dans /opt/vc/include/interface/mmal (842) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_port.h » dans /opt/vc/include/interface/mmal (842) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_types.h » dans /opt/vc/include/interface/mmal (842) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « vc_vchi_dispmanx_common.h » dans /opt/vc/include/interface/peer (843) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_clock_private.h » dans /opt/vc/include/interface/mmal/core (1060) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_core_private.h » dans /opt/vc/include/interface/mmal/core (1060) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_port_private.h » dans /opt/vc/include/interface/mmal/core (1060) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_connection.h » dans /opt/vc/include/interface/mmal/util (1061) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_graph.h » dans /opt/vc/include/interface/mmal/util (1061) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_list.h » dans /opt/vc/include/interface/mmal/util (1061) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_util.h » dans /opt/vc/include/interface/mmal/util (1061) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_util_rational.h » dans /opt/vc/include/interface/mmal/util (1061) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_vc_api_drm.h » dans /opt/vc/include/interface/mmal/vc (1062) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_vc_msgnames.h » dans /opt/vc/include/interface/mmal/vc (1062) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « mmal_vc_opaque_alloc.h » dans /opt/vc/include/interface/mmal/vc (1062) a un type de fichier incorrect (était 1, devrait être 7).
Corriger ? oui

L'entrée « socat.md5sums » dans /var/lib/dpkg/info (42721) a un i-noeud effacé/non utilisé 142939.  Effacer ? oui

Passe 3 : vérification de la connectivité des répertoires
Passe 4 : vérification des compteurs de référence
le compteur de référence de l'i-noeud 1395 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1396 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1397 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1398 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1399 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1400 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1401 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1402 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1403 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1404 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1405 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1406 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1407 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1408 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1409 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1410 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1411 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1412 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1413 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1414 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1415 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1416 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1417 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1418 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1419 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1420 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1421 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1422 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1423 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1424 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1425 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1426 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1427 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1428 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1429 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1430 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1431 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1432 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1433 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1434 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1435 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1436 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1437 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1438 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1439 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1440 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1441 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1442 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1443 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1444 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1445 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1446 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1447 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1448 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1449 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1450 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1451 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1452 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1453 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1454 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1455 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1456 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1457 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1458 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1459 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1460 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1461 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1462 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1463 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1464 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1465 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1466 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1467 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1468 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1469 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1470 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1471 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1472 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1473 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1474 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1475 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1476 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1477 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1478 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1479 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1480 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1481 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1482 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1483 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1484 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1485 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1486 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1487 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1488 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1489 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1490 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1491 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1492 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1493 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1494 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1495 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1496 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1497 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1498 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1499 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1500 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1501 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1502 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1503 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1504 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1505 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1506 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1507 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1508 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1509 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1510 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1511 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1512 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1513 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1514 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1515 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1516 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1517 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1518 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1519 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1520 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1521 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1522 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1523 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1524 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1525 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1526 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1527 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1528 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1529 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1530 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1531 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1532 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1533 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1534 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1535 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1536 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1537 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1538 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1539 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1540 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1541 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1542 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1543 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1544 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1545 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1546 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1547 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1548 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1549 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1550 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1551 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1552 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1553 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1554 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1555 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1556 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1557 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1558 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1559 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1560 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1561 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1562 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 1563 est 1, devrait être 2.  Corriger ? oui

I-noeud 1644 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1644 est 2, devrait être 1.  Corriger ? oui

I-noeud 1645 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1645 est 2, devrait être 1.  Corriger ? oui

I-noeud 1646 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1646 est 2, devrait être 1.  Corriger ? oui

I-noeud 1647 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1647 est 2, devrait être 1.  Corriger ? oui

I-noeud 1648 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1648 est 2, devrait être 1.  Corriger ? oui

I-noeud 1649 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1649 est 2, devrait être 1.  Corriger ? oui

I-noeud 1650 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1650 est 2, devrait être 1.  Corriger ? oui

I-noeud 1651 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1651 est 2, devrait être 1.  Corriger ? oui

I-noeud 1652 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1652 est 2, devrait être 1.  Corriger ? oui

I-noeud 1653 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1653 est 2, devrait être 1.  Corriger ? oui

I-noeud 1654 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1654 est 2, devrait être 1.  Corriger ? oui

I-noeud 1655 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1655 est 2, devrait être 1.  Corriger ? oui

I-noeud 1656 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1656 est 2, devrait être 1.  Corriger ? oui

I-noeud 1657 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1657 est 2, devrait être 1.  Corriger ? oui

I-noeud 1658 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1658 est 2, devrait être 1.  Corriger ? oui

I-noeud 1659 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1659 est 2, devrait être 1.  Corriger ? oui

I-noeud 1660 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1660 est 2, devrait être 1.  Corriger ? oui

I-noeud 1661 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1661 est 2, devrait être 1.  Corriger ? oui

I-noeud 1665 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1665 est 2, devrait être 1.  Corriger ? oui

I-noeud 1668 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1668 est 2, devrait être 1.  Corriger ? oui

I-noeud 1676 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1676 est 2, devrait être 1.  Corriger ? oui

I-noeud 1692 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1692 est 2, devrait être 1.  Corriger ? oui

I-noeud 1699 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1699 est 2, devrait être 1.  Corriger ? oui

I-noeud 1704 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1704 est 2, devrait être 1.  Corriger ? oui

I-noeud 1706 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1706 est 2, devrait être 1.  Corriger ? oui

I-noeud 1707 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1707 est 2, devrait être 1.  Corriger ? oui

I-noeud 1708 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1708 est 2, devrait être 1.  Corriger ? oui

I-noeud 1709 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1709 est 2, devrait être 1.  Corriger ? oui

I-noeud 1710 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1710 est 2, devrait être 1.  Corriger ? oui

I-noeud 1711 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1711 est 2, devrait être 1.  Corriger ? oui

I-noeud 1712 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1712 est 2, devrait être 1.  Corriger ? oui

I-noeud 1713 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1713 est 2, devrait être 1.  Corriger ? oui

I-noeud 1714 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1714 est 2, devrait être 1.  Corriger ? oui

I-noeud 1715 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1715 est 2, devrait être 1.  Corriger ? oui

I-noeud 1716 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1716 est 2, devrait être 1.  Corriger ? oui

I-noeud 1717 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1717 est 2, devrait être 1.  Corriger ? oui

I-noeud 1718 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1718 est 2, devrait être 1.  Corriger ? oui

I-noeud 1719 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1719 est 2, devrait être 1.  Corriger ? oui

I-noeud 1720 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1720 est 2, devrait être 1.  Corriger ? oui

I-noeud 1721 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1721 est 2, devrait être 1.  Corriger ? oui

I-noeud 1722 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1722 est 2, devrait être 1.  Corriger ? oui

I-noeud 1723 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1723 est 2, devrait être 1.  Corriger ? oui

I-noeud 1724 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1724 est 2, devrait être 1.  Corriger ? oui

I-noeud 1725 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1725 est 2, devrait être 1.  Corriger ? oui

I-noeud 1726 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1726 est 2, devrait être 1.  Corriger ? oui

I-noeud 1727 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1727 est 2, devrait être 1.  Corriger ? oui

I-noeud 1728 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1728 est 2, devrait être 1.  Corriger ? oui

I-noeud 1729 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1729 est 2, devrait être 1.  Corriger ? oui

I-noeud 1730 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1730 est 2, devrait être 1.  Corriger ? oui

I-noeud 1731 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1731 est 2, devrait être 1.  Corriger ? oui

I-noeud 1732 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1732 est 2, devrait être 1.  Corriger ? oui

I-noeud 1733 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1733 est 2, devrait être 1.  Corriger ? oui

I-noeud 1734 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1734 est 2, devrait être 1.  Corriger ? oui

I-noeud 1735 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1735 est 2, devrait être 1.  Corriger ? oui

I-noeud 1736 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1736 est 2, devrait être 1.  Corriger ? oui

I-noeud 1737 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1737 est 2, devrait être 1.  Corriger ? oui

I-noeud 1738 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1738 est 2, devrait être 1.  Corriger ? oui

I-noeud 1739 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1739 est 2, devrait être 1.  Corriger ? oui

I-noeud 1740 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1740 est 2, devrait être 1.  Corriger ? oui

I-noeud 1741 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1741 est 2, devrait être 1.  Corriger ? oui

I-noeud 1742 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1742 est 2, devrait être 1.  Corriger ? oui

I-noeud 1743 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1743 est 2, devrait être 1.  Corriger ? oui

I-noeud 1744 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1744 est 2, devrait être 1.  Corriger ? oui

I-noeud 1745 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1745 est 2, devrait être 1.  Corriger ? oui

I-noeud 1746 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1746 est 2, devrait être 1.  Corriger ? oui

I-noeud 1747 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1747 est 2, devrait être 1.  Corriger ? oui

I-noeud 1748 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1748 est 2, devrait être 1.  Corriger ? oui

I-noeud 1749 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1749 est 2, devrait être 1.  Corriger ? oui

I-noeud 1750 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1750 est 2, devrait être 1.  Corriger ? oui

I-noeud 1751 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1751 est 2, devrait être 1.  Corriger ? oui

I-noeud 1752 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1752 est 2, devrait être 1.  Corriger ? oui

I-noeud 1753 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1753 est 2, devrait être 1.  Corriger ? oui

I-noeud 1754 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1754 est 2, devrait être 1.  Corriger ? oui

I-noeud 1755 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1755 est 2, devrait être 1.  Corriger ? oui

I-noeud 1756 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1756 est 2, devrait être 1.  Corriger ? oui

I-noeud 1757 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1757 est 2, devrait être 1.  Corriger ? oui

I-noeud 1758 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1758 est 2, devrait être 1.  Corriger ? oui

I-noeud 1759 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1759 est 2, devrait être 1.  Corriger ? oui

I-noeud 1760 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1760 est 2, devrait être 1.  Corriger ? oui

I-noeud 1761 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1761 est 2, devrait être 1.  Corriger ? oui

I-noeud 1762 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1762 est 2, devrait être 1.  Corriger ? oui

I-noeud 1763 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1763 est 2, devrait être 1.  Corriger ? oui

I-noeud 1764 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1764 est 2, devrait être 1.  Corriger ? oui

I-noeud 1765 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1765 est 2, devrait être 1.  Corriger ? oui

I-noeud 1766 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1766 est 2, devrait être 1.  Corriger ? oui

I-noeud 1767 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1767 est 2, devrait être 1.  Corriger ? oui

I-noeud 1768 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1768 est 2, devrait être 1.  Corriger ? oui

I-noeud 1769 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1769 est 2, devrait être 1.  Corriger ? oui

I-noeud 1770 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1770 est 2, devrait être 1.  Corriger ? oui

I-noeud 1771 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1771 est 2, devrait être 1.  Corriger ? oui

I-noeud 1772 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1772 est 2, devrait être 1.  Corriger ? oui

I-noeud 1773 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1773 est 2, devrait être 1.  Corriger ? oui

I-noeud 1774 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1774 est 2, devrait être 1.  Corriger ? oui

I-noeud 1775 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1775 est 2, devrait être 1.  Corriger ? oui

I-noeud 1776 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1776 est 2, devrait être 1.  Corriger ? oui

I-noeud 1777 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1777 est 2, devrait être 1.  Corriger ? oui

I-noeud 1778 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1778 est 2, devrait être 1.  Corriger ? oui

I-noeud 1779 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1779 est 2, devrait être 1.  Corriger ? oui

I-noeud 1780 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1780 est 2, devrait être 1.  Corriger ? oui

I-noeud 1781 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1781 est 2, devrait être 1.  Corriger ? oui

I-noeud 1782 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1782 est 2, devrait être 1.  Corriger ? oui

I-noeud 1783 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1783 est 2, devrait être 1.  Corriger ? oui

I-noeud 1784 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1784 est 2, devrait être 1.  Corriger ? oui

I-noeud 1785 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1785 est 2, devrait être 1.  Corriger ? oui

I-noeud 1786 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1786 est 2, devrait être 1.  Corriger ? oui

I-noeud 1787 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1787 est 2, devrait être 1.  Corriger ? oui

I-noeud 1788 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 1788 est 2, devrait être 1.  Corriger ? oui

I-noeud 8475 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8475 est 2, devrait être 1.  Corriger ? oui

I-noeud 8476 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8476 est 2, devrait être 1.  Corriger ? oui

I-noeud 8477 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8477 est 2, devrait être 1.  Corriger ? oui

I-noeud 8478 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8478 est 2, devrait être 1.  Corriger ? oui

I-noeud 8479 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8479 est 2, devrait être 1.  Corriger ? oui

I-noeud 8480 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8480 est 2, devrait être 1.  Corriger ? oui

I-noeud 8481 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8481 est 2, devrait être 1.  Corriger ? oui

I-noeud 8482 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8482 est 2, devrait être 1.  Corriger ? oui

I-noeud 8483 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8483 est 2, devrait être 1.  Corriger ? oui

I-noeud 8484 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8484 est 2, devrait être 1.  Corriger ? oui

I-noeud 8485 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8485 est 2, devrait être 1.  Corriger ? oui

I-noeud 8486 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8486 est 2, devrait être 1.  Corriger ? oui

I-noeud 8487 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8487 est 2, devrait être 1.  Corriger ? oui

I-noeud 8488 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8488 est 2, devrait être 1.  Corriger ? oui

I-noeud 8489 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8489 est 2, devrait être 1.  Corriger ? oui

I-noeud 8490 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8490 est 2, devrait être 1.  Corriger ? oui

I-noeud 8491 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8491 est 2, devrait être 1.  Corriger ? oui

I-noeud 8492 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8492 est 2, devrait être 1.  Corriger ? oui

I-noeud 8493 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8493 est 2, devrait être 1.  Corriger ? oui

I-noeud 8494 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8494 est 2, devrait être 1.  Corriger ? oui

I-noeud 8495 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8495 est 2, devrait être 1.  Corriger ? oui

I-noeud 8496 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8496 est 2, devrait être 1.  Corriger ? oui

I-noeud 8497 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8497 est 2, devrait être 1.  Corriger ? oui

I-noeud 8498 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8498 est 2, devrait être 1.  Corriger ? oui

I-noeud 8499 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8499 est 2, devrait être 1.  Corriger ? oui

I-noeud 8500 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8500 est 2, devrait être 1.  Corriger ? oui

I-noeud 8501 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8501 est 2, devrait être 1.  Corriger ? oui

I-noeud 8502 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8502 est 2, devrait être 1.  Corriger ? oui

I-noeud 8503 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8503 est 2, devrait être 1.  Corriger ? oui

I-noeud 8504 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8504 est 2, devrait être 1.  Corriger ? oui

I-noeud 8505 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8505 est 2, devrait être 1.  Corriger ? oui

I-noeud 8506 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8506 est 2, devrait être 1.  Corriger ? oui

I-noeud 8507 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8507 est 2, devrait être 1.  Corriger ? oui

I-noeud 8508 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8508 est 2, devrait être 1.  Corriger ? oui

I-noeud 8521 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8521 est 2, devrait être 1.  Corriger ? oui

I-noeud 8522 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8522 est 2, devrait être 1.  Corriger ? oui

I-noeud 8523 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8523 est 2, devrait être 1.  Corriger ? oui

I-noeud 8524 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8524 est 2, devrait être 1.  Corriger ? oui

I-noeud 8525 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8525 est 2, devrait être 1.  Corriger ? oui

I-noeud 8526 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8526 est 2, devrait être 1.  Corriger ? oui

I-noeud 8527 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8527 est 2, devrait être 1.  Corriger ? oui

I-noeud 8528 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8528 est 2, devrait être 1.  Corriger ? oui

I-noeud 8529 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8529 est 2, devrait être 1.  Corriger ? oui

I-noeud 8530 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8530 est 2, devrait être 1.  Corriger ? oui

I-noeud 8531 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8531 est 2, devrait être 1.  Corriger ? oui

I-noeud 8532 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8532 est 2, devrait être 1.  Corriger ? oui

I-noeud 8533 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8533 est 2, devrait être 1.  Corriger ? oui

I-noeud 8534 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8534 est 2, devrait être 1.  Corriger ? oui

I-noeud 8535 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8535 est 2, devrait être 1.  Corriger ? oui

I-noeud 8536 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8536 est 2, devrait être 1.  Corriger ? oui

I-noeud 8537 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8537 est 2, devrait être 1.  Corriger ? oui

I-noeud 8538 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8538 est 2, devrait être 1.  Corriger ? oui

I-noeud 8539 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8539 est 2, devrait être 1.  Corriger ? oui

I-noeud 8643 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8643 est 2, devrait être 1.  Corriger ? oui

I-noeud 8644 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8644 est 2, devrait être 1.  Corriger ? oui

I-noeud 8645 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8645 est 2, devrait être 1.  Corriger ? oui

I-noeud 8646 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8646 est 2, devrait être 1.  Corriger ? oui

I-noeud 8647 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8647 est 2, devrait être 1.  Corriger ? oui

I-noeud 8648 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8648 est 2, devrait être 1.  Corriger ? oui

I-noeud 8649 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8649 est 2, devrait être 1.  Corriger ? oui

I-noeud 8650 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8650 est 2, devrait être 1.  Corriger ? oui

I-noeud 8651 non attaché
Connecter à /lost+found ? oui

le compteur de référence de l'i-noeud 8651 est 2, devrait être 1.  Corriger ? oui

le compteur de référence de l'i-noeud 142504 est 1, devrait être 2.  Corriger ? oui

le compteur de référence de l'i-noeud 142647 est 1, devrait être 2.  Corriger ? oui

Passe 5 : vérification de l'information du sommaire de groupe
différences de bitmap de blocs :  -(176128--178175)
Corriger ? oui

Le décompte des blocs libres est erroné pour le groupe n°0 (17348, décompté=17349).
Corriger ? oui

Le décompte des blocs libres est erroné (590022, décompté=590023).
Corriger ? oui


rootfs: ***** LE SYSTÈME DE FICHIERS A ÉTÉ MODIFIÉ *****
rootfs : 55007/277440 fichiers (0.1% non contigus), 500537/1090560 blocs

```
