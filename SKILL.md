---
name: adb
description: "Ask. Decide. Build. Define and build a software product with a lightweight discovery-first method using native agents. Use only when the project's METHOD.md says METHOD: ADB; never combine it with BMAD."
---

# ADB

ADB means Ask. Decide. Build.

This file is the canonical ADB source. Project setup copies it to the repository root as `ADB.md` so the method remains readable by any capable AI coding harness, not only one vendor's skill loader.

ADB is a lightweight product-definition and software-engineering method for modern AI coding environments with autonomous tools, subagents and parallel workers.

ADB is not an agent framework.

ADB does not prescribe a fixed organization of artificial roles.

ADB does not build a custom orchestrator.

ADB uses the native capabilities of the active coding environment.

ADB inherits the project's `AGENTS.md`, including Offensive on Outcome and Defensive on Implementation.

The objective is:

Understand the intended product completely enough to build confidently, preserve that understanding as a durable Source of Truth, then execute aggressively toward an exceptional product while minimizing unjustified code and complexity.

The core principles are:

OFFENSIVE ON OUTCOME.

DEFENSIVE ON IMPLEMENTATION.

PARALLELIZE WHERE SAFE. SERIALIZE WHERE DEPENDENCIES REQUIRE IT.

SPECIFICATION BEFORE SCALE.

SECRETS NEVER ENTER THE REPOSITORY OR PERSISTENT ADB FILES.

Secrets, API keys, passwords and credentials must never enter the codebase or persistent ADB files. Use environment variables or a secret store exclusively. `.env.example` may exist only without real values.

Read every point. Each point is a rule to judge this product against, not a task that must produce extra files, agents or process.

If a point does not apply, extra work is forbidden. Do not create files, agents, slices, reviews or process merely to show that the point was visited. A small product must not receive the machinery of a large high-integrity product. Point 60 sets the depth of every other point.

⸻

## 1. ACTIVATION

ADB must not automatically affect ordinary work in unrelated existing projects.

ADB activates when:

* the project's `METHOD.md` contains `METHOD: ADB`
* the user explicitly invokes /adb
* the user explicitly asks to use ADB
* a new or essentially empty project is opened and the user clearly asks to create a new application or software product

For an existing application, ADB activates only when explicitly requested.

Examples:

/adb

Use ADB on this project.

Finish this application using ADB.

Once ADB is activated for a project, its ADB Source of Truth governs future ADB work in that project.

⸻

## 2. PROJECT MODE

Determine the project mode first.

GREENFIELD

No meaningful application exists yet.

Start with DEFINE.

BROWNFIELD

A meaningful application already exists.

Before changing code, inspect and reverse-engineer the current application.

Determine:

* what exists
* what works
* what is incomplete
* what is incorrect
* what is unclear
* what should be preserved
* what the user actually intends the product to become

Existing code is evidence.

Existing code is not automatically the truth.

⸻

## 3. TWO PRIMARY PHASES

ADB has only two primary phases:

DEFINE

Understand the product and create the Source of Truth.

BUILD

Execute the defined product.

Avoid unnecessary process layers.

Supporting activities such as research, planning, testing, reviewing and issue tracking exist inside these two phases.

⸻

# PHASE 1 — DEFINE

## 4. DEFINE OBJECTIVE

Do not begin substantial product implementation during DEFINE.

The completion criterion is:

A fresh capable engineering agent should be able to understand and build the product from the ADB Source of Truth without needing the interview history and without inventing important product behavior.

The product understanding may come from:

* the user
* the existing repository
* existing documentation
* research
* data
* tests
* external systems

ADB must combine them.

⸻

## 5. GRILL THE PRODUCT, NOT THE USER

Discovery is a living decision tree, not a questionnaire.

Ask only questions that reduce meaningful uncertainty.

Every useful answer should:

* close an uncertainty
* expose a dependency
* reveal a conflict
* create a better question
* eliminate alternatives
* trigger research
* affect another decision

There is no target number of questions.

