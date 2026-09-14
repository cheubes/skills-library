---
name: restaurant-finder
description: Recherche des restaurants dans une zone donnée sur le web et retourne une liste au format Markdown avec type de cuisine, fourchette de prix, adresse avec lien Google Maps, site web, notes Google et TripAdvisor, et horaires d'ouverture. À utiliser quand l'utilisateur demande de trouver des restaurants, veut des recommandations, ou cherche des endroits où manger dans une ville, un quartier ou une région.
---

# Restaurant finder

Recherche des restaurants correspondant à la demande de l'utilisateur et les présente sous forme de liste Markdown structurée.

## Analyse de la demande

1. **La zone géographique est obligatoire.** Si la demande n'en précise pas (ville, quartier, adresse, région), demander à l'utilisateur avant de lancer la recherche, jamais deviner ni appliquer une zone par défaut. Si une zone est précisée mais que ses limites ne peuvent pas être vérifiées par la recherche web (quartier mal documenté, ville peu couverte en ligne, découpage introuvable...), ne pas deviner une proximité approximative : le signaler à l'utilisateur et lui demander de préciser la zone, en proposant des suggestions concrètes (par exemple une zone plus large, un point de repère mieux documenté) ainsi qu'une possibilité de saisie libre.
2. **Nombre de résultats.** Dix par défaut. Si l'utilisateur précise un autre nombre, l'utiliser à la place. Si moins de restaurants correspondants existent, retourner uniquement ceux réellement trouvés plutôt que de compléter artificiellement la liste.
3. **Autres critères.** Traiter tout critère additionnel mentionné dans la demande (type de cuisine, fourchette de prix, ambiance, contraintes alimentaires, "ouvert maintenant", etc.) comme un filtre de recherche en plus de la zone.

## Recherche

Utiliser la recherche web et la consultation de pages pour identifier des restaurants candidats et leurs informations, à partir de sources comme Google Maps, TripAdvisor et les sites web des restaurants eux-mêmes. Pour chaque candidat, essayer de collecter :

- Nom
- Type de cuisine
- Fourchette de prix, exprimée avec des symboles € : `€` jusqu'à 15 € par personne, `€€` de 15 à 30 €, `€€€` de 30 à 60 €, `€€€€` au-delà de 60 €
- Adresse complète, et un lien de partage Google Maps (format court `maps.app.goo.gl`). Si un tel lien n'est trouvable nulle part, utiliser à la place un lien de recherche Google Maps classique vers l'établissement. Ce lien ne doit jamais contenir de paramètre `authuser` (il identifie un compte Google précis) : le retirer de l'URL s'il y figure.
- Site web officiel, s'il existe
- Note Google (sur 5), son nombre d'avis, et un lien vers la fiche Google
- Note TripAdvisor (sur 5), son nombre d'avis, et un lien vers la fiche TripAdvisor
- Horaires d'ouverture

Prioriser les sources primaires pour chaque information, dans cet ordre : (1) le site web officiel du restaurant, (2) Google, (3) TripAdvisor. Ne se rabattre sur des sites agrégateurs tiers qu'en dernier recours, si l'information est introuvable sur ces trois sources primaires. En cas de données contradictoires entre elles (par exemple des horaires qui diffèrent), retenir celle de la source la mieux classée dans cet ordre plutôt que de marquer l'information `Non disponible`.

Avant de retenir une information issue d'une fiche externe (TripAdvisor, agrégateur, site web...), vérifier que l'adresse indiquée sur cette fiche correspond bien à celle du candidat recherché. Plusieurs établissements peuvent partager le même nom dans des villes ou quartiers différents, voire avoir plusieurs fiches distinctes pour la même enseigne : ne jamais associer par défaut le premier résultat trouvé pour un nom donné sans confirmer l'adresse.

Exception pour la note Google : Google Maps est en pratique impossible à consulter directement (mur de consentement systématique, y compris sur une fiche précise). Pour ce champ uniquement, chercher activement le chiffre republié par plusieurs sites agrégateurs (par exemple restaurantguru.com, justacote.com, pagesjaunes.fr, rankeat.fr, TheFork) avant de conclure à une absence de donnée. Retenir le chiffre si au moins deux agrégateurs le corroborent ; en cas de chiffres divergents entre agrégateurs, retenir le plus récent. Le lien associé reste un lien vers la fiche ou la recherche Google Maps de l'établissement, jamais vers l'agrégateur. N'écrire `Non disponible` que si aucun agrégateur consulté ne mentionne à la fois une note et un nombre d'avis Google.

Exclure tout établissement identifié comme fermé définitivement dans les sources consultées.

Rédiger toutes les informations collectées en français, y compris quand la source d'origine est dans une autre langue (traduire par exemple le type de cuisine ou les horaires).

Ne jamais inventer ou deviner un restaurant ou une de ses informations. N'inclure que ce qui a été réellement trouvé via la recherche. Si aucun restaurant ne correspond à la zone et aux critères demandés, l'indiquer clairement à l'utilisateur plutôt que de retourner une liste vide sans explication.

## Classement

Écarter tout restaurant dont une note connue (Google ou TripAdvisor) est strictement inférieure à 4/5, même s'il correspond par ailleurs à la zone et aux critères demandés. Cette exclusion ne s'applique qu'aux notes réellement trouvées ; une note marquée `Non disponible` n'entraîne pas d'exclusion à elle seule.

Quand plus de candidats sont trouvés que nécessaire, prioriser les restaurants ayant à la fois une bonne note et un nombre d'avis conséquent : une note quasi parfaite basée sur une poignée d'avis ne doit pas passer devant une note légèrement inférieure mais appuyée par des centaines ou des milliers d'avis. Quand les données Google et TripAdvisor sont toutes les deux disponibles, considérer la note et le nombre d'avis Google comme signal principal.

## Format de sortie

Présenter chaque restaurant avec ce gabarit exact, avec de vrais liens Markdown (`[texte](url)`) partout où un lien est demandé. Séparer les entrées par une ligne vide. Si une information précise est introuvable, écrire `Non disponible` à sa place plutôt que d'omettre le champ.

```
### <Nom du restaurant>
🍽️ <Type de cuisine> - 🧾 <Fourchette de prix>
📍 [<Adresse>](<Lien de partage Google Maps>) - 🌐 [<Libellé du site>](<Lien du site>)
🗺️ [<Note Google>/5 (<Nombre d'avis Google> avis)](<Lien de partage Google Maps>) | 🦉 [<Note TripAdvisor>/5 (<Nombre d'avis TripAdvisor> avis)](<Lien de la fiche TripAdvisor>)
🕐 <Horaires d'ouverture>
```

Exemple :

```
### La Pie Noir
🍽️ Cuisine française (inspiration bretonne) - 🧾 €€€
📍 [5 rue de la Montagne Sainte-Geneviève, 75005 Paris](https://maps.app.goo.gl/96M5mWLpcFD4fGPA9) - 🌐 [lapienoir.com](https://lapienoir.com/)
🗺️ [4,8/5 (2 005 avis)](https://maps.app.goo.gl/96M5mWLpcFD4fGPA9) | 🦉 [4,7/5 (687 avis)](https://www.tripadvisor.com/Restaurant_Review-g187147-d12182791-Reviews-Restaurant_La_Pie_Noir-Paris_Ile_de_France.html)
🕐 Mar-sam 12h-14h45, 18h30-00h ; dimanche et lundi fermé
```
