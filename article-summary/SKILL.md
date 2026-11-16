---
name: article-summary
description: Summarizes a press article faithfully, without interpretation, preserving the author's nuances and caveats. The article is either the page open in the browser (Claude for Chrome) or a link provided by the user. Use when the user asks to summarize an article, a news page or a link ("résume cet article", "fais-moi un résumé", "TL;DR", "summarize this article"), even without giving a URL.
---

# Article summary

Summarize a press article faithfully, without adding or interpreting anything, while keeping the nuances and caveats expressed by the author.

## Retrieving the article

1. **A link is provided.** Read the corresponding page, even if another tab is open in the browser.
2. **No link, but a browser is available** (Claude for Chrome). Read the content of the active tab's page: that is the article to summarize.
3. **The article text is pasted into the conversation.** Use it as is.
4. **None of the three cases.** Ask the user for the link or the text, without guessing which article is meant.

Only read the requested page: do not follow links to related articles.

## Checking the content read

- **The page is not an article** (home page, list of articles, search results, video without a transcript...): say so and ask the user which article to target, without producing a summary.
- **The article is incomplete** (paywall, subscribers only, partial loading): only summarize what was actually read and start the response with a warning stating that the summary is partial. If only the title and a standfirst are accessible, say so rather than summarizing an article that was not read. Do not try to bypass the paywall (archives, caches...), and never fill in the missing text with assumptions or outside knowledge.

## Faithfulness to the content

- Stay faithful to the article: no interpretation, no judgment, no personal conclusion.
- Add no outside information (context, fact-checking, own knowledge), even if the article seems wrong or incomplete.
- Distinguish reported facts, quotes and the author's opinions, and attribute each claim to its source ("according to...", "the author believes that...") rather than presenting it as a fact established by the summary.
- Preserve the author's important nuances and caveats: uncertainties, conditional statements, limitations, counter-arguments, opposing views reported. Never turn a hypothesis into a fact or erase a restriction.
- Reproduce the article's figures, dates and proper names exactly.
- Keep a neutral tone: do not add connotations absent from the original text.

## Output format

Write in the language of the user's request, even if the article is in another language (translate quotes). If the request has no identifiable language (bare link, "TL;DR"), use the language of the rest of the conversation, or failing that, the language of the article. Translate the template's headings into that language.

The summary never exceeds 250 words in total (title, key takeaway, key points and nuances included), whatever the length of the article. Adapt the number of key points to the size of the article (roughly estimated in words):

| Article | Key points |
|---|---|
| Brief (under 400 words) | Two points |
| Standard (400 to 2,000 words) | Three or four points |
| Long-form (over 2,000 words) | Five points at most, without grouping by theme |

Use this template:

```
**<Article title>** (<Outlet>, <date>)

**Key takeaway**: <one sentence>

**Key points**
- <point>
- <point>

**Author's nuances and caveats**
- <nuance>
```

- The outlet and the date are only given if they appear on the page; otherwise, omit them along with their parentheses.
- Each key point and each nuance fits in a single sentence, with a single idea.
- Only include the "Author's nuances and caveats" section if the article contains any, with three nuances at most (the most important ones). Never invent any to fill the section.
- If the limit is reached, remove the least important points rather than one of the author's nuances or caveats.
- For a partial summary, place the warning on a separate line, right after the title.