Ask as many as necessary and no more.

Never manufacture questions to appear thorough.

⸻

## 6. ONE MEANINGFUL DECISION AT A TIME

For important topics, prefer one question or one closely connected decision group at a time.

Preferred loop:

QUESTION
→ ANSWER
→ INSPECT
→ RESEARCH IF USEFUL
→ UPDATE UNDERSTANDING
→ UPDATE SOURCE OF TRUTH
→ NEXT BEST QUESTION

Do not dump large questionnaires on the user unless the user explicitly requests batch questions.

⸻

## 7. DO NOT ASK WHAT CAN BE DISCOVERED

Before asking, determine whether the answer can be obtained reliably from:

* repository inspection
* documentation
* configuration
* tests
* existing data
* official documentation
* platform conventions
* research
* available tools

If yes, investigate it.

Ask the user where intent matters:

* desired behavior
* Business Rules
* priorities
* workflow
* product preference
* meaningful UX decisions
* important trade-offs
* irreversible decisions

⸻

## 8. RESEARCH IS PART OF DEFINE

Research whenever it can materially improve product quality or the quality of the next decision.

Possible research:

* comparable products
* competitors
* excellent UX references
* interaction patterns
* accessibility
* visual patterns
* open-source implementations
* official documentation
* architecture alternatives
* frameworks
* libraries
* databases
* hosting
* APIs
* security
* performance
* relevant standards

Research is not performed for ceremony.

Research should:

* answer questions
* eliminate bad options
* expose risks
* create better recommendations
* create better follow-up questions

⸻

## 9. USE PARALLEL RESEARCH

When independent research questions exist, use available subagents or parallel workers.

Example:

* Agent A researches comparable products
* Agent B inspects the existing repository
* Agent C investigates technical options
* Agent D examines UX patterns

Parallelize only independent work.

Do not parallelize decisions where one answer materially changes what another agent should investigate.

The lead agent integrates results.

⸻

## 10. QUESTIONS SHOULD INCLUDE GOOD ANSWERS

Important questions should usually provide a small number of meaningful options.

Do not force the user to invent technical, UX or design solutions from scratch.

Before asking:

1. understand current context
2. research if valuable
3. identify sensible choices
4. remove clearly inferior choices
5. recommend the strongest choice

Preferred format:

Decision

A — Option

Short explanation.

B — Option

Short explanation.

C — Option

Short explanation.

RECOMMENDATION: B

WHY:
Short contextual reasoning.

ANSWER: A / B / C / Other / Decide for me

Normally offer 2–4 serious options.

Do not create fake alternatives merely to provide choice.

⸻

## 11. “DECIDE FOR ME”

The user may answer:

* Decide for me
* You choose
* I don’t know

This is valid.

ADB then chooses based on:

* Product Vision
* previous answers
* research
* simplicity
* usability
* quality
* maintainability
* risk
* lowest justified complexity

Meaningful autonomous decisions must be recorded in 06-DECISIONS.md.

⸻

## 12. CHALLENGE BAD DECISIONS

The user remains the final product owner.

ADB must nevertheless challenge choices that appear likely to cause:

* poor usability
* avoidable complexity
* security problems
* data-integrity risk
* architectural damage
* inconsistency
* conflict with the established product

Explain:

* the concern
* consequence
* recommended alternative

Do not be argumentative about subjective preferences.

Challenge when consequences are meaningful.

⸻

## 13. UX AND DESIGN RESPONSIBILITY

If the user knows WHAT the application should do but not HOW it should look or behave, ADB takes more responsibility.

Research strong references.

Recommend a coherent direction.

Aim for:

* beauty
* clarity
* hierarchy
* understandable workflows
* strong typography
* intentional spacing
* consistent components
* restrained visual language
* appropriate animation
* feedback
* accessibility
* responsive behavior
* excellent empty/loading/error states

Do not produce generic AI-looking interfaces.

Do not confuse decoration with quality.

⸻

## 14. UNCERTAINTY STATES

Reason about important information as:

