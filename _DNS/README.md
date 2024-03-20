
# gérer ses noms de domaine

![DNS.png](DNS.png)

On a autant de champs CNAME qu'on a de sous-domaines

Ici, on a : 

- le domaine `www.dromotherm.com` avec la ligne `www 1800 IN CNAME dromotherm.github.io.`
- le sous-domaine `obm.dromotherm.com` avec la ligne `obm 1800 IN CNAME Open-Building-Management.github.io.`

A noter qu'on a toujours un `.` à la fin de `dromotherm.github.io.` ou de `Open-Building-Management.github.io.`

Il faut ensuite créer le fichier CNAME à la racine du site web, mais seulement quant on déploie depuis une branche.

Si on publie à partir d’un workflow GitHub Actions, tout fichier CNAME est ignoré et n’est pas requis.

On peut utiliser l'outil dig en ligne de commande pour vérifier que le sous domaine `obm.dromotherm.com` pointe bien vers les github pages.

```
dig obm.dromotherm.com +noall +answer -t A
obm.dromotherm.com.	1800	IN	CNAME	Open-Building-Management.github.io.
Open-Building-Management.github.io. 1433 IN A	185.199.111.153
Open-Building-Management.github.io. 1433 IN A	185.199.108.153
Open-Building-Management.github.io. 1433 IN A	185.199.109.153
Open-Building-Management.github.io. 1433 IN A	185.199.110.153
```
# dynamic dns

check the external ip from the local machine

https://github.com/begleysm/ipwatch/
