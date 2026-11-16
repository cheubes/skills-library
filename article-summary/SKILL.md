---
name: article-summary
description: Summarizes a press article faithfully, without interpretation, preserving the author's nuances and caveats. The article is either the page open in the browser (Claude for Chrome) or a link provided by the user. Use when the user asks to summarize an article, a news page or a link ("résume cet article", "fais-moi un résumé", "TL;DR", "summarize this article"), even without giving a URL.
license: CC0-1.0
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

The size of the summary follows the content of the article, not a fixed format. A key point is a distinct claim, finding or argument of the article, not a piece of supporting evidence: figures, examples, studies and quotes that back the same claim go into the point they support and never make separate points. Before writing, identify the article's main claims and write one key point per claim: an article that develops a single thesis with many figures gets one or two points, whatever its length. The article's length (roughly estimated in words) only sets a ceiling:

| Article | Key points |
|---|---|
| Brief (under 600 words) | One to two points |
| Standard (600 to 2,000 words) | Two to four points |
| Long-form (over 2,000 words) | Three to seven points, without grouping several themes into one point |

These numbers are ceilings, not targets: never add a minor or redundant point to reach the maximum.

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
- Only include the "Author's nuances and caveats" section if the article contains any. A nuance qualifies or limits a claim of the article: uncertainty, condition, exception, limitation of a study or of the author's viewpoint, counter-argument or opposing view reported. A warning, a call to action or a projection that reinforces the main message is not a nuance: it belongs in the key points or is left out. List the significant nuances actually expressed in the article, up to three for a brief or standard article and five for a long-form one: a single nuance, or none at all, is normal. Never invent or stretch one to fill the section.
- For a partial summary, place the warning on a separate line, right after the title.