* KNOWN
* UNKNOWN
* ASSUMED
* CONFLICTING
* NEEDS RESEARCH
* NEEDS USER DECISION

Never silently convert an assumption into product truth.

⸻

## 15. SOURCE OF TRUTH

ADB maintains:

adb/01-VISION.md

adb/02-PRODUCT-SPEC.md

adb/03-UX-DESIGN.md

adb/04-ARCHITECTURE.md

adb/05-QUALITY.md

adb/06-DECISIONS.md

adb/07-STATUS.md

adb/08-OPEN-ISSUES.md

Do not create more permanent documentation without concrete value.

⸻

## 16. 01-VISION.md

Keep short and stable.

Define:

* what the product is
* why it exists
* who it serves
* core problem
* desired experience
* core principles
* non-negotiable qualities
* what the product intentionally is not

⸻

## 17. 02-PRODUCT-SPEC.md

This is the primary behavioral truth.

Include when relevant:

* features
* user roles
* permissions
* workflows
* Business Rules
* states
* state transitions
* calculations
* data behavior
* integrations
* notifications
* payments
* administration
* errors
* edge cases
* exceptional conditions
* important examples
* expected observable behavior

Prefer explicit behavior over vague requirements.

⸻

## 18. 03-UX-DESIGN.md

Include useful decisions about:

* information architecture
* navigation
* user journeys
* screens
* important screen states
* interaction patterns
* visual hierarchy
* typography
* spacing
* component language
* motion
* responsive behavior
* accessibility
* loading states
* empty states
* error states
* feedback

⸻

## 19. 04-ARCHITECTURE.md

Document only architecture that matters.

Include when relevant:

* technology choices
* application structure
* major boundaries
* data model
* APIs
* authentication
* authorization
* storage
* integrations
* deployment
* important security decisions
* significant constraints

Document WHY for consequential decisions.

Do not create architecture for hypothetical future requirements.

⸻

## 20. 05-QUALITY.md

Define what DONE means for this product.

Depending on risk:

* Unit Tests
* Integration Tests
* E2E
* security
* performance
* accessibility
* responsive behavior
* error handling
* logging
* monitoring
* migrations
* backups
* recovery
* deployment
* production readiness

Do not enforce meaningless gates.

⸻

## 21. 06-DECISIONS.md

Preserve important WHY.

For meaningful decisions record:

* decision
* reason
* alternatives if relevant
* consequence

Avoid logging trivial implementation details.

⸻

## 22. 07-STATUS.md

Keep concise.

Track:

* current phase
* completed
* current
* remaining
* blockers
* next important action
* number of open issues
* critical/high issue count

⸻

## 23. 08-OPEN-ISSUES.md

All meaningful unresolved problems discovered during work must be persisted here.

Examples:

* bugs
* regressions
* missing required behavior
* UX problems
* design inconsistency
* architecture issues
* security concerns
* data-integrity problems
* failing or missing critical tests
* performance problems
* accessibility problems
* migration risks
* specification conflicts
* concrete technical debt
* suspicious behavior requiring investigation

Do not trust chat memory.

If you are not sure whether something is wrong, unused, contradictory, or still needed, register it. Do not skip it in silence. Do not invent a product decision. The user should be able to see it later and work it separately.

If the problem matters and remains unresolved, register it.

⸻

## 24. DO NOT POLLUTE OPEN ISSUES

Do not register:

* vague ideas
* theoretical improvements
* speculative features
* hypothetical refactors
* “maybe useful someday”
* coding-style preferences without product impact

Uncertainty is not pollution. A possible bug, unused path, contradiction, or missing decision is a concrete risk. A wish for a new feature that is not a current problem is pollution.

Open Issues tracks concrete problems and risks.

⸻

## 25. ISSUE FORMAT

Use stable IDs:

ISSUE-001

Each issue contains:

* TITLE
* TYPE
* SEVERITY
* FOUND BY
* CONTEXT
* PROBLEM
* EVIDENCE
* EXPECTED
* STATUS
* DEPENDENCIES
* RESOLUTION
* VERIFIED BY

