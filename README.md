# operator-kit

A small set of [Claude Code](https://claude.com/claude-code) skills for running a project with evidence instead of vibes, and for not burning your plan on the wrong model.

Built on [nueramator/operator-framework](https://github.com/nueramator/operator-framework) (MIT). Start there for the original eight principles; this kit adapts them into Claude Code skills and adds a few things learned from using them on a real project.

## What's inside

| Skill | Does |
|---|---|
| `operator-loop` | Freeze one bet, write the metric, sample size and kill line *before* running, keep one queue, get an independent review, turn mistakes into rules |
| `model-router` | Picks the cheapest model that does the job. Uses a "kitchen brigade": biggest model for strategy and ship/kill calls, large for architecture and security, mid for most work, small for skimming and first-pass review |
| `new-idea` | Judges an idea (BUILD / TEST FIRST / KILL), picks tools, scaffolds a project with a CLAUDE.md that carries context between chats |

Plus `templates/` (BET.md, project CLAUDE.md, LEARNINGS.md), `prompts/external-audit.md` (a blunt outside review you can hand to a strong model), and `docs/eval-hardening.md`.

## What this adds to the original

- Packaged as Claude Code skills with a one-command install.
- Model routing by job importance, with a rule to move work up one tier only when a check fails.
- Eval-hardening rules from a real mistake: our scores were inflated because the model could see the grading rubric and a worked example, and the rubric was edited after failures. See `docs/eval-hardening.md`.
- A self-updating `LEARNINGS.md` loop and an external-audit prompt.

Not benchmarked against the original; these are working practices, not proven improvements.

## Install

```bash
git clone <this repo> && cd operator-kit && bash install.sh
```

Copies the skills into `~/.claude/skills/` (never overwrites an existing skill). Then in Claude Code: `/new-idea`, `/operator-loop`, `/model-router`.

## License

MIT. Upstream attribution in `NOTICE`.
