---
name: operator-loop
description: Run any bet (a project, feature, experiment, outreach test) through a disciplined evidence loop - frozen bet, a metric/sample size/kill line written BEFORE running, one visible queue, independent fresh-eyes review, and mistakes turned into rules. Use when starting or reviewing a bet, when the owner is tempted to pivot, when a result needs an honest read, or after any non-trivial change. Adapted from nueramator/operator-framework (MIT, copy in source/).
---

# Operator loop (adapted for the owner)

Based on github.com/nueramator/operator-framework (MIT). See NOTICE.

## The eight rules, as enforced here
1. **One frozen bet.** Each project has a `BET.md` (template below). Core is frozen until the read is in. Only variables (wording, channel, rubric, input mix) get tuned.
2. **Evidence over opinion.** A decision needs a number with a source. No data = write `no data found`, then research (web-reach / Exa). Label every assumption `ASSUMPTION (confidence: low/med/high)`.
3. **Research operators, not spectators.** Prefer named people with results and primary sources; cite where each fact came from.
4. **One visible queue.** `## Queue (FIFO)` in the project's CLAUDE.md "Where we are". New ideas are appended, never swapped in. Only a correction to the task in hand jumps the line. Done = queue empty.
5. **Build to the level.** Name the level (throwaway / internal / client-facing) before building. Ponytail rules apply: the least code that answers the question.
6. **Beat the roadblock.** On a block, try 3 genuinely different routes (e.g. other tool, other source, local vs cloud) before reporting. Report as: tried X/Y/Z, why each failed, next lever. Never bulldoze safety limits, and never abandon the frozen bet just because the path is hard.
7. **Mistakes are system defects.** No apology, no blame. Name the missing rule, then append `date | project | gap | exact rule` to `LEARNINGS.md` (see templates/). A repeat means promote it into a skill's SKILL.md.
8. **Fresh eyes (agentic).** After any non-trivial change, spawn an independent low-context reviewer subagent (see below). Loop until a pass returns nothing.

## BET.md template (fill before running; do not run until Metric, Sample size, Kill line are filled)
```
BET: I believe ___ will ___ because ___.
CORE (frozen): ___            VARIABLES (tunable): ___
THE READ  Metric: ___  Sample size: ___  Kill line: ___   (mark each ASSUMPTION or sourced)
RUN       Started: ___  Variables changed: ___  Reached sample size? y/n
RESULT    Metric: ___  Verdict: hit | tune ONE variable | kill
NEXT MOVE (exactly one): ___
```
For skills, the read is your eval harness: metric = mean score, sample size = `--n 10` over >=3 varied inputs, kill line = pass mark / 90% pass rate.

## Fresh-eyes review (agentic, model-routed)
1. Give the reviewer ONLY the diff or output and the standard (rubric, ponytail-review checklist, or the BET read). No backstory.
2. Reviewer's job is strictly to find problems. Model: `sonnet` by default (`haiku` for typos/format, `opus` for security or architecture). One reviewer, not a swarm.
3. Fix findings, re-run the review. Stop when a pass is clean or after 3 loops (then report what is left; do not keep burning usage).
4. A reviewer that cannot be spawned (usage limit) means say so; do not self-certify as "reviewed".

## Decide (exactly one move)
Hit target -> scale / next rung. Missed but a variable was clearly off -> tune ONE variable, re-run. Missed at sample size with sound variables -> kill, then (only then) pick a new bet through `/new-idea`.
Never conclude before sample size. Never move the kill line after seeing results.

## Usage discipline
Default: no paid API keys. Iterate cheap (`--n 3`, haiku/sonnet), ship-read once (`--n 10`). Check model-router before spawning anything.