Types may include:

* BUG
* PRODUCT
* UX
* DESIGN
* ARCHITECTURE
* SECURITY
* DATA
* TEST
* PERFORMANCE
* ACCESSIBILITY
* MIGRATION
* SPEC-CONFLICT
* TECH-DEBT
* INVESTIGATION

Statuses:

* OPEN
* IN PROGRESS
* BLOCKED
* READY FOR VERIFY
* CLOSED

Severity:

* CRITICAL
* HIGH
* MEDIUM
* LOW

⸻

## 26. DEFINE COMPLETENESS GATE

Before entering BUILD ask:

Could a fresh capable engineering team understand what to build from these files without the interview history and without inventing important product decisions?

Verify:

* purpose clear
* users clear
* important workflows clear
* Business Rules clear
* states clear
* important edge cases covered
* UX direction clear
* visual direction clear
* architecture sufficient
* quality bar clear
* significant conflicts resolved

Do not seek theoretical perfection.

Reversible low-risk implementation details may remain open.

⸻

## 27. USER BUILD APPROVAL

When DEFINE is complete, summarize briefly:

* product
* core principles
* major workflows
* UX/design direction
* architecture direction
* significant risks

Ask once:

ADB DEFINE is complete. Start BUILD?

Do not require repeated approvals during routine execution.

⸻

# PHASE 2 — BUILD

## 28. BUILD BEHAVIOR

Once BUILD starts:

Stop behaving primarily as an interviewer.

Work autonomously on reversible implementation decisions.

The Source of Truth now governs work.

⸻

## 29. OFFENSIVE ON OUTCOME

Spend effort aggressively where it improves the actual product.

“Works” is not equivalent to “finished.”

Aim for exceptional:

* functionality
* visual quality
* usability
* understandability
* interaction
* responsiveness
* accessibility
* performance
* reliability
* error handling
* edge-case handling
* consistency
* polish
* production readiness

If building Snake, do not stop when the mechanics function.

The finished experience should have deliberate:

* visual identity
* typography
* spacing
* motion
* controls
* start state
* pause state
* game-over state
* feedback
* responsive behavior

No effort should be saved when that effort creates meaningful user-facing value.

⸻

## 30. DEFENSIVE ON IMPLEMENTATION

Achieve that result with the smallest justified technical system.

This does NOT mean minimum characters.

It means:

Maximum product value per justified line of code, dependency and technical concept.

Every:

* file
* line
* dependency
* abstraction
* configuration
* service
* API
* database table
* background job
* infrastructure component

must justify itself.

Do not add things because:

* they may be useful later
* they make the system look sophisticated
* enterprise projects often have them
* they create theoretical flexibility

No speculative features.

No speculative architecture.

No speculative abstractions.

No premature future-proofing.

⸻

## 31. SIMPLICITY CHECK

Before adding meaningful implementation complexity ask:

1. Does this satisfy a real requirement?
2. Does this provide meaningful quality, reliability or maintainability?
3. Is there a simpler solution?
4. Does an existing capability already solve it?
5. Is this flexibility actually required?
6. Is this abstraction necessary now?
7. Can this use fewer moving parts?

⸻

## 32. MULTI-AGENT IS AN EXECUTION CAPABILITY

ADB assumes modern coding environments may provide multiple agents.

ADB does not prescribe fixed agent names.

The lead agent dynamically chooses:

* number of agents
* tasks
* degree of parallelism
* context passed to each
* when independent review is useful

Agent count follows the work.

The work does not exist to justify agent count.

Prefer subagents for bounded work such as research, a slice, tests or review. The lead agent stays the integrator: it talks to the user, holds the Source of Truth, and merges results. This keeps the main-thread context small so the lead agent does not get lost. Do not spawn agents for ceremony or fake roles.

⸻

## 33. WHEN TO PARALLELIZE

Parallelize tasks when they are genuinely independent or safely isolated.

Good examples:

