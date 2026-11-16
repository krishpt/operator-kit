---
name: model-router
description: Pick the cheapest Claude model AND effort level that does a task well (haiku/sonnet/opus/fable; low/medium/high/xhigh/max), apply them to subagents, `claude -p` calls and evals, and tell the owner when the main chat should switch. Use before spawning any Agent, running batch or eval work, or whenever usage on the owner's plan matters. the owner has no paid API key, so every call draws on the owner's plan limit.
---

# Model + effort router

Usage on the owner's plan is the budget. Default to the cheapest tier that works; escalate only on evidence (a failed check, a wrong answer), never on vibes.

| Tier | Model | Use for |
|---|---|---|
| 1 | `haiku` | Bulk, mechanical, high-volume: file search, formatting, extraction, classification, simple graders, summarising logs |
| 2 | `sonnet` | Default workhorse: writing code, tests, edits, judges/graders with a rubric, research synthesis, doc drafting |
| 3 | `opus` | Hard reasoning: architecture, tricky debugging, security review, plans touching many files |
| 4 | `fable` | Highest-stakes or hardest: final review of a launch, decisions that are expensive to reverse, problems opus failed twice |

## Effort (second dial; set it with the model)
Effort is how hard the model thinks before answering. Higher = better on hard problems, slower, and burns the plan faster.
| Effort | Use for |
|---|---|
| `low` | Mechanical: search, formatting, extraction, renames, log summaries (pairs with haiku) |
| `medium` | **Default.** Most code, tests, reviews with a checklist, research synthesis, judgment calls (incl. Fable) |
| `high` | Hard debugging, security review, plans touching many files, a fix that failed once at medium |
| `xhigh` / `max` | Only when the owner asks, or a one-shot irreversible decision after `high` failed. Never by default. |
Rules: cheapest model first, then the lowest effort that works; escalate ONE dial one step on a failed check (effort before model when the model is right but sloppy; model before effort when it lacks the skill). Pass `effort` on every Agent call this skill routes (the Agent tool only takes effort when an instruction like this one asks for it).

## Switching the main chat
Claude cannot change its own chat model or effort; only the owner can (`/model`, `/effort`). When the next stretch of work clearly fits a different tier, Claude says so in one line with the exact command, e.g. "Next is routine edits: `/model sonnet` and `/effort medium` would save usage." Do this at natural breaks, not every turn; if the owner says usage is running low, recommend `sonnet` + `medium` and delegate heavy work to subagents at lower tiers.

## The kitchen brigade (who does what)
| Role | Model | Owns | Never does |
|---|---|---|---|
| Executive chef | `fable` | Ideas, the bet, kill/ship/pivot calls, final launch review, anything expensive to reverse, problems opus failed twice | Routine work |
| Chef de cuisine | `opus` | Architecture, plans, tricky debugging, security review, high-end judgment; writes the ticket the line cooks execute | Bulk typing |
| Line cook | `sonnet` | Default: code, tests, edits, skill drafts, rubric judges, research synthesis | Strategy calls |
| Prep cook | `haiku` | Mise en place: search, file triage, formatting, skimming, first-pass code review, log summaries, flagging what to escalate | Final verdicts, edits to shipped code |

Flow: **prep skims -> line cook cooks -> chef de cuisine reviews only what prep flagged or touches security/architecture -> exec chef sees only ship/kill/pivot decisions.** Work moves up one station only on a failed check or a flag, never by default. Tickets go down as a written spec (goal, files, done-check); results come back as a short report, not a transcript.
Importance test: reversible + cheap -> haiku/sonnet. Touches many files, security or money -> opus. Changes the bet or ships to a real customer -> fable.

## How to apply
- **Agent tool:** always pass `model` (Explore/search -> haiku; general work -> sonnet; Plan/review -> opus). Do not spawn agents when 2-3 direct tool calls do it.
- **`claude -p` / evals:** generation runs on the plan default or `CLAUDECODE_MODEL`; the judge runs on your judge-model setting (default `sonnet`). Iterate with `--n 3`; only the final ship run uses `--n 10`.
- **Fable budget:** Fable runs read-only judgment tasks at `effort: medium` with a strict scope and a short required output; never max effort or a build task unless the owner asks.
- **Escalate once:** if a tier-N result fails its check, retry one tier up, then stop and report. Never loop.
- **Down-shift:** after a plan is made on opus, hand execution to sonnet/haiku.
- **Batch and cache:** one call over many items beats many calls; do not re-ask what is already in context.
- **Report** model choice in one line when it was non-obvious ("graded on sonnet, final ship run on default").

## Learn
Append a row to `LEARNINGS.md` (see templates/) whenever a tier choice was wrong (too weak -> failed; too strong -> wasted usage), and tighten the table.
