---
name: article-summary
description: Résume un article de presse en restant fidèle à son contenu, sans interprétation, en préservant les nuances et réserves de l'auteur. L'article est soit celui de la page ouverte dans le navigateur (Claude pour Chrome), soit celui d'un lien fourni par l'utilisateur. À utiliser quand l'utilisateur demande de résumer un article, une page d'actualité ou un lien ("résume cet article", "fais-moi un résumé", "TL;DR", "summarize this article"), même sans préciser d'URL.
---

# Article summary

Résume un article de presse de façon fidèle, sans rien ajouter ni interpréter, en conservant les nuances et les réserves exprimées par l'auteur.

## Récupération de l'article

1. **Un lien est fourni.** Lire la page correspondante, même si un autre onglet est ouvert dans le navigateur.
2. **Aucun lien, mais un navigateur est accessible** (Claude pour Chrome). Lire le contenu de la page de l'onglet actif : c'est l'article à résumer.
3. **Le texte de l'article est collé dans la conversation.** L'utiliser tel quel.
4. **Aucun des trois cas.** Demander à l'utilisateur le lien ou le texte, sans deviner de quel article il s'agit.

Ne lire que la page demandée : ne pas suivre les liens vers des articles connexes.

## Vérification du contenu lu

- **La page n'est pas un article** (page d'accueil, liste d'articles, résultats de recherche, vidéo sans transcription...) : le signaler et demander à l'utilisateur quel article viser, sans produire de résumé.
- **L'article est incomplet** (paywall, réservé aux abonnés, chargement partiel) : ne résumer que ce qui a réellement été lu et commencer la réponse par un avertissement indiquant que le résumé est partiel. Si seuls le titre et un chapô sont accessibles, le dire plutôt que de résumer un article qui n'a pas été lu. Ne pas chercher à contourner le paywall (archives, caches...), et ne jamais compléter le texte manquant avec des suppositions ou des connaissances extérieures.

## Fidélité au contenu

- Rester fidèle à l'article : aucune interprétation, aucun jugement, aucune conclusion personnelle.
- N'ajouter aucune information extérieure (contexte, vérification des faits, connaissances propres), même si l'article paraît erroné ou incomplet.
- Distinguer les faits rapportés, les citations et les opinions de l'auteur, et attribuer chaque affirmation à sa source ("selon...", "d'après...", "l'auteur estime que...") plutôt que de la présenter comme un fait établi par le résumé.
- Préserver les nuances importantes et les réserves de l'auteur : incertitudes, conditionnel, limites, contre-arguments, points de vue contradictoires rapportés. Ne jamais transformer une hypothèse en fait ni gommer une restriction.
- Reprendre à l'identique les chiffres, dates et noms propres de l'article.
- Garder un ton neutre : ne pas ajouter de connotation absente du texte original.

## Format de sortie

Rédiger en français, même si l'article est dans une autre langue (citations traduites).

Le résumé ne dépasse jamais 250 mots au total (titre, essentiel, points clés et nuances compris), quelle que soit la longueur de l'article. Adapter le nombre de points clés à la taille de l'article (estimée approximativement en nombre de mots) :

| Article | Points clés |
|---|---|
| Brève (moins de 400 mots) | Deux points |
| Standard (400 à 2 000 mots) | Trois ou quatre points |
| Long format (plus de 2 000 mots) | Cinq points au maximum, sans regroupement par thème |

Utiliser ce gabarit :

```
**<Titre de l'article>** (<Média>, <date>)

**L'essentiel** : <une phrase>

**Points clés**
- <point>
- <point>

**Nuances et réserves de l'auteur**
- <nuance>
```

- Le média et la date ne sont indiqués que s'ils figurent sur la page ; sinon, les omettre avec leurs parenthèses.
- Chaque point clé et chaque nuance tient en une seule phrase, avec une seule idée.
- N'inclure la section "Nuances et réserves de l'auteur" que si l'article en contient, avec trois nuances au maximum (les plus importantes). Ne jamais en inventer pour remplir la section.
- Si le plafond est atteint, retirer les points les moins importants plutôt qu'une nuance ou une réserve de l'auteur.
- Pour un résumé partiel, placer l'avertissement sur une ligne à part, juste après le titre.