* independent research topics
* independent components with stable interfaces
* separate test work
* visual review
* security review
* code review
* analysis of independent modules

Do not parallelize tightly coupled implementation where agents are likely to:

* modify the same code
* make conflicting architectural decisions
* depend on unfinished work
* create integration churn

⸻

## 34. LARGE APP EXECUTION PLAN

Never build a large application as one uninterrupted task.

Before substantial BUILD:

derive a dependency-aware execution plan from the Source of Truth.

Organize work into small vertical slices that create meaningful integrated product capability.

Prefer:

User-visible capability

* necessary backend
* data
* tests

over enormous horizontal phases such as:

“Build entire backend first.”

⸻

## 35. SLICE GRAPH

Determine dependencies between slices.

Example:

Slice 1 ─┐
├→ Slice 4
Slice 2 ─┘

Slice 3 ─────────→ Slice 5

Independent slices may run in parallel.

Dependent slices wait for prerequisites.

ADB should maximize safe parallelism without creating integration chaos.

⸻

## 36. SLICE LOOP

Every meaningful slice follows:

SPEC
↓
PLAN
↓
IMPLEMENT
↓
TEST
↓
REVIEW
↓
SPEC CHECK
↓
ISSUE TRIAGE
↓
VERIFY
↓
INTEGRATE

Only then is the slice complete.

⸻

## 37. SMALL VERIFIABLE TASKS

For substantial implementation, use small verifiable tasks.

Each task should have:

* clear objective
* relevant specification
* expected behavior
* bounded scope
* verification method

Do not accumulate large quantities of unreviewed code.

⸻

## 38. SUBAGENT CONTEXT

Subagents receive the minimum sufficient context.

A Builder may receive:

* relevant Product Spec
* relevant UX
* relevant Architecture
* task objective
* related code

A Reviewer may receive:

* relevant specification
* expected behavior
* diff
* test evidence

Do not automatically send the entire project history.

⸻

## 39. INDEPENDENT REVIEW

For meaningful work, independent review is preferred when the environment supports it.

The agent that writes the implementation should not be the only authority deciding whether it is correct.

Review may include:

* product compliance
* UX/design
* engineering quality
* complexity
* tests
* security

The scale of review should match risk.

⸻

## 40. CODE DEFENSIVELY

When modifying existing code, prefer the smallest safe change that fully solves the requirement.

Do not:

* refactor unrelated code
* rename unrelated structures
* rewrite working components for stylistic preference
* introduce patterns without demonstrated need
* add unused configuration
* add unused dependencies
* create generic helpers for hypothetical future use

⸻

## 41. DELETE UNNECESSARY COMPLEXITY

When safe, remove:

* dead code
* unused functions
* obsolete implementations
* unnecessary abstractions
* unused dependencies
* superseded workarounds

Less code is good when behavior, clarity and safety remain intact.

⸻

## 42. DEPENDENCIES

Minimize total complexity, not blindly package count.

Use mature dependencies when they solve difficult problems more reliably and simply than custom implementation.

Do not use large dependencies for trivial problems.

Do not reinvent security-sensitive standards merely to avoid dependencies.

⸻

## 43. TEST VALUABLE BEHAVIOR

Prioritize tests for:

* Business Rules
* calculations
* state transitions
* critical workflows
* permissions
* integration boundaries
* regressions
* high-risk edge cases

Use E2E testing for important user journeys where appropriate.

Do not inflate test volume simply to raise coverage.

⸻

## 44. REVIEW DIMENSIONS

When relevant review:

PRODUCT

Does implementation match 02-PRODUCT-SPEC.md?

UX

Is it understandable and efficient?

DESIGN

Does the real output match 03-UX-DESIGN.md?

ENGINEERING

Is the implementation correct and maintainable?

COMPLEXITY

Did unnecessary code or architecture enter the system?

QUALITY

Does it satisfy 05-QUALITY.md?

SECURITY

Are meaningful risks handled?

⸻

## 45. SPEC-COMPLIANCE GATE

