# Making an LLM eval trustworthy

Learned the hard way: a skill scored 8.67/10, then we found the score meant little.

1. **Never show the generator the rubric or a worked example.** If the prompt contains the answer key, you measure copying.
2. **Freeze the rubric before the run.** Editing it after a failure is tuning to the test. Only change it for a genuine contradiction with the skill, and then re-prove on a held-out case.
3. **Hold out cases** nobody tunes against; ideally real, anonymised inputs written by someone else.
4. **The judge sees the input** and grades only listed criteria, literally.
5. **Cheap judge to iterate, strong judge to ship.** A small model graded noticeably more leniently than a mid one.
6. **Deterministic checks first** (word count, required format, banned words). They cost nothing.
7. **Save every read** with the skill hash and models used, so a SHIP is auditable.
8. **>=3 varied cases**, and don't read much into n=9 (three cases x three repeats are correlated).
9. **An errored run is INCOMPLETE, not a failure.**
