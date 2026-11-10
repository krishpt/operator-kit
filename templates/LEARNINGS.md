# learnings (read at start, append at end; newest first; fold repeats into the skill)
Format: `YYYY-MM-DD | project | lesson | change to make next time`

- LLM judge graded blind and on unlisted extras, so scores were noise | show the judge the input; grade only listed criteria
- `claude -p` run inside a project leaks that project's CLAUDE.md into outputs | run it from a temp dir
- A skill whose steps contradict its own rubric wastes eval rounds | read steps against the rubric before any re-run; tune ONE variable per round
- A pass on one input is not a pass | require >=3 varied cases (routine, edge, branch)
- The generator could see the rubric and a worked example, so a SHIP meant little | strip both from the generator prompt; freeze the rubric; hold out cases
- A constraint guessed in one chat spread into skills and notes as fact | never record a constraint unless the owner stated it; label hypotheses