Green tests are not enough.

Before significant work is complete compare implementation against:

* 01-VISION.md
* 02-PRODUCT-SPEC.md
* 03-UX-DESIGN.md
* 04-ARCHITECTURE.md
* 05-QUALITY.md
* 06-DECISIONS.md

If implementation differs:

determine whether:

A. implementation is wrong

or

B. product intent intentionally changed.

Never silently choose B.

If required behavior is missing, do not stop at noticing it. Fix it now when it belongs in the current slice. Otherwise register the missing work in 08-OPEN-ISSUES.md. Do not continue as if the spec were satisfied.

⸻

## 46. ISSUE DISCOVERY RULE

Every agent is responsible for noticing problems outside its immediate task.

If discovered:

FIX NOW

if it:

* directly affects current scope
* is safe
* is small
* should logically be resolved with the current work

or:

REGISTER

in 08-OPEN-ISSUES.md

if it:

* is outside scope
* requires separate investigation
* depends on other work
* requires user decision
* would create harmful context switching
* is a meaningful risk
* is something the agent is not sure is wrong, unused, contradictory, or still needed

Never silently ignore it.

If unsure: register it. Do not skip it. Do not invent a fix. Do not wait for a later chat to remember it.

⸻

## 47. ISSUE CLOSURE LOOP

Issues follow:

DISCOVER
↓
REGISTER
↓
TRIAGE
↓
SELECT
↓
FIX
↓
TEST
↓
REVIEW
↓
VERIFY
↓
CLOSE

Do not mark CLOSED because code changed.

Verification is required.

⸻

## 48. TRIAGE

At natural checkpoints review Open Issues.

Prioritize by:

1. severity
2. product impact
3. security/data risk
4. blockers
5. regression risk
6. dependency order
7. cost of postponing

Do not interrupt every task immediately for every new issue.

⸻

## 49. NO FAKE CLOSURE

Never close an issue by:

* deleting it
* lowering severity to finish
* changing wording
* marking it CLOSED without verification

Closed items remain traceable.

⸻

## 50. RELEASE ISSUE GATE

ADB must not declare the product complete while:

* CRITICAL issues remain
* HIGH issues violate 05-QUALITY.md
* required product behavior is broken
* unresolved Source-of-Truth conflicts remain

MEDIUM/LOW issues may remain only when they are acceptable within the documented release quality bar.

⸻

## 51. BROWNFIELD EXECUTION

When ADB is activated on an existing project, first inspect:

* product behavior
* Business Rules
* architecture
* data
* integrations
* UX
* design
* tests
* deployment
* known problems

Classify major areas:

* KEEP
* IMPROVE
* REFACTOR
* REPLACE
* REMOVE
* MISSING
* UNCLEAR

Preserve good working code.

Do not rewrite for style.

Then grill the user until intended state is clear.

⸻

## 52. GAP ANALYSIS

For Brownfield compare:

CURRENT STATE
vs.
INTENDED STATE

Plan only the required gap.

Avoid rebuilding correct functionality.

Avoid preserving incorrect functionality merely because it already exists.

⸻

## 53. MIGRATIONS

For platform or technology migration:

do not mechanically translate old code.

First extract technology-independent:

* Business Rules
* business logic
* calculations
* workflows
* data relationships
* integrations
* external dependencies

Then choose the simplest appropriate target architecture.

⸻

## 54. HIGH-INTEGRITY SYSTEMS

For accounting, financial, payment or other high-integrity systems, defensive implementation becomes stricter.

Where relevant verify:

* calculations
* taxes
* rounding
* totals
* transaction integrity
* duplicate prevention
* permissions
* auditability
* migration accuracy
* backups
* recovery

Compare old and new results using controlled or historical data when appropriate.

Never sacrifice correctness merely to reduce code volume.

Never silently change existing persisted data models or database schemas. Schema changes require an explicit migration spec and user awareness. Existing production data integrity is non-negotiable.

⸻

## 55. CHANGE CONTROL

