# Changelog

## 1.1.1 — 2026-10-06

Consistency fixes so the measurement skills give one answer.

- **Measuring a change:** `measurement-discipline` and `ctr-snippet-optimization` now state the same plain rule. Compare changed pages with similar pages you left alone, chosen the same way, over the same dates. Use equal whole-week windows before and after, and wait for Google to recrawl first (Google says this takes days to weeks). Make no second change to a page while its window is open. Show the result as a range, and say "too little data to call" when a small site cannot show a difference.
- **Pilots:** pick pilot pages at random, or take half of a worst-first list and leave the other half untouched. Picking the worst pages and comparing them with the rest makes them look like a win when they would have recovered anyway. A pilot of about five pages is too small to call: report the raw before and after counts only.
- **Revert rule:** a position drop can stop a "keep", but it no longer triggers a revert by itself.
- **Impressions logging error (13 May 2025 to 27 April 2026):** skills now say impressions, CTR and position are inaccurate in that "affected window" (clicks were not affected), instead of calling them provisional.
- **Monitoring:** a segment with very few clicks raises no alert, and a Critical pattern in a thin segment is capped at Warning and written in counts. While a Critical or Warning alert is open, hold new page edits and new pages so they do not blur the diagnosis.
- **Near-miss and click-through hand-off:** the rule for which skill takes a page now covers every case ("otherwise it is an opportunity item"), and a page's click-through gap is not counted twice.
- **Housekeeping:** two shared starting numbers were defined in two skills; each now has one owner.

## 1.1.0 — 2026-10-05

Corrections and sharper rules in 13 of the 20 skills, after re-checking every Google-specific statement against Google's own documentation (checked 2026-10-05).

- **Titles and meta descriptions:** removed the pixel-width and character limits. Google documents no limit; titles are shortened to fit the device width. Softened heading rules that Google does not state (exactly one H1, no skipped levels).
- **Monitoring and alerts:** the alert tiers no longer leave gaps, a minimum-traffic guard stops small segments raising false alarms, and alerts have open and close rules. Indexed counts are now read from Search Console or supplied by you, because no public API provides them.
- **Duplicate intent:** reframed. Same-intent overlap is a quality and possible-overlap concern, not automatically spam, and Google has said there is no "duplicate content penalty".
- **Indexing:** corrected what "Discovered - currently not indexed" and "Crawled - currently not indexed" mean, and what Google does when robots.txt returns a server error.
- **Traffic drops:** Google's actual advice after an update (wait a full week after the rollout finishes; avoid drastic changes after a small drop). Added AI answer surface expansion as an unproven possible cause, never a stated one.
- **Click-through:** one rule for queries at positions about 8 to 15 so two skills no longer both claim them; AI-exposure labels; build click-through curves only from days after 27 April 2026.
- **Search Console data:** documented the impressions logging error (13 May 2025 to 27 April 2026; clicks were not affected) and other logged anomalies.
- Numbers that are not Google's are now collected in a Defaults table in each skill and labelled as starting points to calibrate on your own data.

## 1.0.0 — 2026-10-01

First public release: 20 skills, a getting-started guide for you, and a hand-off guide for your AI agent.
Licensed MIT.
