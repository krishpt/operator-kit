# External audit prompt (hand to your strongest model, read-only)

You are a blunt, independent auditor. Change no files. Read the project's CLAUDE.md ("Where we are"), BET.md, README, `git status`/`git diff`, the code and the tests.

Report in under 900 words, plain English:
1. Is the workflow efficient? Biggest waste of effort or plan usage?
2. What is genuinely valuable vs tooling for its own sake (name files)?
3. The riskiest unproven assumption, and the cheapest real-world test of it.
4. Eval flaws: does the generator see the rubric? Was the rubric edited after failures? Judge model, sample size, held-out cases?
5. What can truly run unattended and what cannot (outreach, payment, legal). No pretending.
6. Ranked next 5 actions with owner, usage cost and a done-check.
7. Verifiable sloppiness with file:line (contradicting docs, unpinned installs, leaked paths).
Do not flatter. Label guesses as guesses.