For later requirements classify:

A — IMPLEMENTATION FIX

Spec remains correct.

Implementation is wrong.

Proceed.

B — COMPATIBLE EXTENSION

Fits existing product and architecture.

Proceed when sufficiently clear.

C — PRODUCT SPEC CHANGE

Update Source of Truth.

D — UX / DESIGN CHANGE

Update relevant UX/design truth.

E — ARCHITECTURE CHANGE

Assess impact and update Architecture.

F — VISION CHANGE

Explain the conflict before implementation.

Update higher-level Source of Truth first.

After a later product change, update the affected Source of Truth files before the work is complete. Do not leave the spec describing an older product than the code.

⸻

## 56. PREVENT PRODUCT DRIFT

Many small changes can destroy coherence.

Before meaningful changes check:

* Vision
* Product Spec
* Business Rules
* UX
* Design
* Architecture
* Quality
* important Decisions

Do not let accidental implementation become new product truth.

⸻

## 57. AUTONOMY

After DEFINE, maximize useful autonomy.

Do not interrupt the user for:

* routine coding choices
* obvious implementation details
* reversible low-risk decisions
* issues resolvable through research
* issues resolvable through tests

Ask when:

* genuine product ambiguity exists
* trade-offs materially alter the product
* established intent conflicts with the request
* a high-risk irreversible decision exists
* external authorization, credentials or spending is required

⸻

## 58. TOKEN DISCIPLINE

Spend tokens offensively where they improve:

* product understanding
* research
* UX/design decisions
* architecture decisions
* difficult debugging
* testing
* security
* independent review

Spend tokens defensively on:

* repeated summaries
* ceremonial planning
* redundant documentation
* reloading irrelevant context
* artificial agent roles
* repeated explanations of known facts

Use the smallest sufficient context for each agent.

When switching from DEFINE to BUILD, or between major slices, reload from the eight Source of Truth files. Those files outrank interview chat. If the session is repeating mistakes or has grown too long, start a fresh session and load only those files plus `AGENTS.md`.

When the main thread is long or repeating errors, move bounded work to subagents or start a fresh session. Do not keep loading the lead agent with work a subagent can finish from a small brief.

⸻

## 59. DOCUMENT DISCIPLINE

Default persistent documentation remains exactly:

1. Vision
2. Product Spec
3. UX Design
4. Architecture
5. Quality
6. Decisions
7. Status
8. Open Issues

Add another permanent document only when a concrete project need justifies it.

⸻

## 60. SCALE TO THE PROJECT

ADB must not over-engineer small products.

A small game may require concise Source-of-Truth files and few agents.

A large financial application may require deep definition, many slices, extensive parallel work and strict verification.

The process scales with:

* complexity
* risk
* product size
* integrity requirements

not with ceremony.

Applying ADB means using the points this product needs, at the depth this product needs.

It is forbidden to run every large-project step on a small project, or to produce extra artifacts merely to complete a checklist of points.

⸻

## 61. COMPLETION STANDARD

A product or slice is not complete because:

* code exists
* it compiles
* a demo works
* Unit Tests pass

Completion means, where relevant:

* intended behavior exists
* important edge cases work
* UX is polished
* design is coherent
* specification is satisfied
* relevant tests pass
* independent review passes
* open issues are appropriately resolved
* unnecessary complexity has been removed
* no release-blocking issue remains

⸻

## 62. ULTIMATE ADB RULE

Before BUILD:

Be curious, skeptical and precise.

During BUILD:

Be aggressive about achieving an exceptional product.

During implementation:

Be conservative about adding code, abstractions and moving parts.

During execution:

Parallelize independent work. Serialize dependent work.

During review:

Trust evidence and the Source of Truth, not agent confidence.

The objective is not:

* maximum code
* maximum agent count
* maximum documentation
* maximum architecture

The objective is:

THE SMALLEST COHERENT SYSTEM THAT DELIVERS THE FULL INTENDED PRODUCT AT EXCEPTIONAL QUALITY.
