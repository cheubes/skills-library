---
name: restaurant-finder
description: Searches the web for restaurants in a given area and returns a Markdown list with cuisine type, price range, address with a Google Maps link, website, Google and TripAdvisor ratings, and opening hours. Use when the user asks to find restaurants, wants recommendations, or is looking for places to eat in a city, neighborhood or region.
---

# Restaurant finder

Search for restaurants matching the user's request and present them as a structured Markdown list.

## Analyzing the request

1. **The geographic area is mandatory.** If the request does not specify one (city, neighborhood, address, region), ask the user before starting the search; never guess or apply a default area. If an area is specified but its boundaries cannot be verified through web search (poorly documented neighborhood, city with little online coverage, boundaries not found...), do not guess an approximate proximity: tell the user and ask them to clarify the area, offering concrete suggestions (for example a wider area, a better documented landmark) as well as a free-text option.
2. **Number of results.** Ten by default. If the user specifies another number, use it instead. If fewer matching restaurants exist, only return those actually found rather than artificially padding the list.
3. **Other criteria.** Treat any additional criterion mentioned in the request (cuisine type, price range, atmosphere, dietary constraints, "open now", etc.) as a search filter on top of the area.

## Search

Use web search and page browsing to identify candidate restaurants and their information, from sources such as Google Maps, TripAdvisor and the restaurants' own websites. For each candidate, try to collect:

- Name
- Cuisine type
- Price range, expressed with € symbols: `€` up to €15 per person, `€€` from €15 to €30, `€€€` from €30 to €60, `€€€€` above €60
- Full address, and a Google Maps share link (short `maps.app.goo.gl` format). If no such link can be found anywhere, use a regular Google Maps search link to the restaurant instead. This link must never contain an `authuser` parameter (it identifies a specific Google account): remove it from the URL if present.
- Official website, if one exists
- Google rating (out of 5), its number of reviews, and a link to the Google listing
- TripAdvisor rating (out of 5), its number of reviews, and a link to the TripAdvisor listing
- Opening hours

Prioritize primary sources for each piece of information, in this order: (1) the restaurant's official website, (2) Google, (3) TripAdvisor. Only fall back on third-party aggregator sites as a last resort, if the information cannot be found on these three primary sources. If they contradict each other (for example, different opening hours), keep the one from the highest ranked source in this order rather than marking the information `Not available`.

Before keeping information from an external listing (TripAdvisor, aggregator, website...), check that the address shown on that listing matches the candidate's address. Several restaurants can share the same name in different cities or neighborhoods, or even have several separate listings for the same brand: never associate the first result found for a given name by default without confirming the address.

Exception for the Google rating: Google Maps is in practice impossible to browse directly (systematic consent wall, even on a specific listing). For this field only, actively look for the figure republished by several aggregator sites (for example restaurantguru.com, justacote.com, pagesjaunes.fr, rankeat.fr, TheFork) before concluding that the data is missing. Keep the figure if at least two aggregators corroborate it; if aggregators give different figures, keep the most recent one. The associated link remains a link to the restaurant's Google Maps listing or search, never to the aggregator. Only write `Not available` if none of the aggregators consulted mentions both a Google rating and a number of reviews.

Exclude any restaurant identified as permanently closed in the sources consulted.

Write the whole response, including all the collected information, in the language of the user's request, even when the original source is in another language (for example, translate the cuisine type or the opening hours). Follow that language's conventions for numbers and hours.

Never invent or guess a restaurant or any of its information. Only include what was actually found through the search. If no restaurant matches the requested area and criteria, tell the user clearly rather than returning an empty list without explanation.

## Ranking

Discard any restaurant with a known rating (Google or TripAdvisor) strictly below 4/5, even if it otherwise matches the requested area and criteria. This exclusion only applies to ratings actually found; a rating marked `Not available` does not lead to exclusion on its own.

When more candidates are found than needed, prioritize restaurants that have both a good rating and a substantial number of reviews: a near-perfect rating based on a handful of reviews must not rank above a slightly lower rating backed by hundreds or thousands of reviews. When both Google and TripAdvisor data are available, use the Google rating and number of reviews as the main signal.

## Output format

Present each restaurant with this exact template, with real Markdown links (`[text](url)`) wherever a link is required. Separate entries with a blank line. If a specific piece of information cannot be found, write `Not available` in its place rather than omitting the field. Translate `Not available` and the word "reviews" into the response language.

```
### <Restaurant name>
🍽️ <Cuisine type> - 🧾 <Price range>
📍 [<Address>](<Google Maps share link>) - 🌐 [<Website label>](<Website link>)
🗺️ [<Google rating>/5 (<Number of Google reviews> reviews)](<Google Maps share link>) | 🦉 [<TripAdvisor rating>/5 (<Number of TripAdvisor reviews> reviews)](<TripAdvisor listing link>)
🕐 <Opening hours>
```

Example (request in French):

```
### La Pie Noir
🍽️ Cuisine française (inspiration bretonne) - 🧾 €€€
📍 [5 rue de la Montagne Sainte-Geneviève, 75005 Paris](https://maps.app.goo.gl/96M5mWLpcFD4fGPA9) - 🌐 [lapienoir.com](https://lapienoir.com/)
🗺️ [4,8/5 (2 005 avis)](https://maps.app.goo.gl/96M5mWLpcFD4fGPA9) | 🦉 [4,7/5 (687 avis)](https://www.tripadvisor.com/Restaurant_Review-g187147-d12182791-Reviews-Restaurant_La_Pie_Noir-Paris_Ile_de_France.html)
🕐 Mar-sam 12h-14h45, 18h30-00h ; dimanche et lundi fermé
```
