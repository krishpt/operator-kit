---
name: new-idea
description: Master workflow for any new idea, startup or project the owner wants to start. Judges the idea, researches and installs the right skills, scaffolds the project with persistent context, and sets up evals and ROI tracking so the project is optimized from day one. Use whenever he says "I have an idea", "I want to start/build/launch X", or runs /new-idea.
---

# New idea -> optimized project

**Self-improving:** at the start, read `LEARNINGS.md` and apply every lesson. At the end of EVERY run, and at the end of any chat where a project's workflow went wrong or right (a bad estimate, a skill that did not help, a correction from the owner, a step that was skipped or wasted), append one row to LEARNINGS.md. When a lesson shows up twice, edit this SKILL.md to bake it in and remove the rows. Never store secrets or personal data in it.

Runs end to end without asking routine questions. Ask ONE question only if the idea is too ambiguous to judge. Default constraint (edit to taste): **no paid API keys or new recurring costs**; use `claude -p` / free tiers and flag any cost before incurring it.

## Phase 1: Judge (30 min of thinking, not a week)
Write `IDEA.md` in a new folder `<projects dir>/<slug>/` with a scorecard, each 1-5 with one line of evidence (use web-reach / Exa to check real demand, competitors, and what customers complain about; never guess):
1. Pain: is someone already paying or complaining about this?
2. Revenue path: who pays, how, how soon? 
3. Bottleneck fit: what single step gates the whole thing? (Find the one constraint that limits everything else; fixing anything else changes nothing.)
4. Cost to test: can the riskiest assumption be tested in 1 weekend for $0?
5. Edge: why the owner, why now?
Verdict: **BUILD / TEST FIRST / KILL**, with the single riskiest assumption named. Every claim needs a source or is labeled `ASSUMPTION`; no data = `no data found`, then research (see `operator-loop`). On KILL, stop, save the lesson to memory, and say why in 3 lines. On TEST FIRST, define the $0 test and run it before Phase 2.

## Phase 2: Research skills and tools
1. List the capabilities the project needs (research, scraping, docs, charts, deployment, testing, security).
2. Match against installed skills first (`ls ~/.claude/skills ~/.agents/skills`, plus the skill list in context). Use installed ones; do not duplicate.
3. For gaps: run `npx skills find <query>` (find-skills rules: prefer 1K+ installs and reputable sources, distrust <100 installs), then the `acquire-tools` skill for GitHub repos. Vet before install. Prefer writing a small project-specific skill over installing a vague one.
4. Record what was chosen and what was rejected (and why) in `IDEA.md`.

## Phase 3: Scaffold for the whole life of the project
Create, in the project folder:
- `CLAUDE.md`: first line = "Every session: read this file first, including 'Where we are'. After each task update 'Where we are'." Then: one-paragraph purpose, the scorecard verdict, the chosen skills/tools, rules (tests before commit, no paid APIs, revenue first), commands, and a **Where we are** section (done / todo / blockers).
- `git init`, `.gitignore`, a first commit; offline tests from the first feature (no untested logic).
- Graph: once there is code or docs, run `/graphify .` then `graphify claude install`; `graphify update .` after code changes.
- Evals: any AI-driven output gets a rubric-based eval run (see `docs/eval-hardening.md`: `--n 3` to iterate, `--n 9-10` to ship). Judge only listed criteria; show the judge the input; never show the generator the rubric.
- ROI ledger: record a baseline metric for the one number that proves the idea works (a plain JSONL ledger is enough), and the target.
- Memory: save one `project` memory (path, goal, how to resume) and add it to `MEMORY.md`.

## Phase 4: Optimize forward (run the `operator-loop` skill)
0. Write `BET.md` (frozen core, variables, metric, sample size, kill line) BEFORE building; add a `## Queue (FIFO)` to "Where we are". Never change the core until the sample size is reached.
1. Write a 3-milestone roadmap in `docs/ROADMAP.md`: each milestone has a $0 success test and a kill criterion.
2. Build the smallest vertical slice that touches the riskiest assumption first (Ponytail: least code that works).
3. Schedule recurring work only if it earns it (GitHub Actions cron + `claude -p`).
4. After every non-trivial change run the fresh-eyes review from `operator-loop` (independent sonnet subagent, loop until clean, max 3). At the end of every session: update "Where we are", `graphify update .`, and ask "what is the bottleneck now?" and record the answer.
5. Monthly (or after each milestone): re-run Phase 1 on the project itself. If the scorecard dropped, say so and recommend pivot or kill.

## Report (end of run, under 15 lines)
Verdict and why, riskiest assumption, skills installed/rejected, project path, the $0 test, and the first task started.
